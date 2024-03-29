import 'package:flutter/material.dart';

class TransactionModel {
  DateTime? date = DateTime.now();
  DateTime? dateEnd = DateTime.now();
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? nameCustomer;
  String? phoneCustomer;
  int? width;
  int? height;
  String? address;
  String? nameSales;
  String? phoneSales;
  int? totalPrice;

  TransactionModel({
    this.date,
    this.dateEnd,
    this.startTime,
    this.endTime,
    this.nameCustomer,
    this.phoneCustomer,
    this.width,
    this.height,
    this.address,
    this.nameSales,
    this.phoneSales,
    this.totalPrice,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    date = json['date'] != null ? DateTime.parse(json['date']) : DateTime.now();
    dateEnd = json['date_end'] != null ? DateTime.parse(json['date_end']) : DateTime.now();
    final timeOfDayStringStart = json['start_time'];
    final timeOfDayPartsStart = timeOfDayStringStart
        .substring(10, timeOfDayStringStart.length - 1)
        .split(':');

    final timeOfDayStringEnd = json['end_time'];
    final timeOfDayPartsEnd = timeOfDayStringEnd
        .substring(10, timeOfDayStringEnd.length - 1)
        .split(':');
    startTime = TimeOfDay(
        hour: int.parse(timeOfDayPartsStart[0]),
        minute: int.parse(timeOfDayPartsStart[1]));
    endTime = TimeOfDay(
        hour: int.parse(timeOfDayPartsEnd[0]),
        minute: int.parse(timeOfDayPartsEnd[1]));

    nameCustomer = json['name_customer'];
    phoneCustomer = json['phone_customer'];
    width = json['width'];
    height = json['height'];
    address = json['address'];
    nameSales = json['name_sales'];
    phoneSales = json['phone_sales'];
    totalPrice = json['total_price'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date?.toIso8601String();
    data['date_end'] = dateEnd?.toIso8601String();
    data['start_time'] = startTime?.toString();
    data['end_time'] = endTime?.toString();
    data['name_customer'] = nameCustomer;
    data['phone_customer'] = phoneCustomer;
    data['width'] = width?.toInt();
    data['height'] = height?.toInt();
    data['address'] = address;
    data['name_sales'] = nameSales;
    data['phone_sales'] = phoneSales;
    data['total_price'] = totalPrice;

    print(data);
    return data;
  }
}
