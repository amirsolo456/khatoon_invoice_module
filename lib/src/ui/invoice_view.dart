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

  PartyInfo({
    this.name = '',
    this.nationalId = '',
    this.phone = '',
    this.partyId,
    this.address = '',
  });
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
  final Future<void> Function(InvoiceModel) onSelect;
  final Future<void> Function(
    InvoiceModel,
    PartyInfo,
    PartyInfo,
    List<InvoiceItemsModel>,
    double,
  )
  onPrint;

  const InvoiceView({
    super.key,
    required this.onSelect,
    required this.initialInvoice,
    required this.onPrint,
  });

  @override
  State<InvoiceView> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoiceView> {
  PartyInfo seller = PartyInfo();
  PartyInfo buyer = PartyInfo();

  List<InvoiceItemsModel> items = [];

  final double taxRate = 0.09;
  double totalPrice = 0;
  double totalPQuantity = 0;

  double get subTotal => items.fold<double>(
    0,
    (sum, item) => sum + (item.quantity * item.unitPrice),
  );

  double get itemsTotal =>
      items.isNotEmpty ? items.last.quantity * items.last.unitPrice : 0;

  double get taxAmount => subTotal * taxRate;

  double get grandTotal => subTotal + taxAmount;

  double v = 0.0;

  final intl.NumberFormat currencyFormat = intl.NumberFormat("#,##0", "fa_IR");
  final List<TextEditingController> _qtyControllers = [];
  final List<TextEditingController> _priceControllers = [];

  @override
  void initState() {
    super.initState();
    // _qtyControllers = items.map((e) => TextEditingController(text: e.quantity.toString())).toList();
    // _priceControllers = items.map((e) => TextEditingController(text: e.unitPrice.toStringAsFixed(0))).toList();
    _initializeControllers();
    if (widget.initialInvoice.completed) {
      final inv = widget.initialInvoice;
      seller = PartyInfo();
      buyer = PartyInfo(partyId: inv.partyId);
      items = inv.items.map((line) => line).toList();
    } else {
      seller = PartyInfo();
      buyer = PartyInfo();
      items = [_createNewItem()];
    }
  }

  @override
  void dispose() {
    // ✅ تمام controllers را آزاد کنید
    for (final controller in _qtyControllers.reversed) {
      controller.dispose();
    }
    for (final controller in _priceControllers.reversed) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeControllers() {
    _qtyControllers.clear();
    _priceControllers.clear();

    for (int i = 0; i < items.length; i++) {
      _qtyControllers[i] = TextEditingController(
        text: items[i].quantity.toString(),
      );
      _priceControllers[i] = TextEditingController(
        text: items[i].unitPrice.toStringAsFixed(0),
      );
    }
  }

  InvoiceItemsModel _createNewItem() => InvoiceItemsModel(
    productId: null,
    id: 0,
    invoiceId: 0,
    quantity: 0,
    unitPrice: 0,
    lineTotal: 0,
    updatedAt: DateTime.now(),
  );

  void _addItem() {
    setState(() {
      items.add(
        InvoiceItemsModel(
          id: 0,
          invoiceId: 0,
          quantity: 0,
          unitPrice: 0,
          lineTotal: 0,
          updatedAt: DateTime.now(),
        ).copyWith(),
      );
      _qtyControllers.add(TextEditingController(text: '1'));
      _priceControllers.add(TextEditingController(text: '0'));
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
            child: const Text('خیر'),
          ),
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
                items = [_createNewItem()];
              });
              Navigator.pop(context);
            },
            child: const Text(
              'بله، پاک کن',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _printInvoice() async {
    // Use the 'printing' package here to generate PDF and print
    // await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('دستور پرینت ارسال شد (نیاز به پکیج printing)'),
      ),
    );
    widget.onPrint(widget.initialInvoice, buyer, seller, items, taxRate);
  }

  void _openProductSelection(int index) async {
    final Product? selectedProduct = await showDialog<Product>(
      context: context,
      builder: (context) => const ProductSelectionDialog(),
    );

    if (selectedProduct != null) {
      setState(() {
        // ✅ تعیین صحیح بدون async
        // items[index].pId = selectedProduct.id;
        // items[index].productName = selectedProduct.name;
        // items[index].price = selectedProduct.price;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('فاکتور فروش'),
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.print),
          onPressed: _printInvoice,
          tooltip: 'چاپ',
        ),
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () async {
            await widget.onSelect(widget.initialInvoice);
          },
          tooltip: 'ذخیره',
        ),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _resetInvoice,
          tooltip: 'جدید',
        ),
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
                child: PartyInfoCard(title: 'مشخصات فروشنده', info: seller),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PartyInfoCard(title: 'مشخصات خریدار', info: buyer),
              ),
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
                    child: Text(
                      'اقلام فاکتور',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                        final item = items[index];
                        return DataRow(
                          cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(
                              InkWell(
                                onTap: () => _openProductSelection(index),
                                child: Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 180,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    item.description ?? item.productName ?? '',
                                    style: TextStyle(
                                      color:
                                          item.productName == 'انتخاب کالا...'
                                          ? Colors.grey
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // تعداد
                            DataCell(
                              SizedBox(
                                width: 70,
                                child: TextFormField(
                                  controller: _qtyControllers[index],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: false,
                                      ),
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                  ),
                                  onChanged: (val) {
                                    final parsed = int.tryParse(val);
                                    if (parsed != null &&
                                        parsed != item.quantity) {
                                      setState(() {
                                        totalPQuantity =
                                            parsed.clamp(1, 999999)
                                                as double; // محدود کردن منطقی
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            // مبلغ واحد
                            DataCell(
                              SizedBox(
                                width: 130,
                                child: TextFormField(
                                  controller: _priceControllers[index],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  textAlign: TextAlign.end,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    suffixText: ' ریال',
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                  ),
                                  onChanged: (val) {
                                    final cleanVal = val
                                        .replaceAll(',', '')
                                        .replaceAll('٬', '');
                                    final parsed = double.tryParse(cleanVal);
                                    if (parsed != null &&
                                        parsed != item.unitPrice) {
                                      setState(() {
                                        totalPrice = parsed < 0 ? 0 : parsed;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            // مبلغ کل ردیف (به‌روز می‌شود)
                            DataCell(
                              Text(
                                currencyFormat.format(totalPQuantity),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: totalPQuantity > 0
                                      ? Colors.blueGrey[900]
                                      : Colors.grey,
                                ),
                              ),
                            ),
                            DataCell(
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeItem(index),
                              ),
                            ),
                          ],
                        );
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
                  _buildSummaryRow(
                    'مبلغ قابل پرداخت:',
                    grandTotal,
                    isBold: true,
                    fontSize: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildSummaryRow(
    String label,
    double amount, {
    bool isBold = false,
    double fontSize = 14,
  }) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
          ),
        ),
        Text(
          '${currencyFormat.format(amount)} ریال',
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
            fontFamily: 'Courier',
          ), // Monospaced if available
        ),
      ],
    ),
  );
}

class PartyInfoCard extends StatelessWidget {
  final String title;
  final PartyInfo info;

  const PartyInfoCard({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Divider(),
          _buildTextField('نام', (val) => info.name = val),
          _buildTextField('کد ملی', (val) => info.nationalId = val),
          _buildTextField('تلفن', (val) => info.phone = val),
          _buildTextField('آدرس', (val) => info.address = val),
        ],
      ),
    ),
  );

  Widget _buildTextField(String label, Function(String) onChanged) => Padding(
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

class ProductSelectionDialog extends StatefulWidget {
  const ProductSelectionDialog({super.key});

  @override
  State<ProductSelectionDialog> createState() => _ProductSelectionDialogState();
}

class _ProductSelectionDialogState extends State<ProductSelectionDialog> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final filteredProducts = mockProducts
        .where((p) => p.name.contains(searchTerm))
        .toList();

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
                const Text(
                  'انتخاب کالا',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
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
                      '${intl.NumberFormat("#,##0").format(product.price)} ریال',
                    ),
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
