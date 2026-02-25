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
      paymentMethod: json['payment_method'] as String?,
      fromPartyId: (json['from_party_id'] as num?)?.toInt(),
      toPartyId: (json['to_party_id'] as num?)?.toInt(),
      reference: json['reference'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$PaymentsModelToJson(PaymentsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'direction': instance.direction,
      'payment_method': instance.paymentMethod,
      'from_party_id': instance.fromPartyId,
      'to_party_id': instance.toPartyId,
      'reference': instance.reference,
      'notes': instance.notes,
    };
