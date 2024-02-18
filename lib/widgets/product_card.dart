import 'package:flutter/material.dart';
import 'package:videotron_rental/models/videotron_model.dart';
import 'package:videotron_rental/theme.dart';

class ProductCard extends StatelessWidget {
  final VideotronModel? videotron;

  const ProductCard({super.key, this.videotron});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 250,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  videotron!.image.toString(),
                  height: 150,
                ),
                const SizedBox(
                  height: 11,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${videotron?.name}",
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(
                  "4.2 (40)",
                  style:
                      primaryTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
