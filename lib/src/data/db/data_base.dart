import 'package:drift/drift.dart';
import 'package:drift/native.dart'; // یا use SqliteExecutor for platform specific
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../../index.dart';
import '../table/invoice_items.dart';
import '../table/invoices.dart';

import '../table/payments.dart';
import 'data_base.drift.dart';

@DriftDatabase(
  tables: [Invoices, InvoiceItems, Payments, Parties],
  daos: [InvoiceDao, InvoiceItemsDao, PaymentsDao, PartiesDao],
)
final class AppDatabase extends $AppDatabase with SyncDatabaseMixin{
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  factory AppDatabase.open() {
    final dir = Directory
        .current; // تغییر بدی به مسیر مناسب یا از path_provider استفاده کن
    final file = File((dir.path, 'apsqlite').toString());
    return AppDatabase(NativeDatabase(file));
  }

  static QueryExecutor _openConnection() {
    // گزینه‌ای مینیمال، اگر helper سفارشی داری آن را جایگزین کن
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File((dbFolder.path, 'invoice_db.sqlite').toString());
      return NativeDatabase(file);
    });
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
  );
}
