/*
// در فایل مثلاً lib/data/sync/sync_config.dart
import 'package:invoice_module/index.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart' hide SyncableTable;

SyncableTable<Invoices> todoSyncTable(AppDatabase db) => SyncableTable<Invoices>(
  kind: 'todos',
  table: db.in.,
  fromJson: Todo.fromJson,
  toJson: (t) => t.toJson(),
  toInsertable: (t) => t.toInsertable(),
  getId: (t) => t.id,
  getUpdatedAt: (t) => t.updatedAt,
);
List<SyncableTable> invoiceSyncTable(AppDatabase db) => [
  db.invoices.syncTable(
    kind: 'invoice',
    fromJson: InvoiceModel.fromJson,
    toJson: (e) => e.toJson(),
    toInsertable: (e) => e.toInsertable(),
    getId: (e) => e.id,
    getUpdatedAt: (e) => e.updatedAt!.toUtc(), // حتماً UTC باشه
  ),
  // بقیه جداول...
];*/
