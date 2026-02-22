// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:invoice_module/src/data/db/data_base.dart' as i1;
import 'package:invoice_module/src/data/table/invoices.drift.dart' as i2;
import 'package:drift/internal/modular.dart' as i3;
import 'package:invoice_module/src/data/table/invoice_items.drift.dart' as i4;
import 'package:invoice_module/src/data/table/payments.drift.dart' as i5;

mixin $InvoiceDaoMixin on i0.DatabaseAccessor<i1.AppDatabase> {
  i2.$InvoicesTable get invoices => i3.ReadDatabaseContainer(attachedDatabase)
      .resultSet<i2.$InvoicesTable>('invoices');
  i4.$InvoiceItemsTable get invoiceItems =>
      i3.ReadDatabaseContainer(attachedDatabase)
          .resultSet<i4.$InvoiceItemsTable>('invoice_items');
  i5.$PaymentsTable get payments => i3.ReadDatabaseContainer(attachedDatabase)
      .resultSet<i5.$PaymentsTable>('payments');
  InvoiceDaoManager get managers => InvoiceDaoManager(this);
}

class InvoiceDaoManager {
  final $InvoiceDaoMixin _db;
  InvoiceDaoManager(this._db);
  i2.$$InvoicesTableTableManager get invoices =>
      i2.$$InvoicesTableTableManager(_db.attachedDatabase, _db.invoices);
  i4.$$InvoiceItemsTableTableManager get invoiceItems => i4
      .$$InvoiceItemsTableTableManager(_db.attachedDatabase, _db.invoiceItems);
  i5.$$PaymentsTableTableManager get payments =>
      i5.$$PaymentsTableTableManager(_db.attachedDatabase, _db.payments);
}
