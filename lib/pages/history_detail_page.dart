import 'package:flutter/material.dart';
import 'package:videotron_rental/theme.dart';

class HistoryDetailPage extends StatelessWidget {
  const HistoryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        top: 60, left: defaultMargin, right: defaultMargin),
                    height: 200,
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
                                "Tanggal",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Sabtu, 3 Januari 2023",
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
                                "16:00 s/d 18:00",
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
                                "10 x 10 meter",
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
                                "Status Pembayaran",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Success",
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
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
