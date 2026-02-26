// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:offline_first_sync_drift/src/tables/cursors.drift.dart' as i1;
import 'package:offline_first_sync_drift/src/tables/outbox.drift.dart' as i2;
import 'package:invoice_module/src/model/party_model.drift.dart' as i3;
import 'package:invoice_module/src/model/invoice_model.drift.dart' as i4;
import 'package:invoice_module/src/model/invoice_items_model.drift.dart' as i5;
import 'package:invoice_module/src/model/payments_model.drift.dart' as i6;

abstract class $AppDatabase extends i0.GeneratedDatabase {
  $AppDatabase(i0.QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final i1.$SyncCursorsTable syncCursors = i1.$SyncCursorsTable(this);
  late final i2.$SyncOutboxTable syncOutbox = i2.$SyncOutboxTable(this);
  late final i3.$PartiesTable parties = i3.$PartiesTable(this);
  late final i4.$InvoicesTable invoices = i4.$InvoicesTable(this);
  late final i5.$InvoiceItemsTable invoiceItems = i5.$InvoiceItemsTable(this);
  late final i6.$PaymentsTable payments = i6.$PaymentsTable(this);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    syncCursors,
    syncOutbox,
    parties,
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
  i1.$$SyncCursorsTableTableManager get syncCursors =>
      i1.$$SyncCursorsTableTableManager(_db, _db.syncCursors);
  i2.$$SyncOutboxTableTableManager get syncOutbox =>
      i2.$$SyncOutboxTableTableManager(_db, _db.syncOutbox);
  i3.$$PartiesTableTableManager get parties =>
      i3.$$PartiesTableTableManager(_db, _db.parties);
  i4.$$InvoicesTableTableManager get invoices =>
      i4.$$InvoicesTableTableManager(_db, _db.invoices);
  i5.$$InvoiceItemsTableTableManager get invoiceItems =>
      i5.$$InvoiceItemsTableTableManager(_db, _db.invoiceItems);
  i6.$$PaymentsTableTableManager get payments =>
      i6.$$PaymentsTableTableManager(_db, _db.payments);
}
