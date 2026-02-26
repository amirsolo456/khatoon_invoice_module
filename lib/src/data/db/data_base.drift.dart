// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:invoice_module/src/data/service/invoice_dao.dart' as i1;
import 'package:invoice_module/src/data/db/data_base.dart' as i2;
import 'package:invoice_module/src/data/service/payments_dao.dart' as i3;
import 'package:invoice_module/src/data/service/parties_dao.dart' as i4;

abstract class $AppDatabase extends i0.GeneratedDatabase {
  $AppDatabase(i0.QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final i1.InvoiceDao invoiceDao = i1.InvoiceDao(this as i2.AppDatabase);
  late final i3.PaymentsDao paymentsDao = i3.PaymentsDao(
    this as i2.AppDatabase,
  );
  late final i4.PartiesDao partiesDao = i4.PartiesDao(this as i2.AppDatabase);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $AppDatabaseManager {
  final $AppDatabase _db;
  $AppDatabaseManager(this._db);
}
