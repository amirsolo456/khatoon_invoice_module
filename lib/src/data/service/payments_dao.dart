import 'package:drift/drift.dart';
import 'package:invoice_module/src/data/service/payments_dao.drift.dart';

import '../../../index.dart';

import '../table/invoices.dart';
part  'payments_dao.drift.dart';

@DriftAccessor(tables: [Invoices, Parties ])
class PaymentsDao extends DatabaseAccessor<AppDatabase>
    with $PaymentsDaoMixin   {
  PaymentsDao(super.attachedDatabase);}
