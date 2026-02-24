import 'package:invoice_module/index.dart';
import 'package:invoice_module/src/data/table/invoices.drift.dart';
import 'package:invoice_module/src/syncable_table.dart' as sync;




sync.SyncableTable<InvoiceModel> invoiceSyncTable(AppDatabase db) => db.invoices.syncTable  (
  fromJson: InvoiceModel.fromJson,
  toJson: (t) => t.toJson(),
  toInsertable: (t) => t.toInsertable(),
  getId: (t) => t.id.toString(),
  getUpdatedAt: (t) => t.updatedAt,
);