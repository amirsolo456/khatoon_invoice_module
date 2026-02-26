import 'dart:async';

import 'package:drift/drift.dart';
import 'package:invoice_module/src/model/invoice_model.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';
// import 'package:offline_first_sync_drift/src/config.dart';
// import 'package:offline_first_sync_drift/src/conflict_resolution.dart';
// import 'package:offline_first_sync_drift/src/op.dart';
// import 'package:offline_first_sync_drift/src/sync_events.dart';
// import 'package:offline_first_sync_drift/src/syncable_table.dart';
// import 'package:offline_first_sync_drift/src/transport_adapter.dart';

/// Result of conflict resolution.
///

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';



/// Handles conflict resolution for sync operations.
///
/// When a conflict is detected:
/// 1. Stores the conflict for later resolution
/// 2. Notifies listeners (UI shows conflict dialog)
/// 3. User chooses resolution: local, server, or merged
/// 4. Resolution is applied and sync continues
class ConflictHandler extends ChangeNotifier {
  ConflictHandler();

  /// Queue of pending conflicts to resolve.
  final List<ConflictInfo> _pendingConflicts = [];

  /// Currently displayed conflict (if any).
  ConflictInfo? _currentConflict;
  ConflictInfo? get currentConflict => _currentConflict;

  /// Completer for the current conflict resolution.
  Completer<ConflictResolution>? _resolutionCompleter;

  /// Whether there are pending conflicts.
  bool get hasConflicts =>
      _pendingConflicts.isNotEmpty || _currentConflict != null;

  /// Number of pending conflicts.
  int get conflictCount =>
      _pendingConflicts.length + (_currentConflict != null ? 1 : 0);

  /// Sync event log for debugging.
  final List<SyncLogEntry> _log = [];
  List<SyncLogEntry> get log => List.unmodifiable(_log);

  /// Clears the sync log.
  void clearLog() {
    _log.clear();
    notifyListeners();
  }

  /// Maximum log entries to keep in memory.
  static const _maxLogEntries = 100;

  /// Logs a sync event.
  void logEvent(String message, {SyncLogLevel level = SyncLogLevel.info}) {
    _log.add(SyncLogEntry(
      timestamp: DateTime.now(),
      message: message,
      level: level,
    ));
    // Prevent unbounded memory growth
    while (_log.length > _maxLogEntries) {
      _log.removeAt(0);
    }
    notifyListeners();
  }

  /// The conflict resolver function to pass to SyncConfig.
  ///
  /// This is called by the sync engine when a conflict is detected.
  Future<ConflictResolution> resolve(Conflict conflict) async {
    // Parse conflict data safely - malformed data should not crash sync
    final InvoiceModel localTodo;
    final InvoiceModel serverTodo;
    try {
      localTodo = InvoiceModel.fromJson(conflict.localData.cast<String, dynamic>());
      serverTodo = InvoiceModel.fromJson(conflict.serverData.cast<String, dynamic>());
    } catch (e) {
      logEvent(
        'Failed to parse conflict data: $e',
        level: SyncLogLevel.error,
      );
      // Defer resolution on parse error - will retry on next sync
      return const DeferResolution();
    }

    final info = ConflictInfo(
      conflict: conflict,
      localTodo: localTodo,
      serverTodo: serverTodo,
    );

    // logEvent(
    //   'Conflict detected for "${info.localTodo.title}"',
    //   level: SyncLogLevel.warning,
    // );

    // Add to queue
    _pendingConflicts.add(info);

    // If no conflict is currently being resolved, start resolution
    if (_currentConflict == null) {
      return _resolveNext();
    }

    // Wait for this conflict to be resolved
    return _waitForResolution(info);
  }

  Future<ConflictResolution> _resolveNext() async {
    if (_pendingConflicts.isEmpty) {
      return const AcceptServer();
    }

    _currentConflict = _pendingConflicts.removeAt(0);
    _resolutionCompleter = Completer<ConflictResolution>();
    notifyListeners();

    return _resolutionCompleter!.future;
  }

  /// Timeout for user to resolve a conflict before auto-deferring.
  static const _resolutionTimeout = Duration(minutes: 5);

  Future<ConflictResolution> _waitForResolution(ConflictInfo info) async {
    final startTime = DateTime.now();

    // Wait until this conflict becomes current and gets resolved
    while (_pendingConflicts.contains(info) || _currentConflict == info) {
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Check for timeout to prevent infinite waiting
      if (DateTime.now().difference(startTime) > _resolutionTimeout) {
        // logEvent(
        //   'Conflict resolution timed out for "${info.localTodo.title}"',
        //   level: SyncLogLevel.warning,
        // );
        // Auto-defer on timeout - will retry on next sync
        return const DeferResolution();
      }
    }

    // Resolution was applied
    return info.resolution ?? const AcceptServer();
  }

  /// Resolves the current conflict by keeping local version.
  void resolveWithLocal() {
    if (_currentConflict == null || _resolutionCompleter == null) return;

    final conflict = _currentConflict!;
    conflict.resolution = const AcceptClient();

    // logEvent(
    //   'Resolved with local: "${conflict.localTodo.title}"',
    //   level: SyncLogLevel.info,
    // );

    _completeResolution(const AcceptClient());
  }

  /// Resolves the current conflict by keeping server version.
  void resolveWithServer() {
    if (_currentConflict == null || _resolutionCompleter == null) return;

    final conflict = _currentConflict!;
    conflict.resolution = const AcceptServer();

    // logEvent(
    //   'Resolved with server: "${conflict.serverTodo.title}"',
    //   level: SyncLogLevel.info,
    // );

    _completeResolution(const AcceptServer());
  }

  /// Resolves the current conflict with a merged version.
  void resolveWithMerged(InvoiceModel mergedTodo) {
    if (_currentConflict == null || _resolutionCompleter == null) return;

    final conflict = _currentConflict!;
    final mergedData = mergedTodo.toJson();
    final resolution = AcceptMerged(mergedData.cast<String, Object?>());
    conflict.resolution = resolution;

    // logEvent(
    //   'Resolved with merge: "${mergedTodo.title}"',
    //   level: SyncLogLevel.info,
    // );

    _completeResolution(resolution);
  }

  void _completeResolution(ConflictResolution result) {
    final completer = _resolutionCompleter;
    _currentConflict = null;
    _resolutionCompleter = null;

    completer?.complete(result);
    notifyListeners();

    // Process next conflict if any
    if (_pendingConflicts.isNotEmpty) {
      _resolveNext();
    }
  }

  /// Skips the current conflict (uses server version).
  void skipConflict() {
    resolveWithServer();
  }

  @override
  void dispose() {
    // Complete any pending resolution to prevent hanging futures
    if (_resolutionCompleter != null && !_resolutionCompleter!.isCompleted) {
      _resolutionCompleter!.complete(const DeferResolution());
    }
    _pendingConflicts.clear();
    _currentConflict = null;
    super.dispose();
  }
}

/// Information about a sync conflict.
class ConflictInfo {
  ConflictInfo({
    required this.conflict,
    required this.localTodo,
    required this.serverTodo,
  });

  final Conflict conflict;
  final InvoiceModel localTodo;
  final InvoiceModel serverTodo;

  ConflictResolution? resolution;

  /// Gets the fields that differ between local and server.
  List<String> get conflictingFields {
    final fields = <String>[];

    // if (localTodo.title != serverTodo.title) fields.add('title');
    // if (localTodo.description != serverTodo.description) {
    //   fields.add('description');
    // }
    // if (localTodo.completed != serverTodo.completed) fields.add('completed');
    // if (localTodo.priority != serverTodo.priority) fields.add('priority');
    // if (localTodo.dueDate != serverTodo.dueDate) fields.add('dueDate');

    return fields;
  }
}

/// Log entry for sync events.
class SyncLogEntry {
  SyncLogEntry({
    required this.timestamp,
    required this.message,
    required this.level,
  });

  final DateTime timestamp;
  final String message;
  final SyncLogLevel level;
}

/// Log level for sync events.
enum SyncLogLevel {
  info,
  warning,
  error,
}
class ConflictResolutionResult {
  const ConflictResolutionResult({required this.resolved, this.resultData});

  /// Whether the conflict was resolved.
  final bool resolved;

  /// Data after resolution.
  final Map<String, Object?>? resultData;
}

/// Service for sync conflict resolution.
class ConflictService<DB extends GeneratedDatabase> {
  ConflictService({
    required DB db,
    required TransportAdapter transport,
    required Map<String, SyncableTable<dynamic>> tables,
    required SyncConfig config,
    required Map<String, TableConflictConfig> tableConflictConfigs,
    required StreamController<SyncEvent> events,
  }) : _db = db,
        _transport = transport,
        _tables = tables,
        _config = config,
        _tableConflictConfigs = tableConflictConfigs,
        _events = events;

  final DB _db;
  final TransportAdapter _transport;
  final Map<String, SyncableTable<dynamic>> _tables;
  final SyncConfig _config;
  final Map<String, TableConflictConfig> _tableConflictConfigs;
  final StreamController<SyncEvent> _events;

  /// Resolve conflict for an operation.
  Future<ConflictResolutionResult> resolve(
      Op op,
      PushConflict serverConflict,
      ) async {
    final tableConfig = _tableConflictConfigs[op.kind];
    final strategy = tableConfig?.strategy ?? _config.conflictStrategy;

    final localData = op is UpsertOp ? op.payloadJson : <String, Object?>{};
    final changedFields = op is UpsertOp ? op.changedFields : null;

    final conflict = Conflict(
      kind: op.kind,
      entityId: op.id,
      opId: op.opId,
      localData: localData,
      serverData: serverConflict.serverData,
      localTimestamp: op.localTimestamp,
      serverTimestamp: serverConflict.serverTimestamp,
      serverVersion: serverConflict.serverVersion,
      changedFields: changedFields,
    );

    _events.add(ConflictDetectedEvent(conflict: conflict, strategy: strategy));

    final resolution = await _determineResolution(
      conflict,
      strategy,
      tableConfig,
    );

    return _applyResolution(op, conflict, resolution);
  }

  Future<ConflictResolution> _determineResolution(
      Conflict conflict,
      ConflictStrategy strategy,
      TableConflictConfig? tableConfig,
      ) async {
    switch (strategy) {
      case ConflictStrategy.serverWins:
        return const AcceptServer();

      case ConflictStrategy.clientWins:
        return const AcceptClient();

      case ConflictStrategy.lastWriteWins:
        if (conflict.localTimestamp.isAfter(conflict.serverTimestamp)) {
          return const AcceptClient();
        }
        return const AcceptServer();

      case ConflictStrategy.merge:
        final mergeFunc =
            tableConfig?.mergeFunction ??
                _config.mergeFunction ??
                ConflictUtils.defaultMerge;
        final merged = mergeFunc(conflict.localData, conflict.serverData);
        return AcceptMerged(merged);

      case ConflictStrategy.manual:
        final resolver = tableConfig?.resolver ?? _config.conflictResolver;
        if (resolver == null) {
          _events.add(
            ConflictUnresolvedEvent(
              conflict: conflict,
              reason: 'No conflict resolver provided for manual strategy',
            ),
          );
          return const DeferResolution();
        }
        return resolver(conflict);

      case ConflictStrategy.autoPreserve:
        final mergeResult = ConflictUtils.preservingMerge(
          conflict.localData,
          conflict.serverData,
          changedFields: conflict.changedFields,
        );

        _events.add(
          DataMergedEvent(
            kind: conflict.kind,
            entityId: conflict.entityId,
            localFields: mergeResult.localFields,
            serverFields: mergeResult.serverFields,
            mergedData: mergeResult.data,
          ),
        );

        return AcceptMerged(
          mergeResult.data,
          mergeInfo: MergeInfo(
            localFields: mergeResult.localFields,
            serverFields: mergeResult.serverFields,
          ),
        );
    }
  }

  Future<ConflictResolutionResult> _applyResolution(
      Op op,
      Conflict conflict,
      ConflictResolution resolution,
      ) async {
    switch (resolution) {
      case AcceptServer():
        await _applyServerData(conflict);
        _events.add(
          ConflictResolvedEvent(
            conflict: conflict,
            resolution: resolution,
            resultData: conflict.serverData,
          ),
        );
        return ConflictResolutionResult(
          resolved: true,
          resultData: conflict.serverData,
        );

      case AcceptClient():
        final success = await _forcePushOp(op);
        if (success) {
          _events.add(
            ConflictResolvedEvent(
              conflict: conflict,
              resolution: resolution,
              resultData: conflict.localData,
            ),
          );
        }
        return ConflictResolutionResult(
          resolved: success,
          resultData: success ? conflict.localData : null,
        );

      case AcceptMerged(:final mergedData):
        final success = await _pushMergedData(op, mergedData);
        if (success) {
          _events.add(
            ConflictResolvedEvent(
              conflict: conflict,
              resolution: resolution,
              resultData: mergedData,
            ),
          );
        }
        return ConflictResolutionResult(
          resolved: success,
          resultData: success ? mergedData : null,
        );

      case DeferResolution():
        _events.add(
          ConflictUnresolvedEvent(
            conflict: conflict,
            reason: 'Resolution deferred',
          ),
        );
        return const ConflictResolutionResult(resolved: false);

      case DiscardOperation():
        _events.add(
          ConflictResolvedEvent(conflict: conflict, resolution: resolution),
        );
        return const ConflictResolutionResult(resolved: true);
    }
  }

  Future<void> _applyServerData(Conflict conflict) async {
    final tableConfig = _tables[conflict.kind];
    if (tableConfig == null) return;

    final entity = tableConfig.fromJson(conflict.serverData);
    await _db
        .into(tableConfig.table)
        .insertOnConflictUpdate(tableConfig.getInsertable(entity));
  }

  Future<bool> _forcePushOp(Op op) async {
    var retries = 0;
    while (retries < _config.maxConflictRetries) {
      final result = await _transport.forcePush(op);

      if (result is PushSuccess) {
        return true;
      }

      if (result is PushConflict) {
        retries++;
        if (retries < _config.maxConflictRetries) {
          await Future<void>.delayed(_config.conflictRetryDelay);
        }
        continue;
      }

      return false;
    }
    return false;
  }

  Future<bool> _pushMergedData(Op op, Map<String, Object?> mergedData) async {
    if (op is! UpsertOp) return false;

    final mergedOp = UpsertOp(
      opId: op.opId,
      kind: op.kind,
      id: op.id,
      localTimestamp: DateTime.now().toUtc(),
      payloadJson: mergedData,
    );

    var retries = 0;
    while (retries < _config.maxConflictRetries) {
      final result = await _transport.forcePush(mergedOp);

      if (result is PushSuccess) {
        final tableConfig = _tables[op.kind];
        if (tableConfig != null) {
          final entity = tableConfig.fromJson(mergedData);
          await _db
              .into(tableConfig.table)
              .insertOnConflictUpdate(tableConfig.getInsertable(entity));
        }
        return true;
      }

      if (result is PushConflict) {
        retries++;
        if (retries < _config.maxConflictRetries) {
          await Future<void>.delayed(_config.conflictRetryDelay);
        }
        continue;
      }

      return false;
    }
    return false;
  }
}