import 'package:invoice_module/src/data/table/invoices.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:khatoon_shared/index.dart';

part 'invoice_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InvoiceModel extends Invoice   {
  InvoiceModel({
    required super.id,
    required super.invoiceNo,
    required super.type,
    required super.totalAmount,
    required super.status,
    required super.version,
    required super.isDeleted,
    required super.createdAt,
    required super.updatedAt,
  });

  bool get completed => false;

   InvoiceModel copyWith({
    int? id,
    String?  status,
    String? description,
    bool? completed,
    int? priority,
    DateTime? dueDate,
    DateTime? updatedAt,
    DateTime? deletedAt,
    DateTime? deletedAtLocal,
  }) {
    return InvoiceModel(
       id:  id     ??0,
      totalAmount: totalAmount,
      type: type,
      createdAt: createdAt,
      invoiceNo: invoiceNo,
      updatedAt: updatedAt ?? this.updatedAt,
      status: '',
      version: version,
      isDeleted: isDeleted,
    );
  }

  @override
  String toString() =>
      'InvoiceModel(id: $id,  invoiceNo: $invoiceNo, completed: $completed)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          invoiceNo == other.invoiceNo &&
          isDeleted == other.isDeleted &&
          completed == other.completed &&
          createdAt == other.createdAt &&
          notes == other.notes &&
          updatedAt == other.updatedAt &&
          type == other.type &&
          totalAmount == other.totalAmount;

  @override
  int get hashCode => Object.hash(
    id,
    invoiceNo,
    isDeleted,
    completed,
    notes,
    createdAt,
    updatedAt,
    type,
    totalAmount,
  );

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);
}
