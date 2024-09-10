import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';
import 'package:promoter/Features/inventory/data/models/inventory_model/driver.dart';

import '../../Features/bills/data/models/category_bill_model/category_bill_model.dart';
import '../../Features/inventory/data/models/inventory_model/inventory_model.dart';
import '../../Features/inventory/presentation/manager/cubit/inventory_cubit.dart';

class PdfCreate {
  static Future<void> generatePDF(
    DateTime selectedDate,
    InventoryModel inv,
  ) async {
    DateFormat('yyyy-MM-dd', 'en').format(selectedDate);
    final pdf = pw.Document();
    final ttfBold =
        await rootBundle.load('assets/fonts/Hacen Tunisia Bold Regular.ttf');
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: Font.ttf(
            await rootBundle
                .load('assets/fonts/Hacen Tunisia Bold Regular.ttf'),
          ),
        ),
        build: (context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('SHAMSEEN FOODSTUFF CATERING',
                      style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          font: pw.Font.ttf(ttfBold))),
                  pw.Text('شمسين لخدمات التموين بالموادالغذائية',
                      style: pw.TextStyle(
                          fontSize: 16, font: pw.Font.ttf(ttfBold)),
                      textDirection: pw.TextDirection.rtl),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Phone: 065384357',
                      style: const pw.TextStyle(fontSize: 14)),
                  pw.Text('Fax: 065384357',
                      style: const pw.TextStyle(fontSize: 14)),
                  pw.Text('TRN: 100334461900003',
                      style: const pw.TextStyle(fontSize: 14)),
                ],
              ),
              pw.SizedBox(height: 10),
              // pw.Header(level: 0, text: 'Category Totals'),
              pw.Text(
                  'Date:${DateFormat('yyyy-MM-dd', 'en').format(selectedDate)}',
                  style:
                      pw.TextStyle(fontSize: 14, font: pw.Font.ttf(ttfBold))),
              pw.SizedBox(height: 10),
              pw.Divider(),
              // pw.Table(children: ),
            ],
          ),
          pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                  'رقم الظرف: ${inv.envelops![0].number}       مقدار ما بداخل الظرف: ${inv.envelops![0].cash}'),
              pw.Text('سعر العينات: ${inv.envelops![0].spExpenses}'),
              pw.Divider(),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text('سعر المرتجع'),
              ),
              pw.Expanded(
                child: pw.Text('الكمية المتبقية'),
              ),
              pw.Expanded(
                child: pw.Text('اسم المرتجع'),
              ),
            ],
          ),
          pw.Divider(),
          pw.ListView.separated(
            itemBuilder: (context, index) => pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                  child: pw.Text(inv
                      .inventories![0].inventoryCategory![index].category!.price
                      .toString()),
                ),
                pw.Expanded(
                  child: pw.Text(
                    inv.inventories![0].inventoryCategory![index].amount
                        .toString(),
                  ),
                ),
                pw.Expanded(
                  child: pw.Text(inv.inventories![0].inventoryCategory![index]
                      .category!.nameAr!),
                ),
              ],
            ),
            separatorBuilder: (context, index) => pw.SizedBox(),
            itemCount: inv.inventories![0].inventoryCategory!.length,
          ),
          pw.Column(
            // mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Divider(),
              pw.Text(
                  'الكمية الكلية للمرتجعات: ${inv.inventories![0].totalAmount}'),
              pw.Text(
                  'السعر الكلي للمرتجعات: ${inv.inventories![0].totalPrice}'),
            ],
          ),
        ],
      ),
    );
    final pdfBytes = await pdf.save();
    final appDocDir = await getApplicationSupportDirectory();
    final pdfPath = '${appDocDir.path}/inventory.pdf';
    print(pdfPath);
    final pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(pdfBytes);
    final result = OpenFile.open(pdfPath);
  }

  List<String> list = [
    'sdf',
    'sdf',
    'sdf',
    'sdf',
    'sdf',
    'sdf',
  ];
  static Future<void> generateBillPDF({
    required DateTime selectedDate,
    required List<CategoryBillModel> categoryBIll,
    required String spName,
    required String toSpName,
    required String type,
  }) async {
    final pdf = pw.Document();
    DateFormat('yyyy-MM-dd', 'en').format(selectedDate);
    final ttfBold =
        await rootBundle.load('assets/fonts/Hacen Tunisia Bold Regular.ttf');
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: Font.ttf(
            await rootBundle
                .load('assets/fonts/Hacen Tunisia Bold Regular.ttf'),
          ),
        ),
        build: (context) {
          double totalPrice = 0;
          double totalAmount = 0;
          for (var element in categoryBIll) {
            double price = (element.totalPrice == null)
                ? 0
                : double.parse(element.totalPrice.toString());
            double amount = (element.amount == null)
                ? 0
                : double.parse(element.amount.toString());
            totalPrice += price;
            totalAmount += amount;
          }
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('SHAMSEEN FOODSTUFF CATERING',
                        style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            font: pw.Font.ttf(ttfBold))),
                    pw.Text('شمسين لخدمات التموين بالموادالغذائية',
                        style: pw.TextStyle(
                            fontSize: 16, font: pw.Font.ttf(ttfBold)),
                        textDirection: pw.TextDirection.rtl),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Phone: 065384357',
                        style: const pw.TextStyle(fontSize: 14)),
                    pw.Text('Fax: 065384357',
                        style: const pw.TextStyle(fontSize: 14)),
                    pw.Text('TRN: 100334461900003',
                        style: const pw.TextStyle(fontSize: 14)),
                  ],
                ),
                pw.SizedBox(height: 10),
                // pw.Header(level: 0, text: 'Category Totals'),
                pw.Text(
                    'Date:${DateFormat('yyyy-MM-dd', 'en').format(selectedDate)}',
                    style:
                        pw.TextStyle(fontSize: 14, font: pw.Font.ttf(ttfBold))),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    if (toSpName != 'none')
                      pw.Expanded(
                        child: pw.Text(
                          'مناقلة من نقطة البيع: $toSpName',
                        ),
                      ),
                    pw.Expanded(
                      child: pw.Text(
                        'اسم نقطة البيع: $spName',
                      ),
                    ),
                  ],
                ),
                pw.Text(
                  'نوع الفاتورة: $type',
                ),
                pw.Divider(),
                // pw.Table(children: ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                  child: pw.Container(
                    color: PdfColors.grey300,
                    child: pw.Text(
                      'السعر الكلي للعنصر',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                pw.Expanded(
                  child: pw.Container(
                    color: PdfColors.grey300,
                    child: pw.Text(
                      'الكمية الكلية',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                pw.Expanded(
                  child: pw.Container(
                    color: PdfColors.grey300,
                    child: pw.Text(
                      'سعر القطعة',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    color: PdfColors.grey300,
                    child: pw.Text(
                      'إسم العنصر',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            pw.ListView.builder(
              itemBuilder: (context, index) {
                double totalPrice =
                    double.parse(categoryBIll[index].totalPrice.toString());
                double totalAmount =
                    double.parse(categoryBIll[index].amount.toString());
                double singlePrice = totalPrice / totalAmount;
                String singlePricee = singlePrice.toStringAsFixed(2);

                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(
                      child: pw.Container(
                        child: pw.Text(
                          categoryBIll[index].totalPrice.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        child: pw.Text(
                          categoryBIll[index].amount.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        child: pw.Text(
                          singlePricee,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        child: pw.Text(
                          '${index + 1}- ${categoryBIll[index].category!.nameAr}',
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: categoryBIll.length,
            ),
            pw.Column(
              // mainAxisAlignment: pw.MainAxisAlignment.end,
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Divider(),
                pw.Text(
                  'الكمية الكلية للعناصر: $totalAmount',
                ),
                pw.Text(
                  'السعر الكلي للعناصر:  $totalPrice',
                ),
              ],
            ),
          ];
        },
      ),
    );
    final pdfBytes = await pdf.save();
    final appDocDir = await getApplicationSupportDirectory();
    final pdfPath =
        '${appDocDir.path}/${DateFormat('yyyy-MM-dd', 'en').format(selectedDate)}-$type.pdf';
    print(pdfPath);
    final pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(pdfBytes);
    final result = OpenFile.open(pdfPath);
  }

  /*
  feras code for alamin project
  static Future<void> generateCodeTAblePdf(List<dynamic> ourData) async {
    final pdf = pw.Document();
    DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
    final ttfBold =
        await rootBundle.load('assets/fonts/Hacen Tunisia Bold Regular.ttf');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 30,
          marginLeft: 10,
          marginRight: 10,
          marginTop: 30,
        ),
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: Font.ttf(
            await rootBundle
                .load('assets/fonts/Hacen Tunisia Bold Regular.ttf'),
          ),
        ),
        build: (context) {
          return [
            // here we should put row that exist in your code
            pw.GridView(
              children: List.generate(
                20,
                (index) => pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.VerticalDivider(),
                    pw.Column(
                      children: [
                        pw.Container(
                          height: 70,
                          width: 80,
                          child: pw.BarcodeWidget(
                            barcode: Barcode.qrCode(),
                            data: ourData[index].code,
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Column(
                            // mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('student name:.......................'),
                              pw.Text('student number:.....................'),
                              pw.Text('student account:....................'),
                              pw.Text('university number:..................'),
                              pw.Text('code: ${ourData[index].code}'),
                              pw.Text('age of code: ${ourData[index].code}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
          ];
        },
      ),
    );
    
    final pdfBytes = await pdf.save();
    final appDocDir = await getApplicationDocumentsDirectory();
    final pdfPath = '${appDocDir.path}/codeTable';
    print(pdfPath);
    final pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(pdfBytes);
    final result = OpenFile.open(pdfPath);
  }
*/
}
