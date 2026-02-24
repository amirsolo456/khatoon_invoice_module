import 'package:drift/drift.dart';
import 'package:invoice_module/src/model/payments_model.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';


import 'invoices.dart';

@UseRowClass(PaymentsModel, generateInsertable: true)
class Payments extends Table with SyncColumns{
  IntColumn get id => integer()(); // کلید اصلی (از سرور)

  IntColumn get invoiceId => integer().references(Invoices, #id)(); // کلید خارجی به فاکتور
  RealColumn get amount => real()();
  TextColumn get direction => text()(); // 'in' یا 'out'
  TextColumn get paymentMethod => text().nullable()();
  IntColumn get fromPartyId => integer().nullable()();
  IntColumn get toPartyId => integer().nullable()();
  TextColumn get reference => text().nullable()();
  TextColumn get notes => text().nullable()();





  @override
  Set<Column> get primaryKey => {id};
}