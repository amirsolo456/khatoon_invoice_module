import 'package:drift/drift.dart' hide JsonKey;
import 'package:invoice_module/index.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:drift/drift.dart' as df;
import '../utils/base_model.dart';

part 'invoice_model.g.dart';

@json.JsonSerializable(fieldRename: json.FieldRename.snake)
// ignore: must_be_immutable
class InvoiceModel extends BaseModel {
  final String invoiceNo;
  final String type;
  final String? notes;
  final double totalAmount;
  final String status;
  final int? partyId;
  final List<InvoiceItemsModel> items;
  final List<PaymentsModel> payments;
  final bool completed;
  final int? mood;
  final int? energy;
  final int? version;

  @json.JsonKey(includeFromJson: false, includeToJson: false)
  bool isSelected = false;

  InvoiceModel({
    required super.id,
    required this.invoiceNo,
    required this.type,
    required this.totalAmount,
    required this.status,
      this.version,
    this.partyId,
    this.notes,
    this.completed = false,
    this.items = const [],
    this.payments = const [],
    this.mood,
    this.energy,
    updatedAt,
    super.createdAt,

    super.deletedAt,
    super.deletedAtLocal,
  }) : super(updatedAt: DateTime.now());

  factory InvoiceModel.empty() => InvoiceModel(
    id: '',
    invoiceNo: '',
    type: '',
    totalAmount: 0,
    status: 'draft',
    version: 1,
    items: [],
    payments: [],
  );

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);


  InvoiceModel copyWith({
    String? id,
    String? invoiceNo,
    String? type,
    double? totalAmount,
    String? status,
    int? version,
    int? partyId,
    String? notes,
    bool? completed,
    List<InvoiceItemsModel>? items,
    List<PaymentsModel>? payments,
    int? mood,
    int? energy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    DateTime? deletedAtLocal,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      type: type ?? this.type,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      version: version ?? this.version,
      partyId: partyId ?? this.partyId,
      notes: notes ?? this.notes,
      completed: completed ?? this.completed,
      items: items ?? this.items,
      payments: payments ?? this.payments,
      mood: mood ?? this.mood,
      energy: energy ?? this.energy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      deletedAtLocal: deletedAtLocal ?? this.deletedAtLocal,

    );
  }
}

@df.UseRowClass(InvoiceModel, generateInsertable: true)
class Invoices extends Table with SyncColumns {
  TextColumn get id => text()();

  TextColumn get invoiceNo => text()();

  TextColumn get type => text()();

  RealColumn get totalAmount => real()();

  TextColumn get status => text()();

  IntColumn get partyId => integer().references(Parties, #id).nullable()();

  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  IntColumn get mood => integer().nullable()();

  IntColumn get energy => integer().nullable()();

  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// به همین ترتیب برای Parties و Payments
