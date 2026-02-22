// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) => InvoiceModel(
      id: (json['id'] as num).toInt(),
      invoiceNo: json['invoice_no'] as String,
      type: json['type'] as String? ?? 'Sale',
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: json['status'] as String,
      version: (json['version'] as num).toDouble(),
      isDeleted: json['is_deleted'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      partyId: (json['party_id'] as num?)?.toInt(),
      completed: json['completed'] as bool? ?? false,
      items: (json['items'] as List<dynamic>)
          .map((e) => InvoiceLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      payments: (json['payments'] as List<dynamic>)
          .map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvoiceModelToJson(InvoiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_no': instance.invoiceNo,
      'type': instance.type,
      'party_id': instance.partyId,
      'total_amount': instance.totalAmount,
      'status': instance.status,
      'version': instance.version,
      'is_deleted': instance.isDeleted,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'completed': instance.completed,
      'items': instance.items,
      'payments': instance.payments,
    };
