import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videotron_rental/models/transaction_model.dart';
import 'package:videotron_rental/pages/main_page.dart';
import 'package:videotron_rental/theme.dart';

class AddressFormPage extends StatefulWidget {
  const AddressFormPage({super.key});

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  TransactionModel? _transactionModel;
  final _controllerAddress = TextEditingController();

  void _saveModel() async {
    _transactionModel?.address = _controllerAddress.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('transaction', json.encode(_transactionModel?.toJson()));
  }

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('transaction');
    if (jsonString != null) {
      _transactionModel = TransactionModel.fromJson(jsonDecode(jsonString));
    } else {
      _transactionModel?.address = '-';
    }
    _controllerAddress.text = (_transactionModel?.address ?? '-');
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
                'Lokasi Penyewaan',
                style: primaryTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Alamat",
                style: primaryTextStyle,
              ),
              Container(
                height: 100,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: blackColor),
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                child: TextField(
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  controller: _controllerAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Alamat",
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
