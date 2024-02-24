import 'package:flutter/foundation.dart';
import 'package:videotron_rental/models/transaction_model.dart';
import 'package:videotron_rental/services/transaction_service.dart';

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
}
