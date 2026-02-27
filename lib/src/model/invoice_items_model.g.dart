// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceItemsModel _$InvoiceItemsModelFromJson(Map<String, dynamic> json) =>
    InvoiceItemsModel(
      id: (json['id'] as num).toInt(),
      invoiceId:  json['invoice_id'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      lineTotal: (json['line_total'] as num).toDouble(),
      productId: (json['product_id'] as num?)?.toInt(),
      productName: json['product_name'] as String?,
      description: json['description'] as String?,
      partyId: (json['party_id'] as num?)?.toInt(),
      sellerEmployeeId: (json['seller_employee_id'] as num?)?.toInt(),
      version: (json['version'] as num?)?.toInt() ?? 1,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      deletedAtLocal: json['deleted_at_local'] == null
          ? null
          : DateTime.parse(json['deleted_at_local'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$InvoiceItemsModelToJson(InvoiceItemsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_id': instance.invoiceId,
      'product_id': instance.productId,
      'description': instance.description,
      'product_name': instance.productName,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'line_total': instance.lineTotal,
      'party_id': instance.partyId,
      'seller_employee_id': instance.sellerEmployeeId,
      'version': instance.version,
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'deleted_at_local': instance.deletedAtLocal?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
