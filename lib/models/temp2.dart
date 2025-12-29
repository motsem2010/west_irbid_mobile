
  // void printLicence({BuildLicenseModel? buildLicense}) async {
  //   var doc = pw.Document(creator: 'motasem taamneh');
  //   final image = await imageFromAssetBundle('assets/images/logo2.jpg');
  //   final ttf = await fontFromAssetBundle('assets/digital/janna.ttf');
  //   final font = await PdfGoogleFonts.nunitoExtraLight();

  //   doc.addPage(pw.Page(
  //       textDirection: pw.TextDirection.rtl,
  //       pageFormat: PdfPageFormat.a4,
  //       build: (pw.Context context) {
  //         return pw.Directionality(
  //             textDirection: pw.TextDirection.rtl,
  //             child: pw.Column(
  //                 mainAxisAlignment: pw.MainAxisAlignment.start,
  //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                 children: [
  //                   pw.Row(
  //                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                       crossAxisAlignment: pw.CrossAxisAlignment.center,
  //                       children: [
  //                         pw.Column(
  //                             mainAxisAlignment: pw.MainAxisAlignment.start,
  //                             mainAxisSize: pw.MainAxisSize.min,
  //                             children: [
  //                               key_widget(
  //                                   'المملكه الإردنية الهاشمية', ttf, 15),
  //                               key_widget('وزارة الادارة المحلية', ttf, 15),
  //                               value_underline_widget(
  //                                 'بلدية',
  //                                 'غرب إربد',
  //                                 ttf,
  //                                 20,
  //                               ),
  //                               value_underline_widget(
  //                                 'منطقه',
  //                                 'ناطفه',
  //                                 ttf,
  //                                 12,
  //                               )
  //                             ]),
  //                         pw.Column(
  //                           mainAxisAlignment: pw.MainAxisAlignment.start,
  //                           mainAxisSize: pw.MainAxisSize.min,
  //                           children: [
  //                             pw.Image(image, width: 50, height: 50),
  //                             key_widget('رخصه إنشاءات', ttf, 15),
  //                           ],
  //                         ),
  //                         pw.Column(
  //                             mainAxisAlignment: pw.MainAxisAlignment.start,
  //                             crossAxisAlignment: pw.CrossAxisAlignment.end,
  //                             mainAxisSize: pw.MainAxisSize.min,
  //                             children: [
  //                               // key_widget('وزارة الادارة المحلية', ttf, 15),
  //                               value_underline_widget(
  //                                 'قرار',
  //                                 '40 /110',
  //                                 ttf,
  //                                 12,
  //                               ),
  //                               value_underline_widget(
  //                                 'تاريخ',
  //                                 '24/08/2023',
  //                                 ttf,
  //                                 12,
  //                               ),
  //                               value_underline_widget(
  //                                 'ترخيص رقم',
  //                                 '12456',
  //                                 ttf,
  //                                 12,
  //                               ),
  //                               value_underline_widget(
  //                                 'تاريخ',
  //                                 '25/07/2023',
  //                                 ttf,
  //                                 12,
  //                               ),
  //                             ]),
  //                       ]),
  //                   pw.Divider(),
  //                   pw.Table(
  //                       defaultVerticalAlignment:
  //                           pw.TableCellVerticalAlignment.middle,
  //                       border: pw.TableBorder.all(
  //                           color: PdfColors.blueGrey700, width: 1),
  //                       columnWidths: {
  //                         0: pw.FlexColumnWidth(1),
  //                         1: pw.FlexColumnWidth(2),
  //                         2: pw.FlexColumnWidth(1),
  //                         3: pw.FlexColumnWidth(2),
  //                       },
  //                       children: [
  //                         pw.TableRow(children: [
  //                           key_table_widget('إسم صاحب الرخصه', ttf, 8, true),
  //                           key_table_widget('name of licence', ttf, 8, false),
  //                           key_table_widget('الرقم الوطني', ttf, 8, true),
  //                           key_table_widget('98341251120', ttf, 8, false),
  //                         ]),
  //                         pw.TableRow(children: [
  //                           key_table_widget('رقم القطعة', ttf, 8, true),
  //                           key_table_widget('335', ttf, 8, false),
  //                           key_table_widget('رقم سند التسجيل', ttf, 8, true),
  //                           key_table_widget('12/556', ttf, 8, false),
  //                         ]),
  //                         pw.TableRow(children: [
  //                           key_table_widget('الحي', ttf, 8, true),
  //                           key_table_widget('جدول الاحياء', ttf, 8, false),
  //                           key_table_widget('تاريخ سند التسجيل', ttf, 8, true),
  //                           key_table_widget('22/10/2021', ttf, 8, false),
  //                         ]),
  //                         pw.TableRow(children: [
  //                           key_table_widget('اللوحة', ttf, 8, true),
  //                           key_table_widget('22', ttf, 8, false),
  //                           key_table_widget('من أراضي قرية', ttf, 8, true),
  //                           key_table_widget('كفرعوان', ttf, 8, false),
  //                         ]),
  //                         pw.TableRow(children: [
  //                           key_table_widget('رقم الحوض', ttf, 8, true),
  //                           key_table_widget('6', ttf, 8, false),
  //                           key_table_widget('مساحه القطعه', ttf, 8, true),
  //                           key_table_widget('2355 م', ttf, 8, false),
  //                         ]),
  //                         pw.TableRow(children: [
  //                           key_table_widget('إسم الحوض', ttf, 8, true),
  //                           key_table_widget('دبيس', ttf, 8, false),
  //                           key_table_widget('صفه الإستعمال', ttf, 8, true),
  //                           key_table_widget('سكني', ttf, 8, false),
  //                         ]),
  //                         // pw.TableRow(children: [
  //                         //   pw.Text('Floor', textAlign: pw.TextAlign.center),
  //                         //   pw.Text('Area', textAlign: pw.TextAlign.center),
  //                         //   pw.Text('Fees', textAlign: pw.TextAlign.center),
  //                         //   pw.Text('Notes', textAlign: pw.TextAlign.center)
  //                         // ]),
  //                       ]),
  //                   pw.SizedBox(height: 20),
  //                   pw.Table(
  //                       defaultVerticalAlignment:
  //                           pw.TableCellVerticalAlignment.middle,
  //                       border: pw.TableBorder.all(
  //                           color: PdfColors.blueGrey700, width: 1),
  //                       columnWidths: {
  //                         0: pw.FlexColumnWidth(2),
  //                         1: pw.FlexColumnWidth(1),
  //                         2: pw.FlexColumnWidth(1),
  //                         3: pw.FlexColumnWidth(1),
  //                         4: pw.FlexColumnWidth(1),
  //                         5: pw.FlexColumnWidth(1),
  //                         6: pw.FlexColumnWidth(1),
  //                         7: pw.FlexColumnWidth(2),
  //                       },
  //                       children: [
  //                         pw.TableRow(children: [
  //                           key_table_widget('الطابق', ttf, 8, true),
  //                           key_table_widget('نوع الترخيص', ttf, 8, false),
  //                           key_table_widget('المساحه', ttf, 8, true),
  //                           key_table_widget('رقم الوصل', ttf, 8, false),
  //                           key_table_widget('التاريخ', ttf, 8, true),
  //                           key_table_widget('الرسوم المستوفاه', ttf, 8, false),
  //                           key_table_widget('ملاحظات', ttf, 8, false),
  //                         ]),
  //                         ...licenceFloors.map((e) => pw.TableRow(children: [
  //                               key_table_widget(
  //                                   e.floor.toString(), ttf, 8, true),
  //                               key_table_widget(
  //                                   e.licenceType.toString(), ttf, 8, false),
  //                               key_table_widget(
  //                                   e.area.toString(), ttf, 8, true),
  //                               key_table_widget(
  //                                   e.reciptNumber.toString(), ttf, 8, false),
  //                               key_table_widget(
  //                                   e.reciptDate.toString(), ttf, 8, true),
  //                               key_table_widget(
  //                                   e.fees.toString(), ttf, 8, false),
  //                               key_table_widget(
  //                                   e.notes.toString(), ttf, 8, false),
  //                             ]))
  //                       ]),
  //                   pw.Row(
  //                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                       children: [
  //                         key_widget('سكرتير اللجنة المحلية للتنظيم والابنية',
  //                             ttf, null),
  //                         value_widget(' سعود نصير', ttf),
  //                       ]),
  //                   pw.Row(
  //                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                       // mainAxisAlignment: pw.MainAxisAlignment.end,
  //                       children: [
  //                         // pw.SizedBox(width: 20),
  //                         key_widget('رئيس اللجنة المحلية للتنظيم والابنية',
  //                             ttf, null),
  //                         value_widget('م محمد عبد الباسط', ttf),
  //                       ]),
  //                   pw.Row(
  //                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         key_widget('المدير', ttf, null),
  //                         value_widget('م محمد عبد الرحمن', ttf),
  //                       ]),
  //                   pw.SizedBox(height: 30),
  //                   pw.Column(
  //                       mainAxisAlignment: pw.MainAxisAlignment.start,
  //                       children: [
  //                         pw.BarcodeWidget(
  //                           data: 'www.google.com',
  //                           // EncryptData.decrypt(
  //                           //     'CVbCOEVRQ9/k4DogH2rYX3fUDLaMoC2oE8QRRsK3ppkO4rPYZo9w7XJk3Gg5Ging/beF8CDplBh77hVaXak3snMAExxHZkAweymyXaLxNJmOHLjgzUjlE7GvZ/E/JMSX/K59tNh04YHTTmftUDSIk9/RH3GZnoKL89C89mga+0j+LamivVzmdP4habgZUoXmQNwnjEXxGbAUJqORk5sKBwRJNvhcJA1UX0Bko/ClCbOUe1Gc4M6SCEVVTahQkgpXUp7RCJO4Z3o='),
  //                           //  EncryptData.encrypt(Lectures(
  //                           //         sectionID: 1223,
  //                           //         courseName: 'name in the jungle',
  //                           //         labName: 'alholom')
  //                           //     .toJson()
  //                           //     .toString()),
  //                           // '''{"name":"motsem","age":"20"}''',
  //                           barcode: pw.Barcode.qrCode(),
  //                           width: 100,
  //                           height: 100,
  //                         ),
  //                         pw.SizedBox(height: 10),
  //                         pw.BarcodeWidget(
  //                             width: 100,
  //                             height: 20,
  //                             data: 'AES0012121',
  //                             barcode: pw.Barcode.code39()),
  //                       ]),
  //                   pw.Expanded(
  //                       child: pw.Column(
  //                           mainAxisAlignment: pw.MainAxisAlignment.end,
  //                           // alignment: pw.Alignment.bottomCenter,
  //                           children: [
  //                         pw.Divider(),
  //                         key_table_widget(
  //                             'ملاحظة: هذه الرخصة ساريه المفعول لمدة سنه واحدة من تاريخ دفع الرسوم  المستحقة',
  //                             ttf,
  //                             10,
  //                             false),
  //                       ]))
  //                 ])); // Center
  //       }));
  //   await Printing.sharePdf(bytes: await doc.save(), filename: 'print1.pdf');
  // }