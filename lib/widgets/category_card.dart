import 'package:flutter/material.dart';
import 'package:videotron_rental/theme.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final bool active;

  const CategoryCard({
    super.key,
    required this.name,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 10),
      height: 35,
      decoration: BoxDecoration(
        color: (active == true ? yellowColor : greyColor),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        name,
        style: primaryTextStyle.copyWith(
          fontSize: 12,
          fontWeight: bold,
        ),
      ),
    );
  }
}
