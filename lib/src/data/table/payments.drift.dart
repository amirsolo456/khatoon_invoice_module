// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:invoice_module/src/model/payments_model.dart' as i1;
import 'package:invoice_module/src/data/table/payments.drift.dart' as i2;
import 'package:invoice_module/src/data/table/payments.dart' as i3;
import 'package:invoice_module/src/data/table/invoices.drift.dart' as i4;
import 'package:drift/internal/modular.dart' as i5;

typedef $$PaymentsTableCreateCompanionBuilder = i2.PaymentsCompanion Function({
  required DateTime updatedAt,
  i0.Value<DateTime?> deletedAt,
  i0.Value<DateTime?> deletedAtLocal,
  i0.Value<int> id,
  required int invoiceId,
  required double amount,
  required String direction,
  i0.Value<String?> paymentMethod,
  i0.Value<int?> fromPartyId,
  i0.Value<int?> toPartyId,
  i0.Value<String?> reference,
  i0.Value<String?> notes,
});
typedef $$PaymentsTableUpdateCompanionBuilder = i2.PaymentsCompanion Function({
  i0.Value<DateTime> updatedAt,
  i0.Value<DateTime?> deletedAt,
  i0.Value<DateTime?> deletedAtLocal,
  i0.Value<int> id,
  i0.Value<int> invoiceId,
  i0.Value<double> amount,
  i0.Value<String> direction,
  i0.Value<String?> paymentMethod,
  i0.Value<int?> fromPartyId,
  i0.Value<int?> toPartyId,
  i0.Value<String?> reference,
  i0.Value<String?> notes,
});

final class $$PaymentsTableReferences extends i0
    .BaseReferences<i0.GeneratedDatabase, i2.$PaymentsTable, i1.PaymentsModel> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static i4.$InvoicesTable _invoiceIdTable(i0.GeneratedDatabase db) =>
      i5.ReadDatabaseContainer(db)
          .resultSet<i4.$InvoicesTable>('invoices')
          .createAlias(i0.$_aliasNameGenerator(
              i5.ReadDatabaseContainer(db)
                  .resultSet<i2.$PaymentsTable>('payments')
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

class $$PaymentsTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i2.$PaymentsTable> {
  $$PaymentsTableFilterComposer({
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

  i0.ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get fromPartyId => $composableBuilder(
      column: $table.fromPartyId,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get toPartyId => $composableBuilder(
      column: $table.toPartyId, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => i0.ColumnFilters(column));

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

class $$PaymentsTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i2.$PaymentsTable> {
  $$PaymentsTableOrderingComposer({
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

  i0.ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get direction => $composableBuilder(
      column: $table.direction,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get fromPartyId => $composableBuilder(
      column: $table.fromPartyId,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get toPartyId => $composableBuilder(
      column: $table.toPartyId,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => i0.ColumnOrderings(column));

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

class $$PaymentsTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i2.$PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
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

  i0.GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  i0.GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  i0.GeneratedColumn<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  i0.GeneratedColumn<int> get fromPartyId => $composableBuilder(
      column: $table.fromPartyId, builder: (column) => column);

  i0.GeneratedColumn<int> get toPartyId =>
      $composableBuilder(column: $table.toPartyId, builder: (column) => column);

  i0.GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  i0.GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

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

class $$PaymentsTableTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i2.$PaymentsTable,
    i1.PaymentsModel,
    i2.$$PaymentsTableFilterComposer,
    i2.$$PaymentsTableOrderingComposer,
    i2.$$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (i1.PaymentsModel, i2.$$PaymentsTableReferences),
    i1.PaymentsModel,
    i0.PrefetchHooks Function({bool invoiceId})> {
  $$PaymentsTableTableManager(i0.GeneratedDatabase db, i2.$PaymentsTable table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i2.$$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i2.$$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i2.$$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<DateTime> updatedAt = const i0.Value.absent(),
            i0.Value<DateTime?> deletedAt = const i0.Value.absent(),
            i0.Value<DateTime?> deletedAtLocal = const i0.Value.absent(),
            i0.Value<int> id = const i0.Value.absent(),
            i0.Value<int> invoiceId = const i0.Value.absent(),
            i0.Value<double> amount = const i0.Value.absent(),
            i0.Value<String> direction = const i0.Value.absent(),
            i0.Value<String?> paymentMethod = const i0.Value.absent(),
            i0.Value<int?> fromPartyId = const i0.Value.absent(),
            i0.Value<int?> toPartyId = const i0.Value.absent(),
            i0.Value<String?> reference = const i0.Value.absent(),
            i0.Value<String?> notes = const i0.Value.absent(),
          }) =>
              i2.PaymentsCompanion(
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            deletedAtLocal: deletedAtLocal,
            id: id,
            invoiceId: invoiceId,
            amount: amount,
            direction: direction,
            paymentMethod: paymentMethod,
            fromPartyId: fromPartyId,
            toPartyId: toPartyId,
            reference: reference,
            notes: notes,
          ),
          createCompanionCallback: ({
            required DateTime updatedAt,
            i0.Value<DateTime?> deletedAt = const i0.Value.absent(),
            i0.Value<DateTime?> deletedAtLocal = const i0.Value.absent(),
            i0.Value<int> id = const i0.Value.absent(),
            required int invoiceId,
            required double amount,
            required String direction,
            i0.Value<String?> paymentMethod = const i0.Value.absent(),
            i0.Value<int?> fromPartyId = const i0.Value.absent(),
            i0.Value<int?> toPartyId = const i0.Value.absent(),
            i0.Value<String?> reference = const i0.Value.absent(),
            i0.Value<String?> notes = const i0.Value.absent(),
          }) =>
              i2.PaymentsCompanion.insert(
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            deletedAtLocal: deletedAtLocal,
            id: id,
            invoiceId: invoiceId,
            amount: amount,
            direction: direction,
            paymentMethod: paymentMethod,
            fromPartyId: fromPartyId,
            toPartyId: toPartyId,
            reference: reference,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    i2.$$PaymentsTableReferences(db, table, e)
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
                        i2.$$PaymentsTableReferences._invoiceIdTable(db),
                    referencedColumn:
                        i2.$$PaymentsTableReferences._invoiceIdTable(db).id,
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

typedef $$PaymentsTableProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i2.$PaymentsTable,
    i1.PaymentsModel,
    i2.$$PaymentsTableFilterComposer,
    i2.$$PaymentsTableOrderingComposer,
    i2.$$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (i1.PaymentsModel, i2.$$PaymentsTableReferences),
    i1.PaymentsModel,
    i0.PrefetchHooks Function({bool invoiceId})>;

class $PaymentsTable extends i3.Payments
    with i0.TableInfo<$PaymentsTable, i1.PaymentsModel> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;

  $PaymentsTable(this.attachedDatabase, [this._alias]);

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
  static const i0.VerificationMeta _amountMeta =
      const i0.VerificationMeta('amount');
  @override
  late final i0.GeneratedColumn<double> amount = i0.GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: i0.DriftSqlType.double, requiredDuringInsert: true);
  static const i0.VerificationMeta _directionMeta =
      const i0.VerificationMeta('direction');
  @override
  late final i0.GeneratedColumn<String> direction = i0.GeneratedColumn<String>(
      'direction', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _paymentMethodMeta =
      const i0.VerificationMeta('paymentMethod');
  @override
  late final i0.GeneratedColumn<String> paymentMethod =
      i0.GeneratedColumn<String>('payment_method', aliasedName, true,
          type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _fromPartyIdMeta =
      const i0.VerificationMeta('fromPartyId');
  @override
  late final i0.GeneratedColumn<int> fromPartyId = i0.GeneratedColumn<int>(
      'from_party_id', aliasedName, true,
      type: i0.DriftSqlType.int, requiredDuringInsert: false);
  static const i0.VerificationMeta _toPartyIdMeta =
      const i0.VerificationMeta('toPartyId');
  @override
  late final i0.GeneratedColumn<int> toPartyId = i0.GeneratedColumn<int>(
      'to_party_id', aliasedName, true,
      type: i0.DriftSqlType.int, requiredDuringInsert: false);
  static const i0.VerificationMeta _referenceMeta =
      const i0.VerificationMeta('reference');
  @override
  late final i0.GeneratedColumn<String> reference = i0.GeneratedColumn<String>(
      'reference', aliasedName, true,
      type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _notesMeta =
      const i0.VerificationMeta('notes');
  @override
  late final i0.GeneratedColumn<String> notes = i0.GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: i0.DriftSqlType.string, requiredDuringInsert: false);

  @override
  List<i0.GeneratedColumn> get $columns => [
        updatedAt,
        deletedAt,
        deletedAtLocal,
        id,
        invoiceId,
        amount,
        direction,
        paymentMethod,
        fromPartyId,
        toPartyId,
        reference,
        notes
      ];

  @override
  String get aliasedName => _alias ?? actualTableName;

  @override
  String get actualTableName => $name;
  static const String $name = 'payments';

  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.PaymentsModel> instance,
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
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta,
          direction.isAcceptableOrUnknown(data['direction']!, _directionMeta));
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    }
    if (data.containsKey('from_party_id')) {
      context.handle(
          _fromPartyIdMeta,
          fromPartyId.isAcceptableOrUnknown(
              data['from_party_id']!, _fromPartyIdMeta));
    }
    if (data.containsKey('to_party_id')) {
      context.handle(
          _toPartyIdMeta,
          toPartyId.isAcceptableOrUnknown(
              data['to_party_id']!, _toPartyIdMeta));
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};

  @override
  i1.PaymentsModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.PaymentsModel(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}id'])!,
      amount: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.double, data['${effectivePrefix}amount'])!,
      direction: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}direction'])!,
      paymentMethod: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}payment_method']),
      fromPartyId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}from_party_id']),
      toPartyId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}to_party_id']),
      reference: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}reference']),
      notes: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}notes']),
      updatedAt: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      deletedAtLocal: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.dateTime, data['${effectivePrefix}deleted_at_local']),

      isDeleted: false,
      createdAt: DateTime.now(),
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class PaymentsCompanion extends i0.UpdateCompanion<i1.PaymentsModel> {
  final i0.Value<DateTime> updatedAt;
  final i0.Value<DateTime?> deletedAt;
  final i0.Value<DateTime?> deletedAtLocal;
  final i0.Value<int> id;
  final i0.Value<int> invoiceId;
  final i0.Value<double> amount;
  final i0.Value<String> direction;
  final i0.Value<String?> paymentMethod;
  final i0.Value<int?> fromPartyId;
  final i0.Value<int?> toPartyId;
  final i0.Value<String?> reference;
  final i0.Value<String?> notes;

  const PaymentsCompanion({
    this.updatedAt = const i0.Value.absent(),
    this.deletedAt = const i0.Value.absent(),
    this.deletedAtLocal = const i0.Value.absent(),
    this.id = const i0.Value.absent(),
    this.invoiceId = const i0.Value.absent(),
    this.amount = const i0.Value.absent(),
    this.direction = const i0.Value.absent(),
    this.paymentMethod = const i0.Value.absent(),
    this.fromPartyId = const i0.Value.absent(),
    this.toPartyId = const i0.Value.absent(),
    this.reference = const i0.Value.absent(),
    this.notes = const i0.Value.absent(),
  });

  PaymentsCompanion.insert({
    required DateTime updatedAt,
    this.deletedAt = const i0.Value.absent(),
    this.deletedAtLocal = const i0.Value.absent(),
    this.id = const i0.Value.absent(),
    required int invoiceId,
    required double amount,
    required String direction,
    this.paymentMethod = const i0.Value.absent(),
    this.fromPartyId = const i0.Value.absent(),
    this.toPartyId = const i0.Value.absent(),
    this.reference = const i0.Value.absent(),
    this.notes = const i0.Value.absent(),
  })  : updatedAt = i0.Value(updatedAt),
        invoiceId = i0.Value(invoiceId),
        amount = i0.Value(amount),
        direction = i0.Value(direction);

  static i0.Insertable<i1.PaymentsModel> custom({
    i0.Expression<DateTime>? updatedAt,
    i0.Expression<DateTime>? deletedAt,
    i0.Expression<DateTime>? deletedAtLocal,
    i0.Expression<int>? id,
    i0.Expression<int>? invoiceId,
    i0.Expression<double>? amount,
    i0.Expression<String>? direction,
    i0.Expression<String>? paymentMethod,
    i0.Expression<int>? fromPartyId,
    i0.Expression<int>? toPartyId,
    i0.Expression<String>? reference,
    i0.Expression<String>? notes,
  }) {
    return i0.RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (deletedAtLocal != null) 'deleted_at_local': deletedAtLocal,
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (amount != null) 'amount': amount,
      if (direction != null) 'direction': direction,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (fromPartyId != null) 'from_party_id': fromPartyId,
      if (toPartyId != null) 'to_party_id': toPartyId,
      if (reference != null) 'reference': reference,
      if (notes != null) 'notes': notes,
    });
  }

  i2.PaymentsCompanion copyWith(
      {i0.Value<DateTime>? updatedAt,
      i0.Value<DateTime?>? deletedAt,
      i0.Value<DateTime?>? deletedAtLocal,
      i0.Value<int>? id,
      i0.Value<int>? invoiceId,
      i0.Value<double>? amount,
      i0.Value<String>? direction,
      i0.Value<String?>? paymentMethod,
      i0.Value<int?>? fromPartyId,
      i0.Value<int?>? toPartyId,
      i0.Value<String?>? reference,
      i0.Value<String?>? notes}) {
    return i2.PaymentsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      deletedAtLocal: deletedAtLocal ?? this.deletedAtLocal,
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      amount: amount ?? this.amount,
      direction: direction ?? this.direction,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      fromPartyId: fromPartyId ?? this.fromPartyId,
      toPartyId: toPartyId ?? this.toPartyId,
      reference: reference ?? this.reference,
      notes: notes ?? this.notes,
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
    if (amount.present) {
      map['amount'] = i0.Variable<double>(amount.value);
    }
    if (direction.present) {
      map['direction'] = i0.Variable<String>(direction.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = i0.Variable<String>(paymentMethod.value);
    }
    if (fromPartyId.present) {
      map['from_party_id'] = i0.Variable<int>(fromPartyId.value);
    }
    if (toPartyId.present) {
      map['to_party_id'] = i0.Variable<int>(toPartyId.value);
    }
    if (reference.present) {
      map['reference'] = i0.Variable<String>(reference.value);
    }
    if (notes.present) {
      map['notes'] = i0.Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('deletedAtLocal: $deletedAtLocal, ')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amount: $amount, ')
          ..write('direction: $direction, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('fromPartyId: $fromPartyId, ')
          ..write('toPartyId: $toPartyId, ')
          ..write('reference: $reference, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class _$PaymentsModelInsertable implements i0.Insertable<i1.PaymentsModel> {
  i1.PaymentsModel _object;

  _$PaymentsModelInsertable(this._object);

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    return i2.PaymentsCompanion(
      updatedAt: i0.Value(_object.updatedAt),
      deletedAt: i0.Value(_object.deletedAt),
      deletedAtLocal: i0.Value(_object.deletedAtLocal),
      id: i0.Value(_object.id),
      amount: i0.Value(_object.amount),
      direction: i0.Value(_object.direction),
      paymentMethod: i0.Value(_object.paymentMethod),
      fromPartyId: i0.Value(_object.fromPartyId),
      toPartyId: i0.Value(_object.toPartyId),
      reference: i0.Value(_object.reference),
      notes: i0.Value(_object.notes),
    ).toColumns(false);
  }
}

extension PaymentsModelToInsertable on i1.PaymentsModel {
  _$PaymentsModelInsertable toInsertable() {
    return _$PaymentsModelInsertable(this);
  }
}
