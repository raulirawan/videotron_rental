import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videotron_rental/models/transaction_model.dart';
import 'package:videotron_rental/pages/date_form_page.dart';
import 'package:videotron_rental/theme.dart';
import 'package:videotron_rental/widgets/form_card.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({super.key});

  @override
  State<RentalPage> createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {
  TransactionModel? _transactionModel;

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('transaction');
    if (jsonString != null) {
      _transactionModel = TransactionModel.fromJson(jsonDecode(jsonString));
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  convertDate(DateTime? date) {
    // Intl.defaultLocale = 'id';
    String formattedDate = DateFormat('d MMMM, yyyy').format(date!);

    var day = DateFormat('EEEE').format(date);
    var hari = "";
    switch (day) {
      case 'Sunday':
        {
          hari = "Minggu";
        }
        break;
      case 'Monday':
        {
          hari = "Senin";
        }
        break;
      case 'Tuesday':
        {
          hari = "Selasa";
        }
        break;
      case 'Wednesday':
        {
          hari = "Rabu";
        }
        break;
      case 'Thursday':
        {
          hari = "Kamis";
        }
        break;
      case 'Friday':
        {
          hari = "Jumat";
        }
        break;
      case 'Saturday':
        {
          hari = "Sabtu";
        }
        break;
    }
    return '$hari, $formattedDate';
  }

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
                      "Pesanan Anda",
                      style: whiteTextStyle.copyWith(
                          fontSize: 16, fontWeight: bold),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 90),
                height: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color(0xfff5f5f5),
                ),
                // data pesanan
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: const EdgeInsets.only(
                      left: defaultMargin, right: defaultMargin, top: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Data Pesanan",
                          style: subtitleTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Ringkasan Penyewaan anda",
                          style: subtitleTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormCard(
                            title:
                                '${convertDate(_transactionModel?.date ?? DateTime.now())}',
                            isSubtitle: false,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DateFormPage()));
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Pemesan",
                          style: subtitleTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Kami akan mengirimkan semua e-tiket/voucher dari\npesanan ini kepada kontak yang diisi di profil kamu",
                          style: subtitleTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormCard(
                            title: 'Alfan',
                            subtitle: "+62812345678",
                            isSubtitle: true,
                            onTap: () {
                              print('ok');
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Ukuran Penyewaan",
                          style: subtitleTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Lakukan pembayaran anda dengan mudah",
                          style: subtitleTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormCard(
                            title: '....... M x ..... M',
                            isSubtitle: false,
                            onTap: () {
                              print('ok');
                            }),

                        // lokasi penyewaaan
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Lokasi Penyewaan",
                          style: subtitleTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Ringkasan Penyewaan  anda",
                          style: subtitleTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormCard(
                            title: 'Gedun Pemkot Bekasi, Jl. Uta.....',
                            isSubtitle: false,
                            onTap: () {
                              print('ok');
                            }),

                        // lokasi penyewaaan
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Sales",
                          style: subtitleTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Team Sales PT. Karindo Mitra Internasional",
                          style: subtitleTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormCard(
                            title: 'Joko Tama',
                            subtitle: '+62834-6789-5678',
                            isSubtitle: true,
                            onTap: () {
                              print('ok');
                            }),

                        const SizedBox(
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: defaultMargin,
                    right: defaultMargin,
                    top: 20,
                  ),
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: whiteColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Harga Total",
                            style: primaryTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "Rp. 300.000.000",
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {},
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
                              "Pembayaran",
                              style: primaryTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: semiBold,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
