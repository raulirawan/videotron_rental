import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:videotron_rental/models/transaction_data_model.dart';
import 'package:videotron_rental/providers/transaction_provider.dart';
import 'package:videotron_rental/theme.dart';

class HistoryCard extends StatelessWidget {
  TransactionDataModel transactionDataModel;
  HistoryCard({super.key, required this.transactionDataModel});

  @override
  convertDate(String? date) {
    // Intl.defaultLocale = 'id';
    DateTime dateTimeWithTimeZone = DateTime.parse(date!);
    String formattedDate =
        DateFormat('d MMMM, yyyy').format(dateTimeWithTimeZone);

    var day = DateFormat('EEEE').format(dateTimeWithTimeZone);
    var hari = "";
    switch (day) {
      case 'Sunday':
        {
          hari = "Minggu";
        }
        break;
      case 'Monday':
        {
          hari = "Senin";
        }
        break;
      case 'Tuesday':
        {
          hari = "Selasa";
        }
        break;
      case 'Wednesday':
        {
          hari = "Rabu";
        }
        break;
      case 'Thursday':
        {
          hari = "Kamis";
        }
        break;
      case 'Friday':
        {
          hari = "Jumat";
        }
        break;
      case 'Saturday':
        {
          hari = "Sabtu";
        }
        break;
    }
    return '$hari, $formattedDate';
  }

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(children: [
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Center(
            child: Text(
              "Videotron ${transactionDataModel.width} x ${transactionDataModel.height} m",
              style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          height: 80,
          decoration: BoxDecoration(
            color: yellowColor,
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/icon-history.png',
                height: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${transactionDataModel.code}",
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    "${convertDate(transactionDataModel.bookingDate)} | ${transactionDataModel.startTime}",
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "${transactionDataModel.address}",
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
