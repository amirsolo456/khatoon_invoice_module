// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:invoice_module/src/model/invoice_items_model.dart' as i1;
import 'package:invoice_module/src/data/table/invoice_items.drift.dart' as i2;
import 'package:invoice_module/src/data/table/invoice_items.dart' as i3;
import 'package:invoice_module/src/data/table/invoices.drift.dart' as i4;
import 'package:drift/internal/modular.dart' as i5;

typedef $$InvoiceItemsTableCreateCompanionBuilder = i2.InvoiceItemsCompanion
    Function({
  required DateTime updatedAt,
  i0.Value<DateTime?> deletedAt,
  i0.Value<DateTime?> deletedAtLocal,
  i0.Value<int> id,
  required int invoiceId,
  i0.Value<int?> productId,
  i0.Value<String?> description,
  required double quantity,
  required double unitPrice,
  required double lineTotal,
  i0.Value<int?> partyId,
  i0.Value<int?> sellerEmployeeId,
  required bool isDeleted,
  required DateTime createdAt,
});
typedef $$InvoiceItemsTableUpdateCompanionBuilder = i2.InvoiceItemsCompanion
    Function({
  i0.Value<DateTime> updatedAt,
  i0.Value<DateTime?> deletedAt,
  i0.Value<DateTime?> deletedAtLocal,
  i0.Value<int> id,
  i0.Value<int> invoiceId,
  i0.Value<int?> productId,
  i0.Value<String?> description,
  i0.Value<double> quantity,
  i0.Value<double> unitPrice,
  i0.Value<double> lineTotal,
  i0.Value<int?> partyId,
  i0.Value<int?> sellerEmployeeId,
  i0.Value<bool> isDeleted,
  i0.Value<DateTime> createdAt,
});

final class $$InvoiceItemsTableReferences extends i0.BaseReferences<
    i0.GeneratedDatabase, i2.$InvoiceItemsTable, i1.InvoiceItemsModel> {
  $$InvoiceItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static i4.$InvoicesTable _invoiceIdTable(i0.GeneratedDatabase db) =>
      i5.ReadDatabaseContainer(db)
          .resultSet<i4.$InvoicesTable>('invoices')
          .createAlias(i0.$_aliasNameGenerator(
              i5.ReadDatabaseContainer(db)
                  .resultSet<i2.$InvoiceItemsTable>('invoice_items')
                  .invoiceId,
              i5.ReadDatabaseContainer(db)
                  .resultSet<i4.$InvoicesTable>('invoices')
                  .id));

  i4.$$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = i4
        .$$InvoicesTableTableManager(
            $_db,
            i5.ReadDatabaseContainer($_db)
                .resultSet<i4.$InvoicesTable>('invoices'))
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return i0.ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$InvoiceItemsTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i2.$InvoiceItemsTable> {
  $$InvoiceItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<DateTime> get deletedAtLocal => $composableBuilder(
      column: $table.deletedAtLocal,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get description => $composableBuilder(
      column: $table.description,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<double> get unitPrice => $composableBuilder(
      column: $table.unitPrice, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<double> get lineTotal => $composableBuilder(
      column: $table.lineTotal, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get partyId => $composableBuilder(
      column: $table.partyId, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get sellerEmployeeId => $composableBuilder(
      column: $table.sellerEmployeeId,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => i0.ColumnFilters(column));

  i4.$$InvoicesTableFilterComposer get invoiceId {
    final i4.$$InvoicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceId,
        referencedTable: i5.ReadDatabaseContainer($db)
            .resultSet<i4.$InvoicesTable>('invoices'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i4.$$InvoicesTableFilterComposer(
              $db: $db,
              $table: i5.ReadDatabaseContainer($db)
                  .resultSet<i4.$InvoicesTable>('invoices'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoiceItemsTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i2.$InvoiceItemsTable> {
  $$InvoiceItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<DateTime> get deletedAtLocal => $composableBuilder(
      column: $table.deletedAtLocal,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get productId => $composableBuilder(
      column: $table.productId,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<double> get unitPrice => $composableBuilder(
      column: $table.unitPrice,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<double> get lineTotal => $composableBuilder(
      column: $table.lineTotal,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get partyId => $composableBuilder(
      column: $table.partyId, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get sellerEmployeeId => $composableBuilder(
      column: $table.sellerEmployeeId,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => i0.ColumnOrderings(column));

  i4.$$InvoicesTableOrderingComposer get invoiceId {
    final i4.$$InvoicesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceId,
        referencedTable: i5.ReadDatabaseContainer($db)
            .resultSet<i4.$InvoicesTable>('invoices'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i4.$$InvoicesTableOrderingComposer(
              $db: $db,
              $table: i5.ReadDatabaseContainer($db)
                  .resultSet<i4.$InvoicesTable>('invoices'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoiceItemsTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i2.$InvoiceItemsTable> {
  $$InvoiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get deletedAtLocal => $composableBuilder(
      column: $table.deletedAtLocal, builder: (column) => column);

  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  i0.GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  i0.GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  i0.GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  i0.GeneratedColumn<double> get lineTotal =>
      $composableBuilder(column: $table.lineTotal, builder: (column) => column);

  i0.GeneratedColumn<int> get partyId =>
      $composableBuilder(column: $table.partyId, builder: (column) => column);

  i0.GeneratedColumn<int> get sellerEmployeeId => $composableBuilder(
      column: $table.sellerEmployeeId, builder: (column) => column);

  i0.GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  i4.$$InvoicesTableAnnotationComposer get invoiceId {
    final i4.$$InvoicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceId,
        referencedTable: i5.ReadDatabaseContainer($db)
            .resultSet<i4.$InvoicesTable>('invoices'),
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            i4.$$InvoicesTableAnnotationComposer(
              $db: $db,
              $table: i5.ReadDatabaseContainer($db)
                  .resultSet<i4.$InvoicesTable>('invoices'),
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoiceItemsTableTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i2.$InvoiceItemsTable,
    i1.InvoiceItemsModel,
    i2.$$InvoiceItemsTableFilterComposer,
    i2.$$InvoiceItemsTableOrderingComposer,
    i2.$$InvoiceItemsTableAnnotationComposer,
    $$InvoiceItemsTableCreateCompanionBuilder,
    $$InvoiceItemsTableUpdateCompanionBuilder,
    (i1.InvoiceItemsModel, i2.$$InvoiceItemsTableReferences),
    i1.InvoiceItemsModel,
    i0.PrefetchHooks Function({bool invoiceId})> {
  $$InvoiceItemsTableTableManager(
      i0.GeneratedDatabase db, i2.$InvoiceItemsTable table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i2.$$InvoiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i2.$$InvoiceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i2.$$InvoiceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<DateTime> updatedAt = const i0.Value.absent(),
            i0.Value<DateTime?> deletedAt = const i0.Value.absent(),
            i0.Value<DateTime?> deletedAtLocal = const i0.Value.absent(),
            i0.Value<int> id = const i0.Value.absent(),
            i0.Value<int> invoiceId = const i0.Value.absent(),
            i0.Value<int?> productId = const i0.Value.absent(),
            i0.Value<String?> description = const i0.Value.absent(),
            i0.Value<double> quantity = const i0.Value.absent(),
            i0.Value<double> unitPrice = const i0.Value.absent(),
            i0.Value<double> lineTotal = const i0.Value.absent(),
            i0.Value<int?> partyId = const i0.Value.absent(),
            i0.Value<int?> sellerEmployeeId = const i0.Value.absent(),
            i0.Value<bool> isDeleted = const i0.Value.absent(),
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
          }) =>
              i2.InvoiceItemsCompanion(
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            deletedAtLocal: deletedAtLocal,
            id: id,
            invoiceId: invoiceId,
            productId: productId,
            description: description,
            quantity: quantity,
            unitPrice: unitPrice,
            lineTotal: lineTotal,
            partyId: partyId,
            sellerEmployeeId: sellerEmployeeId,
            isDeleted: isDeleted,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            required DateTime updatedAt,
            i0.Value<DateTime?> deletedAt = const i0.Value.absent(),
            i0.Value<DateTime?> deletedAtLocal = const i0.Value.absent(),
            i0.Value<int> id = const i0.Value.absent(),
            required int invoiceId,
            i0.Value<int?> productId = const i0.Value.absent(),
            i0.Value<String?> description = const i0.Value.absent(),
            required double quantity,
            required double unitPrice,
            required double lineTotal,
            i0.Value<int?> partyId = const i0.Value.absent(),
            i0.Value<int?> sellerEmployeeId = const i0.Value.absent(),
            required bool isDeleted,
            required DateTime createdAt,
          }) =>
              i2.InvoiceItemsCompanion.insert(
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            deletedAtLocal: deletedAtLocal,
            id: id,
            invoiceId: invoiceId,
            productId: productId,
            description: description,
            quantity: quantity,
            unitPrice: unitPrice,
            lineTotal: lineTotal,
            partyId: partyId,
            sellerEmployeeId: sellerEmployeeId,
            isDeleted: isDeleted,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    i2.$$InvoiceItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({invoiceId = false}) {
            return i0.PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends i0.TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (invoiceId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.invoiceId,
                    referencedTable:
                        i2.$$InvoiceItemsTableReferences._invoiceIdTable(db),
                    referencedColumn:
                        i2.$$InvoiceItemsTableReferences._invoiceIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$InvoiceItemsTableProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i2.$InvoiceItemsTable,
    i1.InvoiceItemsModel,
    i2.$$InvoiceItemsTableFilterComposer,
    i2.$$InvoiceItemsTableOrderingComposer,
    i2.$$InvoiceItemsTableAnnotationComposer,
    $$InvoiceItemsTableCreateCompanionBuilder,
    $$InvoiceItemsTableUpdateCompanionBuilder,
    (i1.InvoiceItemsModel, i2.$$InvoiceItemsTableReferences),
    i1.InvoiceItemsModel,
    i0.PrefetchHooks Function({bool invoiceId})>;

class $InvoiceItemsTable extends i3.InvoiceItems
    with i0.TableInfo<$InvoiceItemsTable, i1.InvoiceItemsModel> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceItemsTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _updatedAtMeta =
      const i0.VerificationMeta('updatedAt');
  @override
  late final i0.GeneratedColumn<DateTime> updatedAt =
      i0.GeneratedColumn<DateTime>('updated_at', aliasedName, false,
          type: i0.DriftSqlType.dateTime, requiredDuringInsert: true);
  static const i0.VerificationMeta _deletedAtMeta =
      const i0.VerificationMeta('deletedAt');
  @override
  late final i0.GeneratedColumn<DateTime> deletedAt =
      i0.GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
          type: i0.DriftSqlType.dateTime, requiredDuringInsert: false);
  static const i0.VerificationMeta _deletedAtLocalMeta =
      const i0.VerificationMeta('deletedAtLocal');
  @override
  late final i0.GeneratedColumn<DateTime> deletedAtLocal =
      i0.GeneratedColumn<DateTime>('deleted_at_local', aliasedName, true,
          type: i0.DriftSqlType.dateTime, requiredDuringInsert: false);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: false);
  static const i0.VerificationMeta _invoiceIdMeta =
      const i0.VerificationMeta('invoiceId');
  @override
  late final i0.GeneratedColumn<int> invoiceId = i0.GeneratedColumn<int>(
      'invoice_id', aliasedName, false,
      type: i0.DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          i0.GeneratedColumn.constraintIsAlways('REFERENCES invoices (id)'));
  static const i0.VerificationMeta _productIdMeta =
      const i0.VerificationMeta('productId');
  @override
  late final i0.GeneratedColumn<int> productId = i0.GeneratedColumn<int>(
      'product_id', aliasedName, true,
      type: i0.DriftSqlType.int, requiredDuringInsert: false);
  static const i0.VerificationMeta _descriptionMeta =
      const i0.VerificationMeta('description');
  @override
  late final i0.GeneratedColumn<String> description =
      i0.GeneratedColumn<String>('description', aliasedName, true,
          type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _quantityMeta =
      const i0.VerificationMeta('quantity');
  @override
  late final i0.GeneratedColumn<double> quantity = i0.GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: i0.DriftSqlType.double, requiredDuringInsert: true);
  static const i0.VerificationMeta _unitPriceMeta =
      const i0.VerificationMeta('unitPrice');
  @override
  late final i0.GeneratedColumn<double> unitPrice = i0.GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      type: i0.DriftSqlType.double, requiredDuringInsert: true);
  static const i0.VerificationMeta _lineTotalMeta =
      const i0.VerificationMeta('lineTotal');
  @override
  late final i0.GeneratedColumn<double> lineTotal = i0.GeneratedColumn<double>(
      'line_total', aliasedName, false,
      type: i0.DriftSqlType.double, requiredDuringInsert: true);
  static const i0.VerificationMeta _partyIdMeta =
      const i0.VerificationMeta('partyId');
  @override
  late final i0.GeneratedColumn<int> partyId = i0.GeneratedColumn<int>(
      'party_id', aliasedName, true,
      type: i0.DriftSqlType.int, requiredDuringInsert: false);
  static const i0.VerificationMeta _sellerEmployeeIdMeta =
      const i0.VerificationMeta('sellerEmployeeId');
  @override
  late final i0.GeneratedColumn<int> sellerEmployeeId = i0.GeneratedColumn<int>(
      'seller_employee_id', aliasedName, true,
      type: i0.DriftSqlType.int, requiredDuringInsert: false);
  static const i0.VerificationMeta _isDeletedMeta =
      const i0.VerificationMeta('isDeleted');
  @override
  late final i0.GeneratedColumn<bool> isDeleted = i0.GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: i0.DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
          'CHECK ("is_deleted" IN (0, 1))'));
  static const i0.VerificationMeta _createdAtMeta =
      const i0.VerificationMeta('createdAt');
  @override
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>('created_at', aliasedName, false,
          type: i0.DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<i0.GeneratedColumn> get $columns => [
        updatedAt,
        deletedAt,
        deletedAtLocal,
        id,
        invoiceId,
        productId,
        description,
        quantity,
        unitPrice,
        lineTotal,
        partyId,
        sellerEmployeeId,
        isDeleted,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_items';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.InvoiceItemsModel> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('deleted_at_local')) {
      context.handle(
          _deletedAtLocalMeta,
          deletedAtLocal.isAcceptableOrUnknown(
              data['deleted_at_local']!, _deletedAtLocalMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(_invoiceIdMeta,
          invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta));
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('line_total')) {
      context.handle(_lineTotalMeta,
          lineTotal.isAcceptableOrUnknown(data['line_total']!, _lineTotalMeta));
    } else if (isInserting) {
      context.missing(_lineTotalMeta);
    }
    if (data.containsKey('party_id')) {
      context.handle(_partyIdMeta,
          partyId.isAcceptableOrUnknown(data['party_id']!, _partyIdMeta));
    }
    if (data.containsKey('seller_employee_id')) {
      context.handle(
          _sellerEmployeeIdMeta,
          sellerEmployeeId.isAcceptableOrUnknown(
              data['seller_employee_id']!, _sellerEmployeeIdMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    } else if (isInserting) {
      context.missing(_isDeletedMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.InvoiceItemsModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.InvoiceItemsModel(
      productId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}product_id']),
      description: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}description']),
      partyId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}party_id']),
      sellerEmployeeId: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.int, data['${effectivePrefix}seller_employee_id']),
    );
  }

  @override
  $InvoiceItemsTable createAlias(String alias) {
    return $InvoiceItemsTable(attachedDatabase, alias);
  }
}

class InvoiceItemsCompanion extends i0.UpdateCompanion<i1.InvoiceItemsModel> {
  final i0.Value<DateTime> updatedAt;
  final i0.Value<DateTime?> deletedAt;
  final i0.Value<DateTime?> deletedAtLocal;
  final i0.Value<int> id;
  final i0.Value<int> invoiceId;
  final i0.Value<int?> productId;
  final i0.Value<String?> description;
  final i0.Value<double> quantity;
  final i0.Value<double> unitPrice;
  final i0.Value<double> lineTotal;
  final i0.Value<int?> partyId;
  final i0.Value<int?> sellerEmployeeId;
  final i0.Value<bool> isDeleted;
  final i0.Value<DateTime> createdAt;
  const InvoiceItemsCompanion({
    this.updatedAt = const i0.Value.absent(),
    this.deletedAt = const i0.Value.absent(),
    this.deletedAtLocal = const i0.Value.absent(),
    this.id = const i0.Value.absent(),
    this.invoiceId = const i0.Value.absent(),
    this.productId = const i0.Value.absent(),
    this.description = const i0.Value.absent(),
    this.quantity = const i0.Value.absent(),
    this.unitPrice = const i0.Value.absent(),
    this.lineTotal = const i0.Value.absent(),
    this.partyId = const i0.Value.absent(),
    this.sellerEmployeeId = const i0.Value.absent(),
    this.isDeleted = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
  });
  InvoiceItemsCompanion.insert({
    required DateTime updatedAt,
    this.deletedAt = const i0.Value.absent(),
    this.deletedAtLocal = const i0.Value.absent(),
    this.id = const i0.Value.absent(),
    required int invoiceId,
    this.productId = const i0.Value.absent(),
    this.description = const i0.Value.absent(),
    required double quantity,
    required double unitPrice,
    required double lineTotal,
    this.partyId = const i0.Value.absent(),
    this.sellerEmployeeId = const i0.Value.absent(),
    required bool isDeleted,
    required DateTime createdAt,
  })  : updatedAt = i0.Value(updatedAt),
        invoiceId = i0.Value(invoiceId),
        quantity = i0.Value(quantity),
        unitPrice = i0.Value(unitPrice),
        lineTotal = i0.Value(lineTotal),
        isDeleted = i0.Value(isDeleted),
        createdAt = i0.Value(createdAt);
  static i0.Insertable<i1.InvoiceItemsModel> custom({
    i0.Expression<DateTime>? updatedAt,
    i0.Expression<DateTime>? deletedAt,
    i0.Expression<DateTime>? deletedAtLocal,
    i0.Expression<int>? id,
    i0.Expression<int>? invoiceId,
    i0.Expression<int>? productId,
    i0.Expression<String>? description,
    i0.Expression<double>? quantity,
    i0.Expression<double>? unitPrice,
    i0.Expression<double>? lineTotal,
    i0.Expression<int>? partyId,
    i0.Expression<int>? sellerEmployeeId,
    i0.Expression<bool>? isDeleted,
    i0.Expression<DateTime>? createdAt,
  }) {
    return i0.RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (deletedAtLocal != null) 'deleted_at_local': deletedAtLocal,
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (productId != null) 'product_id': productId,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (lineTotal != null) 'line_total': lineTotal,
      if (partyId != null) 'party_id': partyId,
      if (sellerEmployeeId != null) 'seller_employee_id': sellerEmployeeId,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  i2.InvoiceItemsCompanion copyWith(
      {i0.Value<DateTime>? updatedAt,
      i0.Value<DateTime?>? deletedAt,
      i0.Value<DateTime?>? deletedAtLocal,
      i0.Value<int>? id,
      i0.Value<int>? invoiceId,
      i0.Value<int?>? productId,
      i0.Value<String?>? description,
      i0.Value<double>? quantity,
      i0.Value<double>? unitPrice,
      i0.Value<double>? lineTotal,
      i0.Value<int?>? partyId,
      i0.Value<int?>? sellerEmployeeId,
      i0.Value<bool>? isDeleted,
      i0.Value<DateTime>? createdAt}) {
    return i2.InvoiceItemsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      deletedAtLocal: deletedAtLocal ?? this.deletedAtLocal,
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      lineTotal: lineTotal ?? this.lineTotal,
      partyId: partyId ?? this.partyId,
      sellerEmployeeId: sellerEmployeeId ?? this.sellerEmployeeId,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = i0.Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = i0.Variable<DateTime>(deletedAt.value);
    }
    if (deletedAtLocal.present) {
      map['deleted_at_local'] = i0.Variable<DateTime>(deletedAtLocal.value);
    }
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = i0.Variable<int>(invoiceId.value);
    }
    if (productId.present) {
      map['product_id'] = i0.Variable<int>(productId.value);
    }
    if (description.present) {
      map['description'] = i0.Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = i0.Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = i0.Variable<double>(unitPrice.value);
    }
    if (lineTotal.present) {
      map['line_total'] = i0.Variable<double>(lineTotal.value);
    }
    if (partyId.present) {
      map['party_id'] = i0.Variable<int>(partyId.value);
    }
    if (sellerEmployeeId.present) {
      map['seller_employee_id'] = i0.Variable<int>(sellerEmployeeId.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = i0.Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('deletedAtLocal: $deletedAtLocal, ')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('lineTotal: $lineTotal, ')
          ..write('partyId: $partyId, ')
          ..write('sellerEmployeeId: $sellerEmployeeId, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class _$InvoiceItemsModelInsertable
    implements i0.Insertable<i1.InvoiceItemsModel> {
  i1.InvoiceItemsModel _object;
  _$InvoiceItemsModelInsertable(this._object);
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    return i2.InvoiceItemsCompanion(
      updatedAt: i0.Value(_object.updatedAt),
      id: i0.Value(_object.id),
      invoiceId: i0.Value(_object.invoiceId),
      productId: i0.Value(_object.productId),
      description: i0.Value(_object.description),
      quantity: i0.Value(_object.quantity),
      unitPrice: i0.Value(_object.unitPrice),
      lineTotal: i0.Value(_object.lineTotal),
      partyId: i0.Value(_object.partyId),
      sellerEmployeeId: i0.Value(_object.sellerEmployeeId),
      isDeleted: i0.Value(_object.isDeleted),
      createdAt: i0.Value(_object.createdAt),
    ).toColumns(false);
  }
}

extension InvoiceItemsModelToInsertable on i1.InvoiceItemsModel {
  _$InvoiceItemsModelInsertable toInsertable() {
    return _$InvoiceItemsModelInsertable(this);
  }
}
