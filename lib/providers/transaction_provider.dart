import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:videotron_rental/models/transaction_data_model.dart';
import 'package:videotron_rental/models/transaction_model.dart';
import 'package:videotron_rental/services/transaction_service.dart';
import 'package:http/http.dart' as http;

class TransactionProvider with ChangeNotifier {
  Future storeTransaction({
    String? token,
    TransactionModel? transactionModel,
  }) async {
    try {
      var data = await TransactionService().storeTransaction(
        token: token,
        transactionModel: transactionModel,
      );
      print('data provider : ${data}');
      return data;
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  List<TransactionDataModel> _transaction = [];

  List<TransactionDataModel> get transaction => _transaction;
// List to hold fetched data
  Future<void> getTransaction({String? token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token!,
    };

    final response = await http.get(
        Uri.parse('https://karindo.jasproweb.com/api/transaction'),
        headers: headers);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      List<TransactionDataModel> transaction = [];

      for (var item in data) {
        transaction.add(TransactionDataModel.fromJson(item));
      }
      // If the server returns a 200 OK response, parse the JSON
      // Assuming the response is a List<String>
      _transaction = transaction;
      notifyListeners(); // Notify listeners of state change
      print('tai');
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future payment({String? token, int? transactionId}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token!,
    };

    try {
      final response = await http.post(
          Uri.parse(
              'https://karindo.jasproweb.com/api/transaction/payment/${transactionId}'),
          headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];
        return data;
        // If the server returns a 200 OK response, parse the JSON
        // Assuming the response is a List<String>
      } else {
        return 'error';
      }
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  Future getInvoice({String? token, int? transactionId}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token!,
    };

    try {
      final response = await http.get(
          Uri.parse(
              'https://karindo.jasproweb.com/api/transaction/invoice/${transactionId}'),
          headers: headers);
      return response;
    } catch (e) {
      print(e);
      return 'error';
    }
  }
}
