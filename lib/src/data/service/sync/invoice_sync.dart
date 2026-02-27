// در فایل مثلاً lib/data/sync/sync_config.dart
import 'package:invoice_module/index.dart';
// import 'package:invoice_module/src/syncable_table.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';

SyncableTable<InvoiceModel> invoiceSyncTable(AppDatabase db) =>
    SyncableTable<InvoiceModel>(
      kind: 'invoice',
      fromJson: InvoiceModel.fromJson,
      toJson: (e) => e.toJson(),
      toInsertable: (e) => e.toInsertable(),
      getId: (e) => e.id,
      getUpdatedAt: (e) => e.updatedAt.toUtc(),
      table: db.invoices, // حتماً UTC باشه
    );

SyncableTable<PaymentsModel> paymentSyncTable(AppDatabase db) =>
    SyncableTable<PaymentsModel>(
      kind: 'payment',
      fromJson: PaymentsModel.fromJson,
      toJson: (e) => e.toJson(),
      toInsertable: (e) => e.toInsertable(),
      getId: (e) => e.id,
      getUpdatedAt: (e) => e.updatedAt.toUtc(),
      // حتماً UTC باشه
      table: db.payments, // حتماً UTC باشه
    );

SyncableTable<InvoiceItemsModel> invoiceItemSyncTable(AppDatabase db) =>
    SyncableTable<InvoiceItemsModel>(
      kind: 'invoiceItem',
      fromJson: InvoiceItemsModel.fromJson,
      toJson: (e) => e.toJson(),
      toInsertable: (e) => e.toInsertable(),
      getId: (e) => e.id.toString(),
      getUpdatedAt: (e) => e.updatedAt.toUtc(),
      // حتماً UTC باشه
      table: db.invoiceItems, // حتماً UTC باشه
    );

SyncableTable<PartyModel> partiesItemSyncTable(AppDatabase db) =>
    SyncableTable<PartyModel>(
      kind: 'parties',
      fromJson: PartyModel.fromJson,
      toJson: (e) => e.toJson(),
      toInsertable: (e) => e.toInsertable(),
      getId: (e) => e.id.toString(),
      getUpdatedAt: (e) => e.updatedAt.toUtc(),
      // حتماً UTC باشه
      table: db.parties, // حتماً UTC باشه
    );

List<SyncableTable> tablesSyncTable(AppDatabase db) => [
  invoiceSyncTable(db),
  paymentSyncTable(db),
  invoiceItemSyncTable(db),
];

class SyncTables {
  final AppDatabase db;
  final Map<String, SyncableTable<dynamic>> _map;

  SyncTables(this.db)
    : _map = {
        'invoice': invoiceSyncTable(db),
        'payment': paymentSyncTable(db),
        'invoiceItem': invoiceItemSyncTable(db),
        'parties': partiesItemSyncTable(db),
      };

  SyncableTable<InvoiceModel> get invoice =>
      _map['invoice']! as SyncableTable<InvoiceModel>;

  SyncableTable<PaymentsModel> get payment =>
      _map['payment']! as SyncableTable<PaymentsModel>;

  SyncableTable<PartyModel> get parties =>
      _map['parties']! as SyncableTable<PartyModel>;

  SyncableTable<InvoiceItemsModel> get invoiceItems =>
      _map['invoiceItem']! as SyncableTable<InvoiceItemsModel>;
}
