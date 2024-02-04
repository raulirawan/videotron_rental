// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:videotron_rental/pages/login_page.dart';
import 'package:videotron_rental/pages/register_page.dart';
import 'package:videotron_rental/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 100,
                  ),
                  child: const Image(
                    image: AssetImage('assets/image-welcome.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Text(
                "Welcome to Karindoled",
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Text(
                "Promosikan Iklan Anda bersama teman - teman\nkamu.",
                style: subtitleTextStyle.copyWith(fontWeight: light),
              ),
              const SizedBox(
                height: 20,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: whiteTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                ),
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greyColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Register",
                    style: primaryTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
