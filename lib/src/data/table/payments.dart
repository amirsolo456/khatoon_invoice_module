import 'package:drift/drift.dart';
import 'package:invoice_module/src/data/table/invoices.dart';
import 'package:invoice_module/src/data/table/parties.dart';
import 'package:invoice_module/src/model/payments_model.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';



@UseRowClass(PaymentsModel, generateInsertable: true)
class Payments extends Table with SyncColumns{
  IntColumn get id => integer().autoIncrement()();

  IntColumn get invoiceId => integer().references(Invoices, #id)(); // کلید خارجی به فاکتور
  RealColumn get amount => real()();
  TextColumn get direction => text()(); // 'in' یا 'out'
  TextColumn get paymentMethod => text().nullable()();
  IntColumn get fromPartyId => integer().references(Parties, #id)();
  IntColumn get toPartyId => integer().references(Parties, #id)();
  TextColumn get reference => text().nullable()();
  TextColumn get notes => text().nullable()();
  // @override
  // DateTimeColumn get updatedAt => dateTime().nullable();






  @override
  Set<Column> get primaryKey => {id};
}