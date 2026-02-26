import 'package:drift/drift.dart';

import '../../../index.dart';

import '../table/invoices.dart';

@DriftAccessor(tables: [Invoices,  ])
class PaymentsDao extends DatabaseAccessor<AppDatabase>   {
  PaymentsDao(super.attachedDatabase);
}
