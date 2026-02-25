import 'package:json_annotation/json_annotation.dart';
import 'package:khatoon_shared/index.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';

part 'payments_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class PaymentsModel extends Payment  with SyncColumns {
  // final DateTime? deletedAt;
  // final DateTime? deletedAtLocal;

  PaymentsModel({
    required super.id,

    required super.amount,
    required super.direction,
    super.paymentMethod,
    super.fromPartyId,
    super.toPartyId,
    super.reference,
    super.notes,

    // required super.isDeleted,
    // required super.createdAt,
    // required super.updatedAt,
  });

  factory PaymentsModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentsModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaymentsModelToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isSelected = false;
}
