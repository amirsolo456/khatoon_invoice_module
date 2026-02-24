import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'package:invoice_module/index.dart';

// Note: For printing functionalitlutter, you would typically use the 'pdf' and 'printing' packages.
// Add them to your pubspec.yaml:
// dependencies:
//   pdf: ^3.10.0
//   printing: ^5.11.0
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// Models
class Product {
  final int id;
  final String name;
  final double price;

  Product(this.id, this.name, this.price);
}

// class InvoiceItem {
//   String id;
//   int? productId;
//   String productName;
//   int quantity;
//   double unitPrice;
//
//   InvoiceItem({
//     required this.id,
//     this.productId,
//     this.productName = '',
//     this.quantity = 1,
//     this.unitPrice = 0,
//   });
//
//   double get total => quantity * unitPrice;
// }

class PartyInfo {
  String name;
  String nationalId;
  String phone;
  String address;
  int? partyId;

  PartyInfo(
      {this.name = '',
      this.nationalId = '',
      this.phone = '',
      this.partyId,
      this.address = ''});
}

// Mock Data
final List<Product> mockProducts = [
  Product(1, 'گوشی موبایل سامسونگ S24', 50000000),
  Product(2, 'لپ‌تاپ مک‌بوک پرو M3', 120000000),
  Product(3, 'هندزفری بلوتوثی شیائومی', 1500000),
  Product(4, 'مانیتور ال‌جی 27 اینچ', 12000000),
  Product(5, 'کیبورد مکانیکی لاجیتک', 4500000),
  Product(6, 'موس بی‌سیم ریزر', 3200000),
  Product(7, 'پاوربانک 20000 میلی‌آمپر', 950000),
  Product(8, 'هارد اکسترنال 2 ترابایت', 3800000),
];

class InvoiceView extends StatefulWidget {
  final InvoiceModel initialInvoice;

  const InvoiceView({super.key, required this.initialInvoice});

  @override
  State<InvoiceView> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoiceView> {
  PartyInfo seller = PartyInfo();
  PartyInfo buyer = PartyInfo();
  late List<InvoiceItemsModel> items = [];

  final double taxRate = 0.09;

  double get subTotal => items.fold(0, (sum, item) => sum + itemsTotal);

  double v = 0.0;

  double get itemsTotal =>
      (items == [] ? 0 : items.map((i) => i.total += i.unitPrice).last);

  double get taxAmount => subTotal * taxRate;

  double get grandTotal => subTotal + taxAmount;

  final intl.NumberFormat currencyFormat = intl.NumberFormat("#,##0", "fa_IR");

  @override
  void initState() {
    super.initState();
    if (widget.initialInvoice != null) {
      // ویرایش فاکتور موجود
      final inv = widget.initialInvoice!;
      seller = PartyInfo(); // فروشنده از جای دیگری می‌آید (مثلاً شرکت پیش‌فرض)
      // اگر partyId در فاکتور وجود دارد، آن را به عنوان خریدار در نظر بگیرید
      // برای سادگی، یک PartyInfo با name خالی و partyId از فاکتور می‌سازیم
      buyer = PartyInfo(partyId: inv.partyId);
      // تبدیل InvoiceLine به InvoiceItemsModel (با فرض اینکه همه آیتم‌ها از نوع InvoiceItemsModel هستند)
      items = inv.items.map((line) {
        if (line is InvoiceItemsModel) {
          return line;
        } else {
          // در غیر اینصورت یک InvoiceItemsModel از روی line می‌سازیم
          return InvoiceItemsModel(
            productId: line.productId,
            description: line.description,
            // سایر فیلدها را از line کپی می‌کنیم (مقداردهی در سازنده InvoiceItemsModel انجام نمی‌شود)
          );
          // ..id = line.id
          // ..invoiceId = line.invoiceId
          // ..version = line.version
          // ..isDeleted = line.isDeleted
          // ..createdAt = line.createdAt
          // ..updatedAt = line.updatedAt
          // ..lineTotal = line.lineTotal
          // ..quantity = line.quantity
          // ..unitPrice = line.unitPrice;
        }
      }).toList();
    } else {
      seller = PartyInfo();
      buyer = PartyInfo();
      items = [_createNewItem()];
    }
  }

  InvoiceItemsModel _createNewItem() {
    return InvoiceItemsModel(
      productId: null,
      description: '',
    );
  }

  void _addItem() {
    setState(() {
      items.add(InvoiceItemsModel());
    });
  }

  void _removeItem(int index) {
    if (items.length > 1) {
      setState(() {
        items.removeAt(index);
      });
    }
  }

  void _resetInvoice() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('لغو فاکتور'),
        content: const Text('آیا مطمئن هستید؟ تمام اطلاعات پاک خواهد شد.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('خیر')),
          TextButton(
            onPressed: () {
              setState(() {
                seller.name = '';
                seller.nationalId = '';
                seller.phone = '';
                seller.address = '';
                buyer.name = '';
                buyer.nationalId = '';
                buyer.phone = '';
                buyer.address = '';
                items = [_createNewItem()]; // Use the helper method
              });
              Navigator.pop(context);
            },
            child:
                const Text('بله، پاک کن', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _saveInvoice() {
    // ایجاد یک نمونه InvoiceModel با داده‌های فعلی
    final invoice = InvoiceModel(
      partyId: buyer.partyId,
      // شناسه خریدار (در صورت وجود)
      completed: false,
      items: items,
      // آیتم‌ها از نوع InvoiceLine هستند
      payments: [], // فعلاً خالی
    );

    // اینجا منطق ذخیره‌سازی (API، دیتابیس) را پیاده‌سازی کنید
    if (kDebugMode) {
      print('Invoice saved: ${invoice.toJson()}');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('فاکتور با موفقیت ذخیره شد'),
          backgroundColor: Colors.green),
    );
  }

  Future<void> _printInvoice() async {
    // Use the 'printing' package here to generate PDF and print
    // await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('دستور پرینت ارسال شد (نیاز به پکیج printing)')),
    );
  }

  void _openProductSelection(int index) async {
    final Product? selectedProduct = await showDialog<Product>(
      context: context,
      builder: (context) => const ProductSelectionDialog(),
    );

    if (selectedProduct != null) {
      setState(() async {
        items[index].productId = selectedProduct.id;
        items[index].productName = selectedProduct.name;
        items[index].price = selectedProduct.price;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فاکتور فروش'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              icon: const Icon(Icons.print),
              onPressed: _printInvoice,
              tooltip: 'چاپ'),
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveInvoice,
              tooltip: 'ذخیره'),
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetInvoice,
              tooltip: 'جدید'),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Party Info Sections
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child:
                        PartyInfoCard(title: 'مشخصات فروشنده', info: seller)),
                const SizedBox(width: 16),
                Expanded(
                    child: PartyInfoCard(title: 'مشخصات خریدار', info: buyer)),
              ],
            ),
            const SizedBox(height: 24),

            // Items Table
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('اقلام فاکتور',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 20,
                        columns: const [
                          DataColumn(label: Text('#')),
                          DataColumn(label: Text('شرح کالا')),
                          DataColumn(label: Text('تعداد')),
                          DataColumn(label: Text('مبلغ واحد (ریال)')),
                          DataColumn(label: Text('مبلغ کل (ریال)')),
                          DataColumn(label: Text('حذف')),
                        ],
                        rows: List.generate(items.length, (index) {
                          final InvoiceItemsModel item = items[index];
                          return DataRow(cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(
                              InkWell(
                                onTap: () => _openProductSelection(index),
                                child: Container(
                                  constraints:
                                      const BoxConstraints(minWidth: 150),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 4),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    item.description == null
                                        ? 'انتخاب کالا...'
                                        : '',
                                    style: TextStyle(
                                        color: item.description == null
                                            ? Colors.grey
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 60,
                                child: TextFormField(
                                  initialValue: item.quantity.toString(),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (val) {
                                    item.quantity == int.tryParse(val) ?? 1;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  initialValue:
                                      item.unitPrice.toStringAsFixed(0),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      suffixText: ' ریال'),
                                  onChanged: (val) {
                                    item.quan = double.tryParse(val) ?? 0.0;
                                  },
                                ),
                              ),
                            ),
                            DataCell(Text(currencyFormat.format(item.total))),
                            DataCell(
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removeItem(index),
                              ),
                            ),
                          ]);
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: _addItem,
                          icon: const Icon(Icons.add),
                          label: const Text('افزودن سطر جدید'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Totals
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildSummaryRow('جمع کل:', subTotal),
                    _buildSummaryRow('مالیات و عوارض (9%):', taxAmount),
                    const Divider(thickness: 1.5),
                    _buildSummaryRow('مبلغ قابل پرداخت:', grandTotal,
                        isBold: true, fontSize: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount,
      {bool isBold = false, double fontSize = 14}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: fontSize)),
          Text(
            '${currencyFormat.format(amount)} ریال',
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: fontSize,
                fontFamily: 'Courier'), // Monospaced if available
          ),
        ],
      ),
    );
  }
}

class PartyInfoCard extends StatelessWidget {
  final String title;
  final PartyInfo info;

  const PartyInfoCard({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(),
            _buildTextField('نام', (val) => info.name = val),
            _buildTextField('کد ملی', (val) => info.nationalId = val),
            _buildTextField('تلفن', (val) => info.phone = val),
            _buildTextField('آدرس', (val) => info.address = val),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class ProductSelectionDialog extends StatefulWidget {
  const ProductSelectionDialog({super.key});

  @override
  State<ProductSelectionDialog> createState() => _ProductSelectionDialogState();
}

class _ProductSelectionDialogState extends State<ProductSelectionDialog> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final filteredProducts =
        mockProducts.where((p) => p.name.contains(searchTerm)).toList();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 400,
        height: 500,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('انتخاب کالا',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'جستجوی کالا...',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                setState(() {
                  searchTerm = val;
                });
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: filteredProducts.length,
                separatorBuilder: (ctx, i) => const Divider(),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                        '${intl.NumberFormat("#,##0").format(product.price)} ریال'),
                    onTap: () {
                      Navigator.pop(context, product);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
