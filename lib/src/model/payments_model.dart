import 'package:drift/drift.dart' as d;

import 'package:invoice_module/index.dart';
import 'package:invoice_module/src/utils/base_model.dart';
import 'package:json_annotation/json_annotation.dart' as j;
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';

part 'payments_model.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class PaymentsModel extends BaseModel {
  @override
  final String id;
  final String invoiceId;
  final double amount;
  final String direction; // 'in' or 'out'
  final String? paymentMethod;
  final String? fromPartyId;
  final String? toPartyId;
  final String? reference;
  final String? notes;
  final int? version;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final DateTime? deletedAtLocal;

  PaymentsModel({
    required this.id,
    required this.invoiceId,
    required this.amount,
    required this.direction,
    this.version,

    this.paymentMethod,
    this.fromPartyId,
    this.toPartyId,
    this.reference,
    this.notes,
    required this.updatedAt,
    this.deletedAt,
    this.deletedAtLocal,
  }) : super(id: null, updatedAt: DateTime.now());

  factory PaymentsModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentsModelToJson(this);

  @override
  BaseModel copyWith({
    id,
    DateTime? updatedAt,
    DateTime? deletedAt,
    DateTime? deletedAtLocal,
    DateTime? createdAt,
  }) {
    return PaymentsModel(
      id: id ?? this.id,
      invoiceId: invoiceId,
      amount: amount,
      direction: direction,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      fromPartyId: fromPartyId ?? this.fromPartyId,
      toPartyId: toPartyId ?? this.toPartyId,
      reference: reference ?? this.reference,
      notes: notes ?? this.notes,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      deletedAtLocal: deletedAtLocal ?? this.deletedAtLocal,
      version: version ?? this.version,
    );
  }
}

@d.UseRowClass(PaymentsModel, generateInsertable: true)
class Payments extends d.Table with SyncColumns {
  d.TextColumn get id => text()();

  d.TextColumn get invoiceId => text().references(Invoices, #id)();

  d.RealColumn get amount => real()();

  d.TextColumn get direction => text()(); // 'in' یا 'out'
  d.TextColumn get paymentMethod => text().nullable()();

  d.TextColumn get fromPartyId => text().references(Parties, #id).nullable()();

  d.TextColumn get toPartyId => text().references(Parties, #id).nullable()();

  d.TextColumn get reference => text().nullable()();

  d.TextColumn get notes => text().nullable()();

  @override
  Set<d.Column> get primaryKey => {id};
}
