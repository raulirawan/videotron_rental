import 'package:flutter/material.dart';

class TransactionModel {
  DateTime? date = DateTime.now();
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  TransactionModel({this.date, this.startTime, this.endTime});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    date = DateTime.parse(json['date']);
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

    // startTime = json['start_time'];
    // endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date?.toIso8601String();
    data['start_time'] = startTime?.toString();
    data['end_time'] = endTime?.toString();
    return data;
  }

  toLocal() {}
}
