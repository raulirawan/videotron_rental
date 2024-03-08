import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:videotron_rental/models/transaction_model.dart';
import 'package:http/http.dart' as http;

formatDate(DateTime? date) {
  final DateFormat formatter = DateFormat('y-MM-dd');
  final String formattedDate = formatter.format(date!);

  return formattedDate;
}

convertTime(time) {
  final TimeOfDay timeOfDay = TimeOfDay(hour: time.hour, minute: time.minute);
  final String formattedTime = '${timeOfDay.hour.toString().padLeft(2,'0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';

  return formattedTime;
}

class TransactionService {
  String baseUrl = 'https://karindo.jasproweb.com/api';

  Future storeTransaction({
    String? token,
    TransactionModel? transactionModel,
  }) async {
    var url = '$baseUrl/transaction/store';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token!,
    };
    var body = jsonEncode({
      'booking_date': formatDate(transactionModel?.date),
      'end_date': formatDate(transactionModel?.dateEnd),
      'start_time': convertTime(transactionModel?.startTime),
      'end_time': convertTime(transactionModel?.endTime),
      'name_order': transactionModel?.nameCustomer,
      'phone': transactionModel?.phoneCustomer,
      'address': transactionModel?.address,
      'width': transactionModel?.width,
      'height': transactionModel?.height,
      'total_price': transactionModel?.totalPrice,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'];

      return data;
    } else {
      throw Exception('Gagal Store Transaction!');
    }
  }
}
