// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) => InvoiceModel(
  partyId: (json['party_id'] as num?)?.toInt(),
  completed: json['completed'] as bool? ?? false,
  items: (json['items'] as List<dynamic>)
      .map((e) => InvoiceItemsModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  payments: (json['payments'] as List<dynamic>)
      .map((e) => Payment.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$InvoiceModelToJson(InvoiceModel instance) =>
    <String, dynamic>{
      'party_id': instance.partyId,
      'completed': instance.completed,
      'items': instance.items,
      'payments': instance.payments,
    };
