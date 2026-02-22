/*
import 'package:drift/drift.dart';
import 'package:khatoon_shared/index.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';
import 'package:uuid/uuid.dart';

import '../data/db/data_base.dart';
import '../model/invoice_model.dart';

class InvoiceModelRepository {
  InvoiceModelRepository(this._db, syncTable)
    : _writer = SyncWriter< AppDatabase>(_db).forTable(syncTable);

  final AppDatabase _db;
  final _uuid = const Uuid();
  final SyncEntityWriter<InvoiceModel, AppDatabase> _writer;

  Stream<List<InvoiceModel>> watchAll() {
    return (_db.select(_db.invoices)
          ..where(
            ($InvoicesTable t) =>
                t.title.isNull() & t.deletedAtLocal.isNull(),
          )
          ..orderBy([
            (t) => OrderingTerm(expression: t.priority),
            (t) => OrderingTerm(expression: t.title),
          ]))
        .watch();
  }

  // Future<List<InvoiceModel>> getAll() {
  //   return (_db.select(_db.invoice)
  //     ..where((t) => t.deletedAt.isNull() & t.deletedAtLocal.isNull())
  //     ..orderBy([
  //           (t) => OrderingTerm(expression: t.priority),
  //           (t) => OrderingTerm(expression: t.title),
  //     ]))
  //       .get();
  // }

  // Future<InvoiceModel?> getById(int id) async {
  //   return (_db.select(_db.inv)..where((t) => t. == id)).getSingleOrNull();
  // }

  Future<InvoiceModel> create({
    required String title,
    String? description,
    bool completed = false,
    int priority = 3,
    DateTime? dueDate,
  }) async {
    final now = DateTime.now().toUtc();
    final id = _uuid.v4().hashCode;
    final validPriority = priority.clamp(1, 5);

    final invoiceModel = InvoiceModel(
      id: id,

      updatedAt: now,
      invoiceNo: '',
      type: '',
      totalAmount: 0,
      status: '',
      version: 0,
      isDeleted: false,
      createdAt: DateTime.now(),
    );

    await _writer.insertAndEnqueue(invoiceModel, localTimestamp: now);
    return invoiceModel;
  }

  Future<InvoiceModel> update(
    InvoiceModel invoiceModel, {
    String? title,
    String? description,
    bool? completed,
    int? priority,
    DateTime? dueDate,
  }) async {
    final now = DateTime.now().toUtc();
    final validPriority = priority?.clamp(1, 5);

    final updated = invoiceModel.copyWith(
      status: title ?? invoiceModel.status,
      description: description,
      completed: completed ?? invoiceModel.completed,
      dueDate: dueDate,
      updatedAt: now,
    );

    await _writer.replaceAndEnqueue(
      updated,

      // changedFields:  Value(DateTime.now().microsecond).value,
      baseUpdatedAt: invoiceModel.updatedAt,
      localTimestamp: now,
    );

    return updated;
  }

  Future<InvoiceModel> toggleCompleted(InvoiceModel invoiceModel) {
    return update(invoiceModel, completed: !invoiceModel.completed);
  }

  Future<void> delete(InvoiceModel invoiceModel) async {
    final now = DateTime.now().toUtc();
    final deleted = invoiceModel.copyWith(deletedAtLocal: now);
    await _writer.writeAndEnqueueDelete(
      localWrite: () async {
        await _db.update(_db.invoices).replace(deleted.toInsertable());
      },
      id: invoiceModel.id.toString(),
      baseUpdatedAt: invoiceModel.updatedAt ?? DateTime.now(),
      localTimestamp: now,
    );
  }

  Future<int> cleanupDeleted() {
    return (_db.delete(
          _db.invoices,
        )..where((t) => t.deletedAt.isNotNull() | t.deletedAtLocal.isNotNull()))
        .go();
  }

  Future<void> upsertFromServer(InvoiceModel invoiceModel) async {
    await _db
        .into(_db.invoices)
        .insertOnConflictUpdate(invoiceModel.toInsertable());
  }

  Future<void> hardDeleteFromServer(int id) async {
    await (_db.delete(_db.invoices)..where((t) => t.id.equals(id))).go();
  }

  Future<List<int>> getDeletedIds() async {
    final rows =
        await (_db.select(_db.invoices)..where(
              (t) => t.deletedAt.isNotNull() | t.deletedAtLocal.isNotNull(),
            ))
            .get();
    return rows.map((t) => t.id).toList();
  }

  Future<InvoiceModel> createWithId(InvoiceModel invoiceModel) async {
    final now = DateTime.now().toUtc();
    final invoiceModelWithTime = invoiceModel.copyWith(updatedAt: now);
    await _writer.insertAndEnqueue(invoiceModelWithTime, localTimestamp: now);
    return invoiceModelWithTime;
  }
}
*/
