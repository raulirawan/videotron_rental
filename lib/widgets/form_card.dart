import 'package:flutter/material.dart';
import 'package:videotron_rental/theme.dart';

class FormCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isSubtitle;
  final Function() onTap;

  const FormCard(
      {super.key,
      required this.title,
      this.subtitle,
      required this.isSubtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 15, bottom: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (isSubtitle != true) ? Text(
              title,
              style: subtitleTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: subtitleTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                Text(
                  subtitle.toString(),
                  style: subtitleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: yellowColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Ubah",
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
