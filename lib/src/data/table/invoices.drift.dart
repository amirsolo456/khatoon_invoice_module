// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:invoice_module/src/model/invoice_model.dart' as i1;
import 'package:invoice_module/src/data/table/invoices.drift.dart' as i2;
import 'package:invoice_module/src/data/table/invoices.dart' as i3;
import 'package:drift/src/runtime/query_builder/query_builder.dart' as i4;

typedef $$InvoicesTableCreateCompanionBuilder =
    i2.InvoicesCompanion Function({
      required DateTime updatedAt,
      i0.Value<DateTime?> deletedAt,
      i0.Value<DateTime?> deletedAtLocal,
      i0.Value<int> id,
      required String title,
      i0.Value<String?> description,
      i0.Value<bool> completed,
      i0.Value<int> priority,
      i0.Value<DateTime?> dueDate,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    i2.InvoicesCompanion Function({
      i0.Value<DateTime> updatedAt,
      i0.Value<DateTime?> deletedAt,
      i0.Value<DateTime?> deletedAtLocal,
      i0.Value<int> id,
      i0.Value<String> title,
      i0.Value<String?> description,
      i0.Value<bool> completed,
      i0.Value<int> priority,
      i0.Value<DateTime?> dueDate,
    });

class $$InvoicesTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i2.$InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get deletedAtLocal => $composableBuilder(
    column: $table.deletedAtLocal,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $$InvoicesTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i2.$InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get deletedAtLocal => $composableBuilder(
    column: $table.deletedAtLocal,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $$InvoicesTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i2.$InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
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
    column: $table.deletedAtLocal,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  i0.GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  i0.GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  i0.GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);
}

class $$InvoicesTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i2.$InvoicesTable,
          i1.InvoiceModel,
          i2.$$InvoicesTableFilterComposer,
          i2.$$InvoicesTableOrderingComposer,
          i2.$$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (
            i1.InvoiceModel,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i2.$InvoicesTable,
              i1.InvoiceModel
            >,
          ),
          i1.InvoiceModel,
          i0.PrefetchHooks Function()
        > {
  $$InvoicesTableTableManager(i0.GeneratedDatabase db, i2.$InvoicesTable table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i2.$$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i2.$$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i2.$$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<DateTime> updatedAt = const i0.Value.absent(),
                i0.Value<DateTime?> deletedAt = const i0.Value.absent(),
                i0.Value<DateTime?> deletedAtLocal = const i0.Value.absent(),
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<String> title = const i0.Value.absent(),
                i0.Value<String?> description = const i0.Value.absent(),
                i0.Value<bool> completed = const i0.Value.absent(),
                i0.Value<int> priority = const i0.Value.absent(),
                i0.Value<DateTime?> dueDate = const i0.Value.absent(),
              }) => i2.InvoicesCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                deletedAtLocal: deletedAtLocal,
                id: id,
                title: title,
                description: description,
                completed: completed,
                priority: priority,
                dueDate: dueDate,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                i0.Value<DateTime?> deletedAt = const i0.Value.absent(),
                i0.Value<DateTime?> deletedAtLocal = const i0.Value.absent(),
                i0.Value<int> id = const i0.Value.absent(),
                required String title,
                i0.Value<String?> description = const i0.Value.absent(),
                i0.Value<bool> completed = const i0.Value.absent(),
                i0.Value<int> priority = const i0.Value.absent(),
                i0.Value<DateTime?> dueDate = const i0.Value.absent(),
              }) => i2.InvoicesCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                deletedAtLocal: deletedAtLocal,
                id: id,
                title: title,
                description: description,
                completed: completed,
                priority: priority,
                dueDate: dueDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i2.$InvoicesTable,
      i1.InvoiceModel,
      i2.$$InvoicesTableFilterComposer,
      i2.$$InvoicesTableOrderingComposer,
      i2.$$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (
        i1.InvoiceModel,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i2.$InvoicesTable,
          i1.InvoiceModel
        >,
      ),
      i1.InvoiceModel,
      i0.PrefetchHooks Function()
    >;

class $InvoicesTable extends i3.Invoices
    with i0.TableInfo<$InvoicesTable, i1.InvoiceModel> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _updatedAtMeta = const i0.VerificationMeta(
    'updatedAt',
  );
  @override
  late final i0.GeneratedColumn<DateTime> updatedAt =
      i0.GeneratedColumn<DateTime>(
        'updated_at',
        aliasedName,
        false,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _deletedAtMeta = const i0.VerificationMeta(
    'deletedAt',
  );
  @override
  late final i0.GeneratedColumn<DateTime> deletedAt =
      i0.GeneratedColumn<DateTime>(
        'deleted_at',
        aliasedName,
        true,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const i0.VerificationMeta _deletedAtLocalMeta =
      const i0.VerificationMeta('deletedAtLocal');
  @override
  late final i0.GeneratedColumn<DateTime> deletedAtLocal =
      i0.GeneratedColumn<DateTime>(
        'deleted_at_local',
        aliasedName,
        true,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const i0.VerificationMeta _titleMeta = const i0.VerificationMeta(
    'title',
  );
  @override
  late final i0.GeneratedColumn<String> title = i0.GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: i0.GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _descriptionMeta = const i0.VerificationMeta(
    'description',
  );
  @override
  late final i0.GeneratedColumn<String> description =
      i0.GeneratedColumn<String>(
        'description',
        aliasedName,
        true,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const i0.VerificationMeta _completedMeta = const i0.VerificationMeta(
    'completed',
  );
  @override
  late final i0.GeneratedColumn<bool> completed = i0.GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const i4.Constant(false),
  );
  static const i0.VerificationMeta _priorityMeta = const i0.VerificationMeta(
    'priority',
  );
  @override
  late final i0.GeneratedColumn<int> priority = i0.GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const i4.Constant(3),
  );
  static const i0.VerificationMeta _dueDateMeta = const i0.VerificationMeta(
    'dueDate',
  );
  @override
  late final i0.GeneratedColumn<DateTime> dueDate =
      i0.GeneratedColumn<DateTime>(
        'due_date',
        aliasedName,
        true,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<i0.GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    deletedAtLocal,
    id,
    title,
    description,
    completed,
    priority,
    dueDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.InvoiceModel> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('deleted_at_local')) {
      context.handle(
        _deletedAtLocalMeta,
        deletedAtLocal.isAcceptableOrUnknown(
          data['deleted_at_local']!,
          _deletedAtLocalMeta,
        ),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.InvoiceModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.InvoiceModel(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!, invoiceNo: '', type: '', totalAmount:  0, status: '', version:  0, isDeleted:  false, createdAt:  DateTime.now(),
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class InvoicesCompanion extends i0.UpdateCompanion<i1.InvoiceModel> {
  final i0.Value<DateTime> updatedAt;
  final i0.Value<DateTime?> deletedAt;
  final i0.Value<DateTime?> deletedAtLocal;
  final i0.Value<int> id;
  final i0.Value<String> title;
  final i0.Value<String?> description;
  final i0.Value<bool> completed;
  final i0.Value<int> priority;
  final i0.Value<DateTime?> dueDate;
  const InvoicesCompanion({
    this.updatedAt = const i0.Value.absent(),
    this.deletedAt = const i0.Value.absent(),
    this.deletedAtLocal = const i0.Value.absent(),
    this.id = const i0.Value.absent(),
    this.title = const i0.Value.absent(),
    this.description = const i0.Value.absent(),
    this.completed = const i0.Value.absent(),
    this.priority = const i0.Value.absent(),
    this.dueDate = const i0.Value.absent(),
  });
  InvoicesCompanion.insert({
    required DateTime updatedAt,
    this.deletedAt = const i0.Value.absent(),
    this.deletedAtLocal = const i0.Value.absent(),
    this.id = const i0.Value.absent(),
    required String title,
    this.description = const i0.Value.absent(),
    this.completed = const i0.Value.absent(),
    this.priority = const i0.Value.absent(),
    this.dueDate = const i0.Value.absent(),
  }) : updatedAt = i0.Value(updatedAt),
       title = i0.Value(title);
  static i0.Insertable<i1.InvoiceModel> custom({
    i0.Expression<DateTime>? updatedAt,
    i0.Expression<DateTime>? deletedAt,
    i0.Expression<DateTime>? deletedAtLocal,
    i0.Expression<int>? id,
    i0.Expression<String>? title,
    i0.Expression<String>? description,
    i0.Expression<bool>? completed,
    i0.Expression<int>? priority,
    i0.Expression<DateTime>? dueDate,
  }) {
    return i0.RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (deletedAtLocal != null) 'deleted_at_local': deletedAtLocal,
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (completed != null) 'completed': completed,
      if (priority != null) 'priority': priority,
      if (dueDate != null) 'due_date': dueDate,
    });
  }

  i2.InvoicesCompanion copyWith({
    i0.Value<DateTime>? updatedAt,
    i0.Value<DateTime?>? deletedAt,
    i0.Value<DateTime?>? deletedAtLocal,
    i0.Value<int>? id,
    i0.Value<String>? title,
    i0.Value<String?>? description,
    i0.Value<bool>? completed,
    i0.Value<int>? priority,
    i0.Value<DateTime?>? dueDate,
  }) {
    return i2.InvoicesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      deletedAtLocal: deletedAtLocal ?? this.deletedAtLocal,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
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
    if (title.present) {
      map['title'] = i0.Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = i0.Variable<String>(description.value);
    }
    if (completed.present) {
      map['completed'] = i0.Variable<bool>(completed.value);
    }
    if (priority.present) {
      map['priority'] = i0.Variable<int>(priority.value);
    }
    if (dueDate.present) {
      map['due_date'] = i0.Variable<DateTime>(dueDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('deletedAtLocal: $deletedAtLocal, ')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('completed: $completed, ')
          ..write('priority: $priority, ')
          ..write('dueDate: $dueDate')
          ..write(')'))
        .toString();
  }
}

class _$InvoiceModelInsertable implements i0.Insertable<i1.InvoiceModel> {
  i1.InvoiceModel _object;
  _$InvoiceModelInsertable(this._object);
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    return i2.InvoicesCompanion(
      updatedAt: i0.Value(_object.updatedAt),
      id: i0.Value(_object.id),
      completed: i0.Value(_object.completed),
    ).toColumns(false);
  }
}

extension InvoiceModelToInsertable on i1.InvoiceModel {
  _$InvoiceModelInsertable toInsertable() {
    return _$InvoiceModelInsertable(this);
  }
}
