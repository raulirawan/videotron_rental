// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotron_rental/pages/main_page.dart';
import 'package:videotron_rental/providers/auth_provider.dart';
import 'package:videotron_rental/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: blackColor),
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Masukan Email",
                    hintStyle: primaryTextStyle,
                    fillColor: Colors.red,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: blackColor),
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Masukan Password",
                    hintStyle: primaryTextStyle,
                    fillColor: Colors.red,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (isLoading) {
                      return;
                    }
                    String email = emailController.text;
                    String password = passwordController.text;

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(
                            milliseconds: 1000,
                          ),
                          backgroundColor: alertColor,
                          content: const Text(
                            "Silahkan Isi Email & Password",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      if (await authProvider.login(
                        email: emailController.text,
                        password: passwordController.text,
                      )) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MainPage(selectedIndex: 0)),
                            (route) => false);
                      } else {
                         ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(
                            milliseconds: 1000,
                          ),
                          backgroundColor: alertColor,
                          content: const Text(
                            "Username & Password Salah",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: (isLoading)
                      ? CircularProgressIndicator(
                          color: whiteColor,
                        )
                      : Text(
                          "Login",
                          style: whiteTextStyle.copyWith(fontWeight: semiBold),
                        ),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/register', (route) => false);
                },
                child: Center(
                  child: Text(
                    "Belum punya akun? daftar disini",
                    style: subtitleTextStyle,
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
