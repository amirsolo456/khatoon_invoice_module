import 'package:json_annotation/json_annotation.dart';
import 'package:khatoon_shared/index.dart';

part 'invoice_items_model.g.dart';

@JsonSerializable()
class InvoiceItemsModel extends InvoiceLine {
  InvoiceItemsModel({
    int? productId,
    String? description,
    int? partyId,
    int? sellerEmployeeId,
  }) : super(
            id: 0,
            invoiceId: 0,
            version: 0,
            isDeleted: false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            lineTotal: 0,
            quantity: 0.0,
            unitPrice: 0.0);

  factory InvoiceItemsModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemsModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceItemsModelToJson(this);
}
