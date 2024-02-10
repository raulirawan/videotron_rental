import 'package:flutter/material.dart';
import 'package:videotron_rental/theme.dart';

class FormCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isSubtitle;
  final bool? isButton;
  final Function() onTap;

  const FormCard(
      {super.key,
      required this.title,
      this.subtitle,
      required this.isSubtitle,
      this.isButton,
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
            (isSubtitle != true)
                ? SizedBox(
                  width: 220,
                  child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: subtitleTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: bold,
                      ),
                    ),
                )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 220,
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: subtitleTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
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
            (isButton == true)
                ? GestureDetector(
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
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
