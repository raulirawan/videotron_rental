import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videotron_rental/models/transaction_model.dart';
import 'package:videotron_rental/pages/main_page.dart';
import 'package:videotron_rental/services/transaction_service.dart';
import 'package:videotron_rental/theme.dart';

class SizeFormPage extends StatefulWidget {
  const SizeFormPage({super.key});

  @override
  State<SizeFormPage> createState() => _SizeFormPageState();
}

class _SizeFormPageState extends State<SizeFormPage> {
  TransactionModel? _transactionModel;
  final _controllerWidth = TextEditingController();
  final _controllerHeight = TextEditingController();

  void _saveModel() async {
    int daysDifference = differenceInDays(formatDate(_transactionModel?.date ?? DateTime.now()), formatDate(_transactionModel?.dateEnd ?? DateTime.now()));

    _transactionModel?.width = int.parse(_controllerWidth.text);
    _transactionModel?.height = int.parse(_controllerHeight.text);

    int totalSize =
        int.parse(_controllerWidth.text) * int.parse(_controllerHeight.text);

    int totalPrice = (price * totalSize) * (daysDifference == 0 ? 1 : daysDifference);
    
    _transactionModel?.totalPrice = totalPrice;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('transaction', json.encode(_transactionModel?.toJson()));
  }

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('transaction');
    if (jsonString != null) {
      _transactionModel = TransactionModel.fromJson(jsonDecode(jsonString));
    } else {
      _transactionModel?.width = 1;
      _transactionModel?.height = 1;
    }
    _controllerWidth.text = (_transactionModel?.width.toString() ?? '1');
    _controllerHeight.text = (_transactionModel?.height.toString() ?? '1');
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ukuran Penyewaan',
                style: primaryTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Lebar",
                style: primaryTextStyle,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: blackColor),
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _controllerWidth,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Lebar",
                    hintStyle: primaryTextStyle,
                    fillColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Panjang",
                style: primaryTextStyle,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: blackColor),
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _controllerHeight,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Panjang",
                    hintStyle: primaryTextStyle,
                    fillColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    _saveModel();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage(
                                  selectedIndex: 1,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Simpan",
                    style: blackTextStyle.copyWith(fontWeight: semiBold),
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
