import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videotron_rental/models/transaction_model.dart';
import 'package:videotron_rental/pages/address_form_page.dart';
import 'package:videotron_rental/pages/date_form_page.dart';
import 'package:videotron_rental/pages/main_page.dart';
import 'package:videotron_rental/pages/orderer_form_page.dart';
import 'package:videotron_rental/pages/payment_page.dart';
import 'package:videotron_rental/pages/size_form_page.dart';
import 'package:videotron_rental/providers/auth_provider.dart';
import 'package:videotron_rental/providers/transaction_provider.dart';
import 'package:videotron_rental/theme.dart';
import 'package:videotron_rental/widgets/form_card.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({super.key});

  @override
  State<RentalPage> createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {
  bool isLoading = false;
  TransactionModel? _transactionModel;
  late AuthProvider authProvider;

  Future<void> _loadData() async {
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('transaction');
    if (jsonString != null) {
      _transactionModel = TransactionModel.fromJson(jsonDecode(jsonString));
    } else {
      _transactionModel = TransactionModel(
        date: DateTime.now(),
        dateEnd: DateTime.now(),
        startTime: TimeOfDay.now(),
        endTime: TimeOfDay.now(),
        nameCustomer: authProvider.user.name,
        phoneCustomer: authProvider.user.phone,
        nameSales: 'Jawa',
        phoneSales: '08123984224',
        address: '-',
        width: 1,
        height: 1,
        totalPrice: 0,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('transaction', json.encode(_transactionModel?.toJson()));
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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPage(selectedIndex: 0)), (route) => false);
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
                            isButton: true,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DateFormPage()));
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
                            title: _transactionModel?.nameCustomer ?? '-',
                            subtitle: _transactionModel?.phoneCustomer ?? '-',
                            isButton: true,
                            isSubtitle: true,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OrdererFormPage()));
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
                            title:
                                '${_transactionModel?.width ?? 1} M x ${_transactionModel?.height ?? 1} M',
                            isButton: true,
                            isSubtitle: false,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SizeFormPage()));
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
                            title: _transactionModel?.address ?? '-',
                            isButton: true,
                            isSubtitle: false,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddressFormPage()));
                            }),

                        // lokasi penyewaaan
                        const SizedBox(
                          height: 40,
                        ),
                        (authProvider.user.roles == 'SALES')
                            ? Text(
                                "Sales",
                                style: subtitleTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: bold,
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 5,
                        ),
                        (authProvider.user.roles == 'SALES')
                            ? Text(
                                "Team Sales PT. Karindo Mitra Internasional",
                                style: subtitleTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        (authProvider.user.roles == 'SALES')
                            ? FormCard(
                                title: '${authProvider.user.name}',
                                subtitle: '${authProvider.user.phone}',
                                isSubtitle: true,
                                onTap: () {
                                  print('ok');
                                })
                            : const SizedBox(),

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
                            "Rp. ${_transactionModel?.totalPrice != null ? NumberFormat().format(_transactionModel?.totalPrice) : 0}",
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
                            onPressed: () async {
                              if (_transactionModel?.totalPrice == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(
                                      milliseconds: 1000,
                                    ),
                                    backgroundColor: alertColor,
                                    content: const Text(
                                      "Data Belum Lengkap",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                              setState(() {
                                isLoading = true;
                              });
                              var data =
                                  await transactionProvider.storeTransaction(
                                      token: authProvider.user.token,
                                      transactionModel: _transactionModel);
                              if (data != 'error') {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PaymentPage(data['payment_url'])),
                                  (route) => false,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(
                                      milliseconds: 1000,
                                    ),
                                    backgroundColor: alertColor,
                                    content: const Text(
                                      "Transaksi Gagal Coba Lagi!",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }

                              setState(() {
                                isLoading = false;
                              });
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
                            child: (isLoading)
                                ? CircularProgressIndicator(
                                    color: whiteColor,
                                  )
                                : Text(
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
