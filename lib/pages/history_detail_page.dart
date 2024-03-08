import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:videotron_rental/models/transaction_data_model.dart';
import 'package:videotron_rental/providers/auth_provider.dart';
import 'package:videotron_rental/providers/transaction_provider.dart';
import 'package:videotron_rental/theme.dart';
import 'package:videotron_rental/widgets/payment_card.dart';

class HistoryDetailPage extends StatefulWidget {
  TransactionDataModel transactionDataModel;

  HistoryDetailPage({super.key, required this.transactionDataModel});

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  @override
  bool isLoading = false;
  bool storage = true;
  bool videos = true;
  bool photos = true;
  bool externalStorage = true;

  Widget build(BuildContext context) {
    Future<void> _savePdfLocally(List<int> pdfBytes) async {
      try {
        // Get the directory for storing PDF
        final directory = "/storage/emulated/0/Download/";

        final file = File('${directory}/invoice.pdf');
        await file.writeAsBytes(pdfBytes);
        var tes = await OpenFile.open('$directory/invoice.pdf');
        print('File saved to Downloads directory: $directory');
      } catch (e) {
        print(e);
      }
    }

    final authProvider = Provider.of<AuthProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);

    Future<void> requestStoragePermission() async {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      await Permission.manageExternalStorage.request();
      await Permission.photos.request();
      if (androidInfo.version.sdkInt >= 33) {
        photos = await Permission.photos.status.isGranted;
      } else {
        storage = await Permission.storage.status.isGranted;
      }
      externalStorage = await Permission.manageExternalStorage.status.isGranted;
      if (storage && photos && externalStorage) {
        var data = await transactionProvider.getInvoice(
            token: authProvider.user.token,
            transactionId: widget.transactionDataModel.id);
        // Permission granted, proceed to save file
        await _savePdfLocally(data.bodyBytes)
            .catchError((error) => print('Error: $error'));
      } else {
        // Permission denied, show a message or handle accordingly
        print('Storage permission denied');
      }

      setState(() {
        isLoading = false;
      });
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  top: defaultMargin,
                  left: 16,
                ),
                child: Image.asset(
                  'assets/icon-back.png',
                  width: 24,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon-file.png',
                    height: 24,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "History Detail Transaksi",
                    style:
                        whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 90),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Color(0xfff5f5f5),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        top: 30, left: defaultMargin, right: defaultMargin),
                    height: 170,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Data Penyewaan Videotron",
                            style: primaryTextStyle.copyWith(
                              fontWeight: bold,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nama Penyewa",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${widget.transactionDataModel.nameOrder}",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tanggal Mulai",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${convertDate(widget.transactionDataModel.bookingDate)}",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tanggal Selesai",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${convertDate(widget.transactionDataModel.endDate)}",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Waktu",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${widget.transactionDataModel.startTime} s/d ${widget.transactionDataModel.endTime}",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ukuran Videotron",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${widget.transactionDataModel.width} x ${widget.transactionDataModel.height} meter",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.transactionDataModel.payment!.isEmpty
                      ? const SizedBox()
                      : Column(
                          children: widget.transactionDataModel.payment!
                              .map((e) => PaymentCard(
                                    paymentModel: e,
                                  ))
                              .toList(),
                        ),
                  // PaymentCard(),
                  // PaymentCard(),

                  // pembayaran kedua
                  // Container(
                  //   width: double.infinity,
                  //   margin: const EdgeInsets.only(
                  //       top: 20, left: defaultMargin, right: defaultMargin),
                  //   height: 180,
                  //   decoration: BoxDecoration(
                  //     color: whiteColor,
                  //     borderRadius: BorderRadius.circular(
                  //       10,
                  //     ),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 18),
                  //     child: Column(
                  //       children: [
                  //         const SizedBox(
                  //           height: 30,
                  //         ),
                  //         Text(
                  //           "Pembayaran Kedua",
                  //           style: primaryTextStyle.copyWith(
                  //             fontWeight: bold,
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           height: 12,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Status",
                  //               style: primaryTextStyle.copyWith(
                  //                 fontSize: 12,
                  //               ),
                  //             ),
                  //             Text(
                  //               "Success",
                  //               style: primaryTextStyle.copyWith(
                  //                 fontSize: 12,
                  //                 fontWeight: bold,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Total",
                  //               style: primaryTextStyle.copyWith(
                  //                 fontSize: 12,
                  //               ),
                  //             ),
                  //             Text(
                  //               "Rp. 20.000.000",
                  //               style: primaryTextStyle.copyWith(
                  //                 fontSize: 12,
                  //                 fontWeight: bold,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Container(
                  //           margin: EdgeInsets.only(
                  //             top: 20,
                  //           ),
                  //           width: double.infinity,
                  //           child: ElevatedButton(
                  //             onPressed: () {},
                  //             style: ButtonStyle(
                  //               backgroundColor:
                  //                   MaterialStatePropertyAll(yellowColor),
                  //               shape: MaterialStatePropertyAll(
                  //                 RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(7),
                  //                 ),
                  //               ),
                  //             ),
                  //             child: Text(
                  //               "Bayar",
                  //               style: primaryTextStyle.copyWith(
                  //                 fontWeight: bold,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                  vertical: defaultMargin,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    requestStoragePermission();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(yellowColor),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: whiteColor,
                        )
                      : Text(
                          "Unduh Invoice",
                          style: primaryTextStyle.copyWith(
                            fontWeight: bold,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
