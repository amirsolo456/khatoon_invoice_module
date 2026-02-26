// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) => InvoiceModel(
  id: json['id'],
  invoiceNo: json['invoice_no'] as String,
  type: json['type'] as String,
  totalAmount: (json['total_amount'] as num).toDouble(),
  status: json['status'] as String,
  version: (json['version'] as num?)?.toInt(),
  partyId: (json['party_id'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  completed: json['completed'] as bool? ?? false,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => InvoiceItemsModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  payments:
      (json['payments'] as List<dynamic>?)
          ?.map((e) => PaymentsModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  mood: (json['mood'] as num?)?.toInt(),
  energy: (json['energy'] as num?)?.toInt(),
  updatedAt: json['updated_at'],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
  deletedAtLocal: json['deleted_at_local'] == null
      ? null
      : DateTime.parse(json['deleted_at_local'] as String),
);

Map<String, dynamic> _$InvoiceModelToJson(InvoiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'deleted_at_local': instance.deletedAtLocal?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'invoice_no': instance.invoiceNo,
      'type': instance.type,
      'notes': instance.notes,
      'total_amount': instance.totalAmount,
      'status': instance.status,
      'party_id': instance.partyId,
      'items': instance.items,
      'payments': instance.payments,
      'completed': instance.completed,
      'mood': instance.mood,
      'energy': instance.energy,
      'version': instance.version,
    };
