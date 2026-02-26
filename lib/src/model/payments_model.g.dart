// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentsModel _$PaymentsModelFromJson(Map<String, dynamic> json) =>
    PaymentsModel(
      id: json['id'] as String,
      invoiceId: json['invoice_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      direction: json['direction'] as String,
      version: (json['version'] as num?)?.toInt(),
      paymentMethod: json['payment_method'] as String?,
      fromPartyId: json['from_party_id'] as String?,
      toPartyId: json['to_party_id'] as String?,
      reference: json['reference'] as String?,
      notes: json['notes'] as String?,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      deletedAtLocal: json['deleted_at_local'] == null
          ? null
          : DateTime.parse(json['deleted_at_local'] as String),
    );

Map<String, dynamic> _$PaymentsModelToJson(PaymentsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_id': instance.invoiceId,
      'amount': instance.amount,
      'direction': instance.direction,
      'payment_method': instance.paymentMethod,
      'from_party_id': instance.fromPartyId,
      'to_party_id': instance.toPartyId,
      'reference': instance.reference,
      'notes': instance.notes,
      'version': instance.version,
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'deleted_at_local': instance.deletedAtLocal?.toIso8601String(),
    };
