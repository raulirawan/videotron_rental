import 'package:flutter/material.dart';
import 'package:videotron_rental/theme.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String icon;
  final bool isButton;

  const ProfileTile(
      {super.key,
      required this.title,
      required this.icon,
      this.isButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      height: 55,
      padding: const EdgeInsets.only(
        left: 10,
        top: 14,
        bottom: 14,
        right: 14,
      ),
      decoration: BoxDecoration(
          color: const Color(0xff28293F),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                icon,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                ),
              )
            ],
          ),
          (isButton
              ? Image.asset(
                  'assets/arrow-left.png',
                  height: 24,
                )
              : const SizedBox())
        ],
      ),
    );
  }
}
