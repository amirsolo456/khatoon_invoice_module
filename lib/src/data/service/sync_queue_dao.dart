// lib/data/sync/sync_queue_dao.dart
import 'package:drift/drift.dart';
import 'package:invoice_module/src/model/invoice_model.dart';

import '../db/data_base.dart';

class InvoiceDao {
  final AppDatabase db;

  InvoiceDao(this.db);

  // Future<void> enqueue({
  //   required String  description,
  //   required int id,
  //   required String title,
  //   required String payload, // JSON string
  // }) async {
  //   await db
  //       .into(db.invoices)
  //       .insert(onConflict: ()
  //
  //   );
  // }

  Future<List<InvoiceModel  >> fetchPending({int limit = 200}) async {
    return (db.select(db.invoices)
      ..where((t) => t.  description.equals('pending'))
      ..orderBy([(t) => OrderingTerm(expression: t.updatedAt)])
      ..limit(limit))
        .get();
  }

  Future<void> setStatusForIds(List<int> ids, String status) async {
    if (ids.isEmpty) return;

    await (db.update(db.invoices)
      ..where((t) => t.id.isIn(ids)))
        .write(
      InvoicesCompanion(completed:Value((false)),

        updatedAt: Value(DateTime.now()),
      ) as Insertable<InvoiceModel>,
    );
  }

  Future<void> markCompleted(List<int> ids) async {
    await setStatusForIds(ids, 'synced');
  }

  Future<void> markFailed(List<int> ids) async {
    await setStatusForIds(ids, 'failed');
  }

  Future<void> markSyncing(List<int> ids) async {
    await setStatusForIds(ids, 'syncing');
  }

  /// اختیاری: پاک کردن آیتمهای synced از جدول (اگر نخواستیش نگه دار)
  Future<void> removeSynced(List<int> ids) async {
    if (ids.isEmpty) return;
    await (db.delete(
      db.invoices,
    )..where(($InvoicesTable   t) => t.id.isIn(ids))).go();
  }
}
