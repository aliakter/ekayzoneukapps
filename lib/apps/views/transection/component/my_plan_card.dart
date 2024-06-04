import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/views/transection/controller/transection_controller.dart';
import 'package:ekayzoneukapps/apps/views/transection/model/transaction_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class MyPlanCard extends StatefulWidget {
  const MyPlanCard({super.key,
    required this.transactionModel,
    required this.transactionController});

  final TransactionModel transactionModel;
  final TransactionController transactionController;

  @override
  State<MyPlanCard> createState() => _MyPlanCardState();
}

class _MyPlanCardState extends State<MyPlanCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order Id: ${widget.transactionModel.orderId}"),
                      const Text("Package: ${1} for ${3}"),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // createPDF(filename: '${widget.plansBillingModel.orderId}', context: context, index: widget.index);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.download, size: 24, color: redColor),
                        SizedBox(width: 3),
                        Text(
                          "Invoice",
                          style: TextStyle(
                              color: redColor, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "Amount: \$${widget.transactionModel.amount}",
                style:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Text(
                  "Date: ${Utils.formatDate(
                      widget.transactionModel.createdAt)}"),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text("Status: "),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFf157347),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      widget.transactionController
                          .capitalize(widget.transactionModel.paymentStatus),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(color: Colors.black12),
      ],
    );
  }

  // final pdf = pw.Document();
  // int apiLevel = 0;

  // Future<void> createPDF({filename, context, index}) async {
  //   // final iconImage = (await rootBundle.load('assets/images/mtg_logo_full.png'))
  //   //     .buffer
  //   //     .asUint8List();
  //
  //   DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //   final androidInfo = await deviceInfoPlugin.androidInfo;
  //   apiLevel = androidInfo.version.sdkInt;
  //   PermissionStatus storagePermission;
  //   if (apiLevel >= 33) {
  //     storagePermission = await Permission.manageExternalStorage.request();
  //   } else {
  //     storagePermission = await Permission.storage.request();
  //   }
  //
  //   if (storagePermission == PermissionStatus.granted) {
  //     try {
  //       pdf.addPage(
  //         pw.MultiPage(
  //           pageFormat: PdfPageFormat.a4,
  //           build: (context) {
  //             return [
  //               pw.Container(
  //                 width: double.infinity,
  //                 padding: const pw.EdgeInsets.all(10),
  //                 decoration: const pw.BoxDecoration(
  //                   color: PdfColors.grey300,
  //                 ),
  //                 child: pw.Text(
  //                   "Customer Invoice",
  //                   style: pw.TextStyle(
  //                       fontWeight: pw.FontWeight.bold, fontSize: 18),
  //                 ),
  //               ),
  //
  //               pw.SizedBox(height: 10 * PdfPageFormat.mm),
  //
  //               pw.Row(
  //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                 children: [
  //                   pw.SizedBox(width: 1 * PdfPageFormat.mm),
  //                   pw.Column(
  //                     mainAxisSize: pw.MainAxisSize.min,
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.Text(
  //                         'Sold from,',
  //                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
  //                       ),
  //                       pw.Text(
  //                         'Ekayzone UK',
  //                         style: pw.TextStyle(
  //                           fontWeight: pw.FontWeight.bold,
  //                           fontSize: 20,
  //                         ),
  //                       ),
  //                       pw.Text(
  //                         'support@shikaafi.co.uk',
  //                         style: pw.TextStyle(
  //                             color: PdfColors.black,
  //                             fontWeight: pw.FontWeight.bold),
  //                       ),
  //                       pw.SizedBox(height: 5),
  //                       pw.Text(
  //                         '+441258927052',
  //                         style: pw.TextStyle(
  //                             color: PdfColors.black,
  //                             fontWeight: pw.FontWeight.bold),
  //                       ),
  //                       pw.SizedBox(height: 5),
  //                       pw.SizedBox(
  //                         width: 250,
  //                         child: pw.Text(
  //                           'Shikaafi\'s Innovation and Technologies Ltd 23, New Drum Street, London, England, E1 7AY, United kingdom Registration no 14518092',
  //                           style: pw.TextStyle(
  //                               color: PdfColors.black,
  //                               fontWeight: pw.FontWeight.bold),
  //                           maxLines: 3,
  //                           overflow: pw.TextOverflow.span,
  //                         ),
  //                       ),
  //                       pw.SizedBox(height: 5),
  //                       pw.Text(
  //                         'INVOICE NO: ${widget.transactionModel.orderId}',
  //                         style: pw.TextStyle(
  //                             color: PdfColors.black,
  //                             fontWeight: pw.FontWeight.bold),
  //                       ),
  //                       pw.SizedBox(height: 10),
  //                     ],
  //                   ),
  //                   pw.Spacer(),
  //                   pw.Column(
  //                     mainAxisSize: pw.MainAxisSize.min,
  //                     crossAxisAlignment: pw.CrossAxisAlignment.end,
  //                     children: [
  //                       pw.Text(
  //                         'Sold to,',
  //                         style: pw.TextStyle(
  //                           fontWeight: pw.FontWeight.bold,
  //                         ),
  //                       ),
  //                       pw.SizedBox(height: 5),
  //                       pw.Text(
  //                         '${widget.transactionModel.?.username}',
  //                         style: pw.TextStyle(
  //                           fontWeight: pw.FontWeight.bold,
  //                           fontSize: 20,
  //                         ),
  //                       ),
  //                       pw.SizedBox(height: 5),
  //                       pw.Text(
  //                         '${widget.plansBillingModel.customer?.email}',
  //                         style: pw.TextStyle(
  //                           fontWeight: pw.FontWeight.bold,
  //                         ),
  //                       ),
  //                       pw.SizedBox(height: 5),
  //                       pw.Text(
  //                         '${widget.plansBillingModel.customer?.phone}',
  //                         style: pw.TextStyle(
  //                           fontWeight: pw.FontWeight.bold,
  //                         ),
  //                       ),
  //                       pw.SizedBox(height: 5),
  //                       pw.Text(
  //                         '${widget.plansBillingModel.customer?.address}',
  //                         style: pw.TextStyle(
  //                           fontWeight: pw.FontWeight.bold,
  //                         ),
  //                       ),
  //                       pw.SizedBox(height: 5),
  //                       pw.Text(
  //                         'INVOICE DATE : ${DateFormat('dd-MMM-yyyy').format(
  //                             DateTime.parse(widget.transactionModel.createdAt
  //                                 .toString()))}',
  //                         style: pw.TextStyle(
  //                           fontWeight: pw.FontWeight.bold,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               pw.SizedBox(height: 10 * PdfPageFormat.mm),
  //
  //               //ROW 1
  //               pw.Container(
  //                 padding: const pw.EdgeInsets.all(5),
  //                 decoration: const pw.BoxDecoration(
  //                   border: pw.Border(
  //                     bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     left: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     right: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                   ),
  //                   color: PdfColors.grey200,
  //                 ),
  //                 child: pw.Row(children: [
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerLeft,
  //                           child: pw.Text("Customer Name",
  //                               style: pw.TextStyle(
  //                                   fontWeight: pw.FontWeight.bold))),
  //                       flex: 3),
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerRight,
  //                           child: pw.Text(
  //                               "${widget.plansBillingModel.customer?.name}")),
  //                       flex: 3),
  //                 ]),
  //               ),
  //
  //               //ROW 2
  //               pw.Container(
  //                 padding: const pw.EdgeInsets.all(5),
  //                 decoration: const pw.BoxDecoration(
  //                   border: pw.Border(
  //                     bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     left: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     right: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                   ),
  //                   color: PdfColors.white,
  //                 ),
  //                 child: pw.Row(children: [
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerLeft,
  //                           child: pw.Text("Ad Title",
  //                               style: pw.TextStyle(
  //                                   fontWeight: pw.FontWeight.bold))),
  //                       flex: 3),
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerRight,
  //                           child: pw.Text(
  //                             "${widget.plansBillingModel.adModel?.title}",
  //                           )),
  //                       flex: 3),
  //                 ]),
  //               ),
  //
  //               //ROW 3
  //               pw.Container(
  //                 padding: const pw.EdgeInsets.all(5),
  //                 decoration: const pw.BoxDecoration(
  //                   border: pw.Border(
  //                     bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     left: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     right: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                   ),
  //                   color: PdfColors.grey200,
  //                 ),
  //                 child: pw.Row(children: [
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerLeft,
  //                           child: pw.Text("Category",
  //                               style: pw.TextStyle(
  //                                   fontWeight: pw.FontWeight.bold))),
  //                       flex: 3),
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerRight,
  //                           child: pw.Text(
  //                               "${widget.plansBillingModel.adModel?.category
  //                                   ?.name}")),
  //                       flex: 3),
  //                 ]),
  //               ),
  //
  //               //ROW 4
  //               pw.Container(
  //                 padding: const pw.EdgeInsets.all(5),
  //                 decoration: const pw.BoxDecoration(
  //                   border: pw.Border(
  //                     bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     left: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     right: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                   ),
  //                   color: PdfColors.white,
  //                 ),
  //                 child: pw.Row(children: [
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerLeft,
  //                           child: pw.Text("Promotion Name",
  //                               style: pw.TextStyle(
  //                                   fontWeight: pw.FontWeight.bold))),
  //                       flex: 3),
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerRight,
  //                           child: pw.Text(
  //                               "${widget.plansBillingModel.promotion
  //                                   ?.title}")),
  //                       flex: 3),
  //                 ]),
  //               ),
  //
  //               //ROW 5
  //               pw.Container(
  //                 padding: const pw.EdgeInsets.all(5),
  //                 decoration: const pw.BoxDecoration(
  //                   border: pw.Border(
  //                     bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     left: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     right: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                   ),
  //                   color: PdfColors.grey200,
  //                 ),
  //                 child: pw.Row(children: [
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerLeft,
  //                           child: pw.Text("Order ID",
  //                               style: pw.TextStyle(
  //                                   fontWeight: pw.FontWeight.bold))),
  //                       flex: 3),
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerRight,
  //                           child:
  //                           pw.Text("${widget.plansBillingModel.orderId}")),
  //                       flex: 3),
  //                 ]),
  //               ),
  //
  //               //ROW 6
  //               pw.Container(
  //                 padding: const pw.EdgeInsets.all(5),
  //                 decoration: const pw.BoxDecoration(
  //                   border: pw.Border(
  //                     bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     left: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     right: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                   ),
  //                   color: PdfColors.white,
  //                 ),
  //                 child: pw.Row(children: [
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerLeft,
  //                           child: pw.Text("Transaction ID",
  //                               style: pw.TextStyle(
  //                                   fontWeight: pw.FontWeight.bold))),
  //                       flex: 3),
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerRight,
  //                           child: pw.Text(
  //                               "${widget.plansBillingModel.transactionId}")),
  //                       flex: 3),
  //                 ]),
  //               ),
  //
  //               //ROW 7
  //               pw.Container(
  //                 padding: const pw.EdgeInsets.all(5),
  //                 decoration: const pw.BoxDecoration(
  //                   border: pw.Border(
  //                     bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     left: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     right: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                   ),
  //                   color: PdfColors.grey200,
  //                 ),
  //                 child: pw.Row(children: [
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerLeft,
  //                           child: pw.Text("Amount",
  //                               style: pw.TextStyle(
  //                                   fontWeight: pw.FontWeight.bold))),
  //                       flex: 3),
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerRight,
  //                           child: pw.Text(
  //                             "${widget.plansBillingModel.amount}",
  //                           )),
  //                       flex: 3),
  //                 ]),
  //               ),
  //
  //               //ROW 8
  //               pw.Container(
  //                 padding: const pw.EdgeInsets.all(5),
  //                 decoration: const pw.BoxDecoration(
  //                   border: pw.Border(
  //                     bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     left: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     right: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                   ),
  //                   color: PdfColors.white,
  //                 ),
  //                 child: pw.Row(children: [
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerLeft,
  //                           child: pw.Text("Payment Method",
  //                               style: pw.TextStyle(
  //                                   fontWeight: pw.FontWeight.bold))),
  //                       flex: 3),
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerRight,
  //                           child: pw.Text(
  //                             "${widget.plansBillingModel.paymentProvider}",
  //                           )),
  //                       flex: 3),
  //                 ]),
  //               ),
  //
  //               //ROW 9
  //               pw.Container(
  //                 padding: const pw.EdgeInsets.all(5),
  //                 decoration: const pw.BoxDecoration(
  //                   border: pw.Border(
  //                     bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     left: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     right: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                   ),
  //                   color: PdfColors.grey200,
  //                 ),
  //                 child: pw.Row(children: [
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerLeft,
  //                           child: pw.Text("Area",
  //                               style: pw.TextStyle(
  //                                   fontWeight: pw.FontWeight.bold))),
  //                       flex: 3),
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerRight,
  //                           child: pw.Text(
  //                             "${widget.plansBillingModel.customer?.address}",
  //                           )),
  //                       flex: 3),
  //                 ]),
  //               ),
  //
  //               //ROW 10
  //               pw.Container(
  //                 padding: const pw.EdgeInsets.all(5),
  //                 decoration: const pw.BoxDecoration(
  //                   border: pw.Border(
  //                     bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     left: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     right: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                   ),
  //                   color: PdfColors.white,
  //                 ),
  //                 child: pw.Row(children: [
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerLeft,
  //                           child: pw.Text("Payment Status",
  //                               style: pw.TextStyle(
  //                                   fontWeight: pw.FontWeight.bold))),
  //                       flex: 3),
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerRight,
  //                           child: pw.Text(
  //                             "${widget.plansBillingModel.paymentStatus}",
  //                           )),
  //                       flex: 3),
  //                 ]),
  //               ),
  //
  //               //ROW 11
  //               pw.Container(
  //                 padding: const pw.EdgeInsets.all(5),
  //                 decoration: const pw.BoxDecoration(
  //                   border: pw.Border(
  //                     bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     left: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                     right: pw.BorderSide(width: 1, color: PdfColors.grey300),
  //                   ),
  //                   color: PdfColors.grey200,
  //                 ),
  //                 child: pw.Row(children: [
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerLeft,
  //                           child: pw.Text("Transaction Date",
  //                               style: pw.TextStyle(
  //                                   fontWeight: pw.FontWeight.bold))),
  //                       flex: 3),
  //                   pw.Expanded(
  //                       child: pw.Container(
  //                           alignment: pw.Alignment.centerRight,
  //                           child: pw.Text(
  //                             "${DateFormat('d MMM yyyy').format(DateTime.parse(
  //                                 widget.plansBillingModel.createdAt))}",
  //                           )),
  //                       flex: 3),
  //                 ]),
  //               ),
  //             ];
  //           },
  //         ),
  //       );
  //
  //       final bytes = await pdf.save();
  //
  //       SaveFile.saveAndLaunchFile(
  //           bytes, 'safestore_$filename.pdf', apiLevel, context);
  //     } catch (e) {
  //       print("Error $e ");
  //
  //       apiLevel >= 33
  //           ? ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("Already saved in your device"),
  //         ),
  //       )
  //           : ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: const Text("Already saved in your device"),
  //           action: SnackBarAction(
  //             label: "Open",
  //             onPressed: () {
  //               OpenFile.open(
  //                   '/storage/emulated/0/Download/safestore_$filename.pdf');
  //             },
  //           ),
  //         ),
  //       );
  //       //   print("Saved already");
  //     }
  //   } else if (storagePermission.isDenied) {
  //     Utils.toastMsg("Required Storage Permission");
  //     openAppSettings();
  //   } else if (storagePermission.isPermanentlyDenied) {
  //     await openAppSettings();
  //     // _createPDF();
  //   }
  //   // else {
  //   //   print("xxxxxxxxxxxxxxxxxxxxx general xxxxxxxxxxxxxxxxxxxxxxxxxx");
  //   //   Map<Permission, PermissionStatus> statuses = await [
  //   //     Permission.storage,
  //   //   ].request();
  //   //   Future.delayed(const Duration(seconds: 1)).then((value) => _createPDF());
  //   // }
  // }
}
