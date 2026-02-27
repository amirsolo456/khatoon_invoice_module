import 'package:drift/drift.dart' as df;
import 'package:invoice_module/index.dart' hide Invoices;
import 'package:invoice_module/src/model/invoice_model.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';
import 'package:equatable/equatable.dart';


part 'invoice_items_model.g.dart';

/// Simple model without inheritance (بدون ارث‌بری)
@json.JsonSerializable(fieldRename: json.FieldRename.snake)
// ignore: must_be_immutable
class InvoiceItemsModel extends Equatable {
  final int id;
  final int invoiceId;
  final int? productId;
  final String? description;
  final String? productName;
  final double quantity;
  final double unitPrice;
  final double lineTotal;
  final int? partyId;
  final int? sellerEmployeeId;
  final int version;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final DateTime? deletedAtLocal;
  final DateTime? createdAt;

  @json.JsonKey(includeFromJson: false, includeToJson: false)
  bool isSelected = false;

  InvoiceItemsModel({
    required this.id,
    required this.invoiceId,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
    this.productId,
    this.productName,
    this.description,
    this.partyId,
    this.sellerEmployeeId,
    this.version = 1,
    required this.updatedAt,
    this.deletedAt,
    this.deletedAtLocal,
    this.createdAt,
  });

  /// Getters for sync control
  bool get isDeleted => deletedAtLocal != null || deletedAt != null;
  bool get isDeletedLocally => deletedAtLocal != null;
  bool get isDeletedOnServer => deletedAt != null;

  factory InvoiceItemsModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemsModelFromJson(json) ;

  Map<String, dynamic> toJson() => _$InvoiceItemsModelToJson(this);

  InvoiceItemsModel copyWith({
    int? id,
    int? invoiceId,
    int? productId,
    String? description,
    String? productName,
    double? quantity,
    double? unitPrice,
    double? lineTotal,
    int? partyId,
    int? sellerEmployeeId,
    int? version,
    DateTime? updatedAt,
    DateTime? deletedAt,
    DateTime? deletedAtLocal,
    DateTime? createdAt,
  }) {
    return InvoiceItemsModel(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      lineTotal: lineTotal ?? this.lineTotal,
      partyId: partyId ?? this.partyId,
      sellerEmployeeId: sellerEmployeeId ?? this.sellerEmployeeId,
      version: version ?? this.version,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      deletedAtLocal: deletedAtLocal ?? this.deletedAtLocal,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  InvoiceItemsModel markDeletedLocally(DateTime timestamp) =>
      copyWith(deletedAtLocal: timestamp);

  InvoiceItemsModel markDeletedOnServer(DateTime timestamp) =>
      copyWith(deletedAt: timestamp, deletedAtLocal: null);

  InvoiceItemsModel restore() =>
      copyWith(deletedAt: null, deletedAtLocal: null);

  @override
  String toString() =>
      'InvoiceItem(id: $id, invoiceId: $invoiceId, qty: $quantity×\$$unitPrice)';

  @override
  List<Object?> get props => [
    id,
    invoiceId,
    productId,
    description,
    quantity,
    unitPrice,
    lineTotal,
    partyId,
    sellerEmployeeId,
    version,
    updatedAt,
    deletedAt,
    deletedAtLocal,
    createdAt,
  ];
}

@df.UseRowClass(InvoiceItemsModel, generateInsertable: true)
class InvoiceItems extends df.Table with SyncColumns {
  df.IntColumn get id => integer()();
  df.TextColumn get invoiceId => text().references(Invoices, #id)();  // ← text() به جای integer()
  df.IntColumn get productId => integer().nullable()();
  df.TextColumn get description => text().nullable()();
  df.RealColumn get quantity => real()();
  df.RealColumn get unitPrice => real()();
  df.RealColumn get lineTotal => real()();
  df.IntColumn get partyId => integer().references(Parties, #id).nullable()();
  df.IntColumn get sellerEmployeeId => integer().nullable()();
  df.IntColumn get version => integer().withDefault(const df.Constant(1))();

  @override
  Set<df.Column> get primaryKey => {id};
}