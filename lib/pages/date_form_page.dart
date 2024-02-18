import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videotron_rental/models/transaction_model.dart';
import 'package:videotron_rental/pages/main_page.dart';
import 'package:videotron_rental/theme.dart';

class DateFormPage extends StatefulWidget {
  const DateFormPage({super.key});

  @override
  State<DateFormPage> createState() => _DateFormPageState();
}

class _DateFormPageState extends State<DateFormPage> {
  TransactionModel? _transactionModel;
  final _controllerStartTime = TextEditingController();
  final _controllerEndTime = TextEditingController();
  final _controllerDate = TextEditingController();

  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectTimeStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _transactionModel?.startTime ?? _selectedStartTime,
    );
    if (picked != null) {
      setState(() {
        _selectedStartTime = picked;
        _controllerStartTime.text = picked.format(context);
        // _transactionModel = TransactionModel(
        //     startTime: picked,
        //     endTime: _transactionModel?.endTime ?? _selectedEndTime,
        //     date: _transactionModel?.date ?? _selectedDate);

        _transactionModel?.date = _transactionModel?.date ?? _selectedDate;
        _transactionModel?.startTime = picked;
        _transactionModel?.endTime =
            _transactionModel?.endTime ?? _selectedEndTime;
      });
    }
  }

  Future<void> _selectTimeEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _transactionModel?.startTime ?? _selectedEndTime,
    );
    if (picked != null) {
      setState(() {
        _selectedEndTime = picked;
        _controllerEndTime.text = picked.format(context);
        // _transactionModel = TransactionModel(
        //     startTime: _transactionModel?.startTime ?? _selectedStartTime,
        //     endTime: picked,
        //     date: _transactionModel?.date ?? _selectedDate);

        _transactionModel?.date = _transactionModel?.date ?? _selectedDate;
        _transactionModel?.startTime =
            _transactionModel?.startTime ?? _selectedStartTime;
        _transactionModel?.endTime = picked;
      });
    }
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _transactionModel?.date ?? _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controllerDate.text =
            _selectedDate.toLocal().toIso8601String().split('T')[0];

        _transactionModel?.date = picked;
        _transactionModel?.startTime =
            _transactionModel?.startTime ?? _selectedStartTime;
        _transactionModel?.endTime =
            _transactionModel?.endTime ?? _selectedEndTime;
        // _transactionModel = TransactionModel(
        //     startTime: _transactionModel?.startTime ?? _selectedStartTime,
        //     endTime: _transactionModel?.endTime ?? _selectedEndTime,
        //     date: picked);
      });
    }
  }

  void _saveModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('transaction', json.encode(_transactionModel?.toJson()));
  }

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('transaction');
    if (jsonString != null) {
      _transactionModel = TransactionModel.fromJson(jsonDecode(jsonString));
    } else {
      _transactionModel?.date = DateTime.now();
      _transactionModel?.startTime = TimeOfDay.now();
      _transactionModel?.endTime = TimeOfDay.now();
    }
    _controllerDate.text =
        _transactionModel!.date!.toLocal().toIso8601String().split('T')[0];
    _controllerStartTime.text = (_transactionModel!.startTime != null
        ? _transactionModel?.startTime?.format(context)
        : _selectedStartTime.format(context))!;
    _controllerEndTime.text = (_transactionModel!.endTime != null
        ? _transactionModel?.endTime?.format(context)
        : _selectedEndTime.format(context))!;
  }

  @override
  void initState() {
    super.initState();
    // _controllerDate.text =
    //     _selectedDate.toLocal().toIso8601String().split('T')[0];
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
                'Hari & Jam Penyewaan',
                style: primaryTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Tanggal",
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
                  readOnly: true,
                  controller: _controllerDate,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Tanggal",
                    hintStyle: primaryTextStyle,
                    fillColor: Colors.red,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.date_range),
                      onPressed: () {
                        _showDatePicker(context);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Waktu Mulai",
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
                  readOnly: true,
                  controller: _controllerStartTime,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Waktu Mulai",
                    hintStyle: primaryTextStyle,
                    fillColor: Colors.red,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () {
                        _selectTimeStartTime(context);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Waktu Selesai",
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
                  readOnly: true,
                  controller: _controllerEndTime,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Waktu Selesai",
                    hintStyle: primaryTextStyle,
                    fillColor: Colors.red,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () {
                        _selectTimeEndTime(context);
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // _transactionModel = TransactionModel()
                    _saveModel();
                    // Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainPage(
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
