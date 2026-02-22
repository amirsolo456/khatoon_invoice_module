import 'package:invoice_module/src/model/invoice_items_model.dart';
import 'package:invoice_module/src/model/payments_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:khatoon_shared/index.dart'; // شامل کلاس Invoice

part 'invoice_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InvoiceModel extends Invoice {
  final bool completed;
  final List<InvoiceLine> items; // استفاده از کلاس Drift
  final List<Payment> payments; // استفاده از کلاس Drift
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
    super.partyId,
    this.completed = false,
    required this.items,
    required this.payments,
  });

  factory InvoiceModel.empty() {
    return InvoiceModel(
      id: 0,
      invoiceNo: '',
      type: '',
      totalAmount: 0,
      status: '',
      version: 0,
      isDeleted: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      items: [],
      payments: [],
      completed: false,
    );
  }

  // اگر نیاز به کپی کردن با تغییرات دارید
  InvoiceModel copyWith({
    int? id,
    String? invoiceNo,
    String? type,
    double? totalAmount,
    String? status,
    double? version,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? completed,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      type: type ?? this.type,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      version: version ?? this.version,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completed: completed ?? this.completed,
      items: [],
      payments: [],
    );
  }

  @override
  String toString() {
    return 'InvoiceModel(id: $id, invoiceNo: $invoiceNo, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InvoiceModel &&
        other.id == id &&
        other.invoiceNo == invoiceNo &&
        other.type == type &&
        other.totalAmount == totalAmount &&
        other.status == status &&
        other.version == version &&
        other.isDeleted == isDeleted &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.completed == completed;
  }

  @override
  int get hashCode => Object.hash(
        id,
        invoiceNo,
        type,
        totalAmount,
        status,
        version,
        isDeleted,
        createdAt,
        updatedAt,
        completed,
      );

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isSelected = false;
}

// @JsonSerializable(fieldRename: FieldRename.snake)
// class InvoiceModel extends Invoice {
//   // فیلدهای اضافی (اگر نیاز باشد)
//   // مثلاً completed را به عنوان یک فیلد اضافه می‌کنیم
//
//
//   InvoiceModel({
//     int? id,
//     String? invoiceNo,
//     String? type,
//     double? totalAmount,
//     String? status,
//     int? version,
//     bool? isDeleted,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     this.completed = false,
//   }) : super(
//           id: 0,
//           invoiceNo: '',
//           type: '',
//           totalAmount: 0,
//           status: '',
//           version: 0,
//           isDeleted: false,
//           createdAt: DateTime.now(),
//           updatedAt: DateTime.now(),
//         );
//
//
// }
