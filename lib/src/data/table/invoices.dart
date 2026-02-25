import 'package:drift/drift.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';

import '../../model/invoice_model.dart';


@UseRowClass(InvoiceModel, generateInsertable: true)
class Invoices extends Table with SyncColumns {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get description => text().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  IntColumn get priority => integer().withDefault(const Constant(3))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get invoiceNo => text()();
  TextColumn get type => text()();
  IntColumn get partyId => integer().nullable()(); // foreign key to parties
  RealColumn get totalAmount => real()();
  TextColumn get status => text()();



  @override
  Set<Column> get primaryKey => {id};
}
