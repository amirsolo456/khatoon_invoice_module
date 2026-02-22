// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceItemsModel _$InvoiceItemsModelFromJson(Map<String, dynamic> json) =>
    InvoiceItemsModel(
      productId: (json['productId'] as num?)?.toInt(),
      description: json['description'] as String?,
      partyId: (json['partyId'] as num?)?.toInt(),
      sellerEmployeeId: (json['sellerEmployeeId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InvoiceItemsModelToJson(InvoiceItemsModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'description': instance.description,
      'partyId': instance.partyId,
      'sellerEmployeeId': instance.sellerEmployeeId,
    };
