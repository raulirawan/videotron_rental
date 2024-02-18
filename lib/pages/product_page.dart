import 'package:flutter/material.dart';
import 'package:videotron_rental/models/videotron_model.dart';
import 'package:videotron_rental/theme.dart';

class ProductPage extends StatelessWidget {
  final VideotronModel? videotron;

  const ProductPage({super.key, this.videotron});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 304,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    videotron!.image.toString(),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  top: defaultMargin,
                  left: 16,
                ),
                child: Image.asset(
                  'assets/icon-back.png',
                  width: 24,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 280,
              ),
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: whiteColor,
              ),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        "${videotron?.name}",
                        style: primaryTextStyle.copyWith(
                            fontSize: 20, fontWeight: bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            "4.2",
                            style: primaryTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: bold,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "(40)",
                            style: primaryTextStyle.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${videotron?.description}",
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: bold,
                        ),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
