// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentsModel _$PaymentsModelFromJson(Map<String, dynamic> json) =>
    PaymentsModel(
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      direction: json['direction'] as String,
      paymentMethod: json['paymentMethod'] as String?,
      fromPartyId: (json['fromPartyId'] as num?)?.toInt(),
      toPartyId: (json['toPartyId'] as num?)?.toInt(),
      reference: json['reference'] as String?,
      notes: json['notes'] as String?,

      isDeleted: json['isDeleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      deletedAtLocal: json['deletedAtLocal'] == null
          ? null
          : DateTime.parse(json['deletedAtLocal'] as String),
    );

Map<String, dynamic> _$PaymentsModelToJson(PaymentsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'direction': instance.direction,
      'paymentMethod': instance.paymentMethod,
      'fromPartyId': instance.fromPartyId,
      'toPartyId': instance.toPartyId,
      'reference': instance.reference,
      'notes': instance.notes,

      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'deletedAtLocal': instance.deletedAtLocal?.toIso8601String(),
    };
