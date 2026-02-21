import 'package:drift/drift.dart';
import 'package:drift/native.dart'; // یا use SqliteExecutor for platform specific
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../model/invoice_model.dart';
import '../service/sync_queue_dao.dart';
import '../table/invoices.dart';

part 'data_base.g.dart';

@DriftDatabase(tables: [Invoices], daos: [InvoiceDao])
final class AppDatabase extends _$AppDatabase {
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
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // اگر syncOutboxMeta تولید شده باشد این کار درست است:
        await m.createTable($InvoicesTable(attachedDatabase));
      }
    },
  );

  @override
  String $expandVar(int start, int amount) {
    // TODO: implement $expandVar
    throw UnimplementedError();
  }

  @override
  GenerationContext $write(
    Component component, {
    bool? hasMultipleTables,
    int? startIndex,
  }) {
    // TODO: implement $write
    throw UnimplementedError();
  }

  @override
  GenerationContext $writeInsertable(
    TableInfo<Table, dynamic> table,
    Insertable<dynamic> insertable, {
    int? startIndex,
  }) {
    // TODO: implement $writeInsertable
    throw UnimplementedError();
  }

  @override
  T alias<T, D>(ResultSetImplementation<T, D> table, String alias) {
    // TODO: implement alias
    throw UnimplementedError();
  }

  @override
  // TODO: implement allTables
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      throw UnimplementedError();

  // TODO: implement attachedDatabase
  @override
  GeneratedDatabase get attachedDatabase => throw UnimplementedError();

  @override
  Future<void> beforeOpen(QueryExecutor executor, OpeningDetails details) {
    // TODO: implement beforeOpen
    throw UnimplementedError();
  }

  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  // TODO: implement connection
  DatabaseConnection get connection => throw UnimplementedError();

  @override
  Migrator createMigrator() {
    // TODO: implement createMigrator
    throw UnimplementedError();
  }

  @override
  Future<int> customInsert(
    String query, {
    List<Variable<Object>> variables = const [],
    Set<ResultSetImplementation<dynamic, dynamic>>? updates,
  }) {
    // TODO: implement customInsert
    throw UnimplementedError();
  }
}
