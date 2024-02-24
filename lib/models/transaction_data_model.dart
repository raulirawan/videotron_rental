import 'package:flutter/material.dart';
import 'package:videotron_rental/models/payment_model.dart';

class TransactionDataModel {
  int? id;
  int? userId;
  String? code;
  String? bookingDate;
  String? startTime;
  String? endTime;
  String? address;
  int? width;
  int? height;
  int? totalPrice;
  String? status;
  List<PaymentModel>? payment;

  TransactionDataModel({
    this.id,
    this.userId,
    this.code,
    this.bookingDate,
    this.startTime,
    this.endTime,
    this.address,
    this.width,
    this.height,
    this.totalPrice,
    this.status,
    this.payment,
  });

  TransactionDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    code = json['code'];
    bookingDate = json['booking_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    address = json['address'];
    width = json['width'];
    height = json['height'];
    totalPrice = json['total_price'];
    status = json['status'];
    payment = json['payment']
        .map<PaymentModel>((element) => PaymentModel.fromJson(element))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'code': code,
      'booking_date': bookingDate,
      'start_time': startTime,
      'end_time': endTime,
      'address': address,
      'width': width,
      'height': height,
      'total_price': totalPrice,
      'status': status,
      'payment': payment,
    };
  }
}
