
import 'package:drift/drift.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';
import '../../model/invoice_items_model.dart';
import '../../model/invoice_model.dart';
import '../../model/party_model.dart';
import '../../model/payments_model.dart';
import 'package:drift_flutter/drift_flutter.dart';
// ✅ اضافه کنید این خط


part 'data_base.g.dart';

// باقی imports شما...

@DriftDatabase(
  include: {'package:offline_first_sync_drift/src/sync_tables.drift'},
  tables: [
    Invoices,
    InvoiceItems,
    Parties,
    Payments,

  ],
)
class AppDatabase extends _$AppDatabase  with SyncDatabaseMixin {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// Open the database in a file.
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'todo_advanced');
  }
  static AppDatabase open({String name = 'todo_advanced'}) {
    return AppDatabase(driftDatabase(name: name));
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // migration logic
    },
  );

// ... باقی کد
}