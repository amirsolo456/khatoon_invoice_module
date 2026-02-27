import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:invoice_module/src/data/db/data_base.dart' show AppDatabase;
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';
import 'package:offline_first_sync_drift_rest/offline_first_sync_drift_rest.dart';

String _sanitizeError(Object error) {
  final message = error.toString();
  if (message.contains('SocketException')) {
    return 'Network connection failed. Check your internet connection.';
  }
  if (message.contains('TimeoutException')) {
    return 'Request timed out. Server may be slow or unavailable.';
  }
  if (message.contains('HandshakeException')) {
    return 'Secure connection failed. Check server certificate.';
  }
  if (message.contains('FormatException')) {
    return 'Server returned invalid data.';
  }
  if (message.length > 100) {
    return 'Sync failed. Please try again.';
  }
  return message;
}

class SyncService extends ChangeNotifier {
  SyncService({
    required AppDatabase db,
    required String baseUrl,
    required List<SyncableTable> todoSync,
    this.pushOnOutboxChanges = true,
    this.pullOnStartup = true,
    this.autoInterval = const Duration(minutes: 5),
    this.pushDebounce = const Duration(seconds: 2),
    http.Client? httpClient,
    int maxRetries = 5,
    int maxPushRetries = 5,
  }) : _baseUri = Uri.parse(baseUrl),
       _httpClient = httpClient ?? http.Client() {
    final config = SyncConfig(
      conflictStrategy: ConflictStrategy.autoPreserve,
      pageSize: 500,
      maxPushRetries: maxPushRetries,
      maxConflictRetries: 5,
    );

    for (int i = 0; 0 < todoSync.length; i++) {
      _engine = createRestSyncEngine<AppDatabase>(
        db: db,
        base: _baseUri,
        token: () async => '',
        tables: [todoSync[i]],
        config: config,
        client: _httpClient,
        maxRetries: maxRetries,
      );
    }
  }

  final Uri _baseUri;
  final http.Client _httpClient;
  final bool pushOnOutboxChanges;
  final bool pullOnStartup;
  final Duration? autoInterval;
  final Duration pushDebounce;

  late final SyncEngine<AppDatabase> _engine;

  // late final SyncCoordinator _coordinator;
  late final StreamSubscription<SyncEvent> _subscription;

  SyncEngine<AppDatabase> get engine => _engine;

  SyncStatus _status = SyncStatus.idle;

  SyncStatus get status => _status;

  String? _error;

  String? get error => _error;

  SyncStats? _lastStats;

  SyncStats? get lastStats => _lastStats;

  // SyncRunResult? _lastRun;
  // SyncRunResult? get lastRun => _lastRun;

  double _progress = 0.0;

  double get progress => _progress;

  bool get isSyncing => _status == SyncStatus.syncing;

  Stream<SyncEvent> get events => _engine.events;

  // Stream<int> get pendingCountStream => _engine.watchPendingPushCount();

  // Future<void> start() async {
  //   await _coordinator.start();
  // }

  Future<SyncStats> sync() async {
    _status = SyncStatus.syncing;
    _error = null;
    _progress = 0.0;
    notifyListeners();

    try {
      final run = await _engine.sync();

      // _lastRun = run;

      _status = SyncStatus.idle;
      notifyListeners();
      return run.copyWith();
    } catch (e) {
      _error = _sanitizeError(e);
      _status = SyncStatus.error;
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> checkHealth() async {
    try {
      final response = await _httpClient.get(_baseUri.resolve('/health'));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (_) {
      return false;
    }
  }

  void startAuto({Duration interval = const Duration(minutes: 5)}) {
    _engine.startAuto(interval: interval);
  }

  void stopAuto() {
    _engine.stopAuto();
  }

  // Future<int> getPendingCount() async {
  //   final ops = await _db.takeOutbox(limit : _maxOutboxTryCount);
  //   return ops.length;
  // }

  @override
  void dispose() {
    _subscription.cancel();
    // _coordinator.dispose();
    _engine.dispose();
    _httpClient.close();
    super.dispose();
  }
}

enum SyncStatus { idle, syncing, error }

/// One-liner helper that creates [RestTransport] and [SyncEngine] together.
SyncEngine<DB> createRestSyncEngine<DB extends GeneratedDatabase>({
  required DB db,
  required Uri base,
  required AuthTokenProvider token,
  required List<SyncableTable<dynamic>> tables,
  SyncConfig config = const SyncConfig(),
  Map<String, TableConflictConfig>? tableConflictConfigs,
  http.Client? client,
  Duration backoffMin = const Duration(seconds: 1),
  Duration backoffMax = const Duration(minutes: 2),
  int maxRetries = 5,
  int pushConcurrency = 1,
  bool enableBatch = false,
  int batchSize = 100,
  String batchPath = 'batch',
}) {
  final transport = RestTransport(
    base: base,
    token: token,
    client: client,
    backoffMin: backoffMin,
    backoffMax: backoffMax,
    maxRetries: maxRetries,
    pushConcurrency: pushConcurrency,
    enableBatch: enableBatch,
    batchSize: batchSize,
    batchPath: batchPath,
  );

  return SyncEngine<DB>(
    db: db,
    transport: transport,
    tables: tables,
    config: config,
    tableConflictConfigs: tableConflictConfigs,
  );
}
