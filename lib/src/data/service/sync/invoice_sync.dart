/*
import 'package:invoice_module/src/data/table/invoices.dart';
import 'package:invoice_module/src/model/invoice_model.dart';
import 'package:offline_first_sync_drift/offline_first_sync_drift.dart';

import '../../db/data_base.dart';

SyncableTable<InvoiceModel> todoSyncTable(AppDatabase db) => SyncableTable<InvoiceModel>(table:  (db.allTables[InvoiceModel()]).,
  kind: 'todos',
  // table: db.INV,
  fromJson: InvoiceModel.fromJson,
  toJson: (t) => t.toJson(),
  // toInsertable: (t) => t.toInsertable(),
  // getId: (t) => t.id,
  getUpdatedAt: (t) => t.updatedAt,
);*/
