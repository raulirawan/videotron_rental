import 'package:flutter/material.dart';
import 'package:videotron_rental/theme.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
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
              "Videotron 10x10 m",
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
                    "COR.INV.09879",
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    "Sabtu, 3 Januari 2023 | 18.00",
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Gedung Pemkot Bekasi, Jl. Utara Raya.....",
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
