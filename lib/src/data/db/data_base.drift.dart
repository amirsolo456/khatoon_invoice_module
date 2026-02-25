// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:invoice_module/src/data/table/invoices.drift.dart' as i1;
import 'package:invoice_module/src/data/table/invoice_items.drift.dart' as i2;
import 'package:invoice_module/src/data/table/payments.drift.dart' as i3;
import 'package:invoice_module/src/data/service/payments_dao.dart' as i4;
import 'package:invoice_module/src/data/db/data_base.dart' as i5;

abstract class $AppDatabase extends i0.GeneratedDatabase {
  $AppDatabase(i0.QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final i1.$InvoicesTable invoices = i1.$InvoicesTable(this);
  late final i2.$InvoiceItemsTable invoiceItems = i2.$InvoiceItemsTable(this);
  late final i3.$PaymentsTable payments = i3.$PaymentsTable(this);
  late final i4.PaymentsDao paymentsDao = i4.PaymentsDao(
    this as i5.AppDatabase,
  );
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    invoices,
    invoiceItems,
    payments,
  ];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $AppDatabaseManager {
  final $AppDatabase _db;
  $AppDatabaseManager(this._db);
  i1.$$InvoicesTableTableManager get invoices =>
      i1.$$InvoicesTableTableManager(_db, _db.invoices);
  i2.$$InvoiceItemsTableTableManager get invoiceItems =>
      i2.$$InvoiceItemsTableTableManager(_db, _db.invoiceItems);
  i3.$$PaymentsTableTableManager get payments =>
      i3.$$PaymentsTableTableManager(_db, _db.payments);
}
