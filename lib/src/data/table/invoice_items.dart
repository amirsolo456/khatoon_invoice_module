import 'package:drift/drift.dart';
import 'package:invoice_module/src/data/table/invoices.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';

import '../../model/invoice_items_model.dart';

@UseRowClass(InvoiceItemsModel, generateInsertable: true)
class InvoiceItems extends Table with SyncColumns{
  IntColumn get id => integer()(); // کلید اصلی (از سرور)
  IntColumn get invoiceId => integer().references(Invoices, #id)(); // کلید خارجی به فاکتور
  IntColumn get productId => integer().nullable()();
  TextColumn get description => text().nullable()();
  RealColumn get quantity => real()();
  RealColumn get unitPrice => real()();
  RealColumn get lineTotal => real()(); // می‌تواند با generatedAs محاسبه شود
  IntColumn get partyId => integer().nullable()();
  IntColumn get sellerEmployeeId => integer().nullable()();
 
  BoolColumn get isDeleted => boolean()();
  DateTimeColumn get createdAt => dateTime()();


  @override
  Set<Column> get primaryKey => {id};
}