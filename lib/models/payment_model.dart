class PaymentModel {
  int? id;
  int? transactionId;
  String? code;
  String? status;
  String? paymentUrl;
  int? totalPrice;

  PaymentModel({
    this.id,
    this.transactionId,
    this.code,
    this.status,
    this.paymentUrl,
    this.totalPrice,
  });

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    code = json['code'];
    status = json['status'];
    paymentUrl = json['payment_url'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transaction_id': transactionId,
      'code': code,
      'status': status,
      'payment_url': paymentUrl,
      'total_price': totalPrice,
    };
  }
}
