import 'package:json_annotation/json_annotation.dart';
import 'package:khatoon_shared/index.dart';

part 'invoice_items_model.g.dart';

@JsonSerializable()
class InvoiceItemsModel extends InvoiceLine {
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isSelected = false;
  @JsonKey(includeFromJson: false, includeToJson: false)
  double total = 0;

  @JsonKey(includeFromJson: false, includeToJson: false)
  int? productId;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? productName;

  @JsonKey(includeFromJson: false, includeToJson: false)
  double?  price;
  @JsonKey(includeFromJson: false, includeToJson: false)
  double?  quan;

  InvoiceItemsModel({
    int? productId,
    String? description,
    int? partyId,
    int? sellerEmployeeId,
  }) : super(
            id: 0,
            invoiceId: 0,

            isDeleted: false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            lineTotal: 0,
            quantity: 0.0,
            unitPrice: 0.0);

  factory InvoiceItemsModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemsModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InvoiceItemsModelToJson(this);
}
