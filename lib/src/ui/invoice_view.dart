import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'package:invoice_module/index.dart' hide PartyModel;
import 'package:invoice_module/src/ui/prerson/party_info_card.dart';

import 'invoice/invoice_items_table.dart';

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
  final GlobalKey<InvoicePageState> formKey; // ← جدید
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
    required this.formKey,
    required this.onSelect,
    required this.initialInvoice,
    required this.onPrint,
  }) : super(key: formKey);

  @override
  State<InvoiceView> createState() => InvoicePageState();
}

class InvoicePageState extends State<InvoiceView> {
  PartyInfo seller = PartyInfo();
  PartyInfo buyer = PartyInfo();

  late List<InvoiceItemsModel> items;
  late List<TextEditingController> _qtyControllers;
  late List<TextEditingController> _priceControllers;

  final double taxRate = 0.09;

  final intl.NumberFormat currencyFormat = intl.NumberFormat("#,##0", "fa_IR");

  InvoiceModel get currentInvoice {
    final now = DateTime.now();

    return widget.initialInvoice.copyWith(
      invoiceNo: 'AUTO-${now.millisecondsSinceEpoch}',
      type: 'sale',
      status: 'pending',
      totalAmount: grandTotal,
      partyId: buyer.partyId ?? 0,
      items: items.map((e) => e.copyWith()).toList(),
      createdAt: now,
      updatedAt: now,
      version: 1,
    );
  }

  @override
  void initState() {
    super.initState();

    // مقداردهی اولیه لیست‌ها
    if (widget.initialInvoice.completed) {
      items = List<InvoiceItemsModel>.from(widget.initialInvoice.items);
      seller = PartyInfo(); // ← اینجا باید اطلاعات فروشنده واقعی لود شود
      buyer = PartyInfo(partyId: widget.initialInvoice.partyId);
    } else {
      items = [_createNewItem()];
      seller = PartyInfo();
      buyer = PartyInfo();
    }

    _qtyControllers = [];
    _priceControllers = [];
    _syncControllersWithItems();
  }

  void _syncControllersWithItems() {
    // مهم: همیشه طول لیست کنترلرها را با items هماهنگ می‌کنیم
    while (_qtyControllers.length > items.length) {
      _qtyControllers.removeLast().dispose();
      _priceControllers.removeLast().dispose();
    }
    while (_qtyControllers.length < items.length) {
      final item = items[_qtyControllers.length];
      _qtyControllers.add(
        TextEditingController(text: item.quantity.toString()),
      );
      _priceControllers.add(
        TextEditingController(text: item.unitPrice.toStringAsFixed(0)),
      );
    }

    // به‌روزرسانی مقادیر موجود (در صورتی که مقدار item تغییر کرده باشد)
    for (int i = 0; i < items.length; i++) {
      _qtyControllers[i].text = items[i].quantity.toString();
      _priceControllers[i].text = items[i].unitPrice.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    for (final c in _qtyControllers) c.dispose();
    for (final c in _priceControllers) c.dispose();
    super.dispose();
  }

  InvoiceItemsModel _createNewItem() {
    return InvoiceItemsModel(
      id: 0,
      invoiceId: 0,
      productId: null,

      quantity: 1.0,
      unitPrice: 0.0,
      lineTotal: 0.0,

      description: null,
      // یا '' اگر مدل اجازه می‌دهد
      updatedAt: DateTime.now(),
    );
  }

  void _addItem() {
    setState(() {
      items.add(_createNewItem());
      _syncControllersWithItems();
    });
  }

  void _removeItem(int index) {
    if (items.length <= 1) return;

    setState(() {
      items.removeAt(index);
      _syncControllersWithItems();
    });
  }

  void _updateItem(int index, {int? quantity, double? unitPrice}) {
    if (index < 0 || index >= items.length) return;

    setState(() {
      final oldItem = items[index];
      items[index] = oldItem.copyWith(
        quantity:  1.0  ,
        unitPrice: unitPrice,
        lineTotal:
            (quantity ?? oldItem.quantity) * (unitPrice ?? oldItem.unitPrice),
      );
      // کنترلرها را هم به‌روز می‌کنیم (اختیاری – چون listener داریم)
      if (quantity != null) _qtyControllers[index].text = quantity.toString();
      if (unitPrice != null)
        _priceControllers[index].text = unitPrice.toStringAsFixed(0);
    });
  }

  double get subTotal => items.fold<double>(
    0,
    (sum, item) => sum + (item.quantity * item.unitPrice),
  );

  double get taxAmount => subTotal * taxRate;

  double get grandTotal => subTotal + taxAmount;

  Future<void> _printInvoice() async {
    widget.onPrint(
      widget.initialInvoice.copyWith(
        items: items,
        // سایر فیلدهای لازم را هم می‌توانید اینجا به‌روزرسانی کنید
      ),
      seller,
      buyer,
      items,
      taxRate,
    );
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
            tooltip: 'چاپ',
          ),
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'ذخیره',
            onPressed: () async {
              final current = currentInvoice;  // ← حتماً از این!

              // لاگ سریع برای چک (حذفش کن بعد از تست)
              print('در حال ذخیره فاکتور واقعی:');
              print('  • invoiceNo: ${current.invoiceNo}');
              print('  • type: ${current.type}');
              print('  • totalAmount: ${current.totalAmount}');
              print('  • partyId: ${current.partyId}');
              print('  • تعداد اقلام: ${current.items.length}');
              if (current.items.isNotEmpty) {
                print('  • نمونه اقلام: ${current.items.first.productName ?? "نامشخص"} × ${current.items.first.quantity}');
              }

              await widget.onSelect(current);
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'جدید',
            onPressed: _resetInvoice,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: PartyInfoCard(
                    title: 'مشخصات فروشنده',
                    info: seller,
                    onInfoChanged: (updated) {
                      setState(() {
                        seller = updated;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PartyInfoCard(
                    title: 'مشخصات خریدار',
                    info: buyer,
                    onInfoChanged: (updated) {
                      setState(() {
                        buyer = updated;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            InvoiceItemsTable(
              items: items,
              qtyControllers: _qtyControllers,
              priceControllers: _priceControllers,
              currencyFormat: currencyFormat,
              onRemoveItem: _removeItem,
              onUpdateItem: _updateItem,
              onSelectProduct: _openProductSelection,
              onAddItem: _addItem,
            ),

            // Items Table
            /*  Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'اقلام فاکتور',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:
                          // داخل Column اصلی
                          // InvoiceItemsTable(
                          //   items: items,
                          //   qtyControllers: _qtyControllers,
                          //   priceControllers: _priceControllers,
                          //   currencyFormat: currencyFormat,
                          //   onRemoveItem: _removeItem,
                          //   onUpdateItem: _updateItem,
                          //   onSelectProduct: _openProductSelection,
                          //   onAddItem: _addItem,
                          // ),
                          DataTable(
                            columnSpacing: 20,
                            columns: const [
                              DataColumn(label: Text('#')),
                              DataColumn(label: Text('شرح کالا')),
                              DataColumn(label: Text('تعداد')),
                              DataColumn(label: Text('مبلغ واحد')),
                              DataColumn(label: Text('مبلغ کل')),
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
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        // child: Text(
                                        //   item.description ?? item.productName ?? '',
                                        //   style: TextStyle(
                                        //     color: item.productName == 'انتخاب کالا...' ? Colors.grey : Colors.black87,
                                        //   ),
                                        // ),
                                        child: Text(
                                          item.description ??
                                              item.productName ??
                                              'انتخاب کالا...',
                                          style: TextStyle(
                                            color:
                                                (item.description?.isEmpty ??
                                                        true) &&
                                                    (item
                                                            .productName
                                                            ?.isEmpty ??
                                                        true)
                                                ? Colors.grey
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 80,
                                      child: TextFormField(
                                        controller: _qtyControllers[index],
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (val) {
                                          final q = int.tryParse(val) ?? 1;
                                          _updateItem(
                                            index,
                                            quantity: q.clamp(1, 999999),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 140,
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
                                        ),
                                        onChanged: (val) {
                                          final clean = val.replaceAll(
                                            RegExp(r'[٬,]'),
                                            '',
                                          );
                                          final p = double.tryParse(clean) ?? 0;
                                          _updateItem(
                                            index,
                                            unitPrice: p < 0 ? 0 : p,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      currencyFormat.format(
                                        item.quantity * item.unitPrice,
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
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
            ),*/
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
  }

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

  //
  // void _openProductSelection(int index) async {
  //   if (index < 0 || index >= items.length) return;
  //
  //   final Product? selectedProduct = await showDialog<Product>(
  //     context: context,
  //     builder: (context) => const ProductSelectionDialog(),
  //   );
  //
  //   if (selectedProduct == null) return;
  //
  //   setState(() {
  //     final oldItem = items[index];
  //
  //     items[index] = oldItem.copyWith(
  //       productId: selectedProduct.id,
  //       productName: selectedProduct.name,
  //       description: selectedProduct.name,
  //       // یا '' اگر توضیحات جدا داری
  //       unitPrice: selectedProduct.price,
  //       quantity: oldItem.quantity > 0 ? oldItem.quantity : 1.0,
  //       // حداقل ۱
  //       lineTotal:
  //           (oldItem.quantity > 0 ? oldItem.quantity : 1.0) *
  //           selectedProduct.price,
  //       // isSelected: true, // اگر می‌خوای بعد از انتخاب تیک بخوره
  //     );
  //
  //     // بروزرسانی کنترلرها
  //     _qtyControllers[index].text = items[index].quantity.toStringAsFixed(0);
  //     _priceControllers[index].text = items[index].unitPrice.toStringAsFixed(0);
  //   });
  // }

  void _openProductSelection(int index) async {
    final Product? selectedProduct = await showDialog<Product>(
      context: context,
      builder: (context) => const ProductSelectionDialog(),
    );

    if (selectedProduct != null) {
      setState(() {
        items[index] = items[index].copyWith(
          productId: selectedProduct.id,
          productName: selectedProduct.name,
          unitPrice: selectedProduct.price,
          // اگر قیمت محصول به عنوان unitPrice در نظر گرفته می‌شود
          lineTotal:
              items[index].quantity *
              selectedProduct.price, // محاسبه lineTotal جدید
        );
        // اگر می‌خواهید isSelected را true کنید:
        items[index].isSelected = true;
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

/// نوع دکمه (مطابق variant در React)
enum ButtonVariant {
  default_, // 'default' کلمه کلیدی در Dart است، از underscore استفاده می‌کنیم
  destructive,
  outline,
  secondary,
  ghost,
  link,
}

/// اندازه دکمه
enum ButtonSize { default_, sm, lg, icon }

/// ویجت دکمه سفارشی با استایل‌های مشابه shadcn/ui
class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isDisabled;
  final bool
  asChild; // اگر true باشد، دکمه به عنوان یک wrapper عمل می‌کند (مشابه Slot در Radix)
  final double? width;
  final double? height;

  const Button({
    super.key,
    required this.child,
    this.onPressed,
    this.variant = ButtonVariant.default_,
    this.size = ButtonSize.default_,
    this.isDisabled = false,
    this.asChild = false,
    this.width,
    this.height,
  });

  bool get _enabled => onPressed != null && !isDisabled;

  // دریافت رنگ‌های اصلی از تم (می‌توانید آن‌ها را به صورت ثابت هم تعریف کنید)
  Color _getBackgroundColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (variant) {
      case ButtonVariant.default_:
        return theme.colorScheme.primary;
      case ButtonVariant.destructive:
        return theme.colorScheme.error;
      case ButtonVariant.outline:
        return Colors.transparent;
      case ButtonVariant.secondary:
        return theme.colorScheme.secondary;
      case ButtonVariant.ghost:
        return Colors.transparent;
      case ButtonVariant.link:
        return Colors.transparent;
    }
  }

  Color _getForegroundColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (variant) {
      case ButtonVariant.default_:
        return theme.colorScheme.onPrimary;
      case ButtonVariant.destructive:
        return theme.colorScheme.onError;
      case ButtonVariant.outline:
        return theme.colorScheme.onSurface;
      case ButtonVariant.secondary:
        return theme.colorScheme.onSecondary;
      case ButtonVariant.ghost:
        return theme.colorScheme.onSurface;
      case ButtonVariant.link:
        return theme.colorScheme.primary;
    }
  }

  Color? _getBorderColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.outline:
        return Colors.orange;
      default:
        return null;
    }
  }

  // محاسبه padding بر اساس size
  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.default_:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case ButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 10);
      case ButtonSize.icon:
        return EdgeInsets.zero; // برای آیکون، خود child باید اندازه‌دهی شود
    }
  }

  // ارتفاع پیش‌فرض بر اساس size
  double? _getHeight() {
    if (height != null) return height;
    switch (size) {
      case ButtonSize.default_:
        return 36;
      case ButtonSize.sm:
        return 32;
      case ButtonSize.lg:
        return 40;
      case ButtonSize.icon:
        return 36;
    }
  }

  double? _getWidth() {
    if (width != null) return width;
    if (size == ButtonSize.icon) return 36;
    return null;
  }

  // استایل متن
  TextStyle _getTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    double fontSize = 14; // پیش‌فرض
    FontWeight fontWeight = FontWeight.w500; // medium
    return theme.textTheme.bodyMedium?.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: _getForegroundColor(context),
        ) ??
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // اگر asChild فعال باشد، فقط child را با استایل‌های خطی برمی‌گردانیم (بدون قابلیت کلیک)
    if (asChild) {
      return DefaultTextStyle(style: _getTextStyle(context), child: child);
    }

    // ساختار اصلی دکمه
    return SizedBox(
      width: _getWidth(),
      height: _getHeight(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(6),
          // rounded-md
          splashColor: theme.colorScheme.primary.withAlpha(100),
          highlightColor: Colors.transparent,
          child: Container(
            padding: _getPadding(),
            decoration: BoxDecoration(
              color: _getBackgroundColor(context),
              borderRadius: BorderRadius.circular(6),
              border: _getBorderColor(context) != null
                  ? Border.all(color: _getBorderColor(context)!)
                  : null,
            ),
            child: Center(
              child: DefaultTextStyle(
                style: _getTextStyle(context),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
