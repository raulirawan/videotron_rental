import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:videotron_rental/models/payment_model.dart';
import 'package:videotron_rental/pages/payment_page.dart';
import 'package:videotron_rental/providers/auth_provider.dart';
import 'package:videotron_rental/providers/transaction_provider.dart';
import 'package:videotron_rental/theme.dart';

class PaymentCard extends StatelessWidget {
  PaymentModel paymentModel;
  PaymentCard({super.key, required this.paymentModel});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
          top: 20, left: defaultMargin, right: defaultMargin),
      height: 180,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Pembayaran Pertama",
              style: primaryTextStyle.copyWith(
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status",
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${paymentModel.status}",
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  "Rp. ${NumberFormat().format(paymentModel.totalPrice)}",
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    if (paymentModel.paymentUrl == null) {
                      // generate payment
                      var data = await transactionProvider.payment(
                          token: authProvider.user.token,
                          transactionId: paymentModel.transactionId);
                      if (data != 'error') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaymentPage(data['payment_url'])),
                          (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(
                              milliseconds: 1000,
                            ),
                            backgroundColor: alertColor,
                            content: const Text(
                              "Pembayaran Gagal Coba Lagi!",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    } else {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaymentPage(paymentModel.paymentUrl)),
                          (route) => false);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(yellowColor),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  child: Text(
                    "Bayar",
                    style: primaryTextStyle.copyWith(
                      fontWeight: bold,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
