import 'package:flutter/material.dart';
import 'package:videotron_rental/models/payment_model.dart';

class TransactionDataModel {
  int? id;
  int? userId;
  String? code;
  String? bookingDate;
  String? endDate;
  String? nameOrder;
  String? phone;
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
    this.endDate,
    this.nameOrder,
    this.phone,
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
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    nameOrder = json['name_order'];
    phone = json['phone'];
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
      'end_date': endDate,
      'start_time': startTime,
      'end_time': endTime,
      'name_order': nameOrder,
      'phone': phone,
      'address': address,
      'width': width,
      'height': height,
      'total_price': totalPrice,
      'status': status,
      'payment': payment,
    };
  }
}
