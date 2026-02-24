import 'package:drift/drift.dart';
import 'package:invoice_module/src/data/table/payments.drift.dart';

import '../../model/invoice_model.dart';
import '../db/data_base.dart';
import '../table/invoice_items.dart';
import '../table/invoice_items.drift.dart';
import '../table/invoices.dart';
import '../table/invoices.drift.dart';
import '../table/payments.dart';
import 'invoice_dao.drift.dart';

@DriftAccessor(tables: [Invoices, InvoiceItems, Payments])
class InvoiceDao extends DatabaseAccessor<AppDatabase> with $InvoiceDaoMixin {
  InvoiceDao(super.db);

  // ذخیره کامل فاکتور با آیتم‌ها و پرداخت‌ها
  Future<void> saveFullInvoice(InvoiceModel invoice) async {
    await db.transaction(() async {
      // ۱. ذخیره فاکتور اصلی
      await into(db.invoices).insertOnConflictUpdate(
        InvoicesCompanion(
          id: Value(invoice.id),
          invoiceNo: Value(invoice.invoiceNo),
          type: Value(invoice.type),
          partyId: Value(invoice.partyId),
          totalAmount: Value(invoice.totalAmount),
          status: Value(invoice.status),
          createdAt: Value(invoice.createdAt),
          updatedAt: Value(DateTime.now()),

          isDeleted: Value(invoice.isDeleted),
        ),
      );

      // ۲. ذخیره آیتم‌ها (ابتدا آیتم‌های قدیمی را حذف کرده و دوباره درج کنید، یا یکی‌یکی آپدیت کنید)
      // اگر می‌خواهید همه آیتم‌های قبلی پاک شوند و دوباره اضافه شوند:
      await batch((batch) {
        for (final item in invoice.items) {
          batch.insert(
            db.invoiceItems,
            InvoiceItemsCompanion(
              id: Value(item.id),
              invoiceId: Value(invoice.id),
              productId: Value(item.productId),
              description: Value(item.description),
              quantity: Value(item.quantity),
              unitPrice: Value(item.unitPrice),
              createdAt: Value(item.createdAt),
              updatedAt: Value(item.updatedAt),
              isDeleted: Value(item.isDeleted),
            ),
            mode: InsertMode.insertOrReplace,
          );
        }
      });
      // await (delete(db.invoiceItems)..where((t) => t.invoiceId.equals(invoice.id))).go();
      // for (final item in invoice.items) {
      //   await into(db.invoiceItems).insert(
      //     InvoiceItemsCompanion(
      //       id: Value(item.id),
      //       invoiceId: Value(invoice.id),
      //       productId: Value(item.productId),
      //       description: Value(item.description),
      //       quantity: Value(item.quantity),
      //       unitPrice: Value(item.unitPrice),
      //       createdAt: Value(item.createdAt),
      //       updatedAt: Value(item.updatedAt),
      //       version: Value(item.version),
      //       isDeleted: Value(item.isDeleted),
      //     ),
      //   );
      // }

      // ۳. ذخیره پرداخت‌ها (به همین ترتیب)
      await (delete(db.payments)..where((t) => t.invoiceId.equals(invoice.id)))
          .go();
      for (final payment in invoice.payments) {
        await into(db.payments).insert(
          PaymentsCompanion(
            id: Value(payment.id),
            invoiceId: Value(invoice.id),
            amount: Value(payment.amount),
            paymentMethod: Value(payment.paymentMethod),
            updatedAt: Value(payment.updatedAt),
          ),
        );
      }
    });
  }

  // دریافت کامل فاکتور به همراه آیتم‌ها و پرداخت‌ها
  Future<InvoiceModel?> getFullInvoiceById(int id) async {
    final invoice = await (select(db.invoices)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (invoice == null) return null;

    final items = await (select(db.invoiceItems)
          ..where((t) => t.invoiceId.equals(id)))
        .get();
    final payments =
        await (select(db.payments)..where((t) => t.invoiceId.equals(id))).get();

    // تبدیل به InvoiceModel (اگر سازنده مناسب دارد)
    return InvoiceModel(
      // partyId: invoice.partyId,

      items: items,
      payments: payments,
    );
  }
}
