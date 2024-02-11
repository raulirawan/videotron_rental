import 'package:flutter/material.dart';
import 'package:videotron_rental/pages/history_detail_page.dart';
import 'package:videotron_rental/pages/main_page.dart';
import 'package:videotron_rental/theme.dart';
import 'package:videotron_rental/widgets/history_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/image-profile.png'),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Halo, Alfan",
                                  style: whiteTextStyle.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/icon-notification.png',
                              width: 24,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPage(
                                          selectedIndex: 1,
                                        )),
                                (route) => false);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(yellowColor),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                          child: Text(
                            "Tambah Penyewaan",
                            style: primaryTextStyle.copyWith(
                              fontWeight: bold,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "History Transaksi",
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HistoryDetailPage()));
                        },
                        child: HistoryCard()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
