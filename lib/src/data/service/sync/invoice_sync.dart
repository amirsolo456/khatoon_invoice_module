// در فایل مثلاً lib/data/sync/sync_config.dart
import 'package:invoice_module/index.dart';

SyncableTable<InvoiceModel> invoiceSyncTable(AppDatabase db) =>
    db.invoices.syncTable(
      kind: 'invoice',
      fromJson: InvoiceModel.fromJson,
      toJson: (e) => e.toJson(),
      toInsertable: (e) => e.toInsertable(),
      getId: (e) => e.id,
      getUpdatedAt: (e) => e.updatedAt.toUtc(), // حتماً UTC باشه
    );

SyncableTable<PaymentsModel> paymentSyncTable(AppDatabase db) =>
    db.payments.syncTable(
      kind: 'payment',
      fromJson: PaymentsModel.fromJson,
      toJson: (e) => e.toJson(),
      toInsertable: (e) => e.toInsertable(),
      getId: (e) => e.id,
      getUpdatedAt: (e) => e.updatedAt.toUtc(), // حتماً UTC باشه
    );

SyncableTable<InvoiceItemsModel> invoiceItemSyncTable(AppDatabase db) =>
    db.invoiceItems.syncTable(
      kind: 'invoiceItem',
      fromJson: InvoiceItemsModel.fromJson,
      toJson: (e) => e.toJson(),
      toInsertable: (e) => e.toInsertable(),
      getId: (e) => e.id.toString(),
      getUpdatedAt: (e) => e.updatedAt.toUtc(), // حتماً UTC باشه
    );

List<SyncableTable> tablesSyncTable(AppDatabase db) => [
  invoiceSyncTable(db),
  paymentSyncTable(db),
  invoiceItemSyncTable(db),
];
