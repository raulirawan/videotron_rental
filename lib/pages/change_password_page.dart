import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotron_rental/providers/auth_provider.dart';
import 'package:videotron_rental/theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    TextEditingController oldPasswordController =
        TextEditingController(text: "");
    TextEditingController newPasswordController =
        TextEditingController(text: "");
    TextEditingController newPasswordConfirmationController =
        TextEditingController(text: "");

    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          color: primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                'assets/image-profile-circle.png',
                width: 150,
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                "${authProvider.user.name}",
                style: whiteTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${authProvider.user.phone}",
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: whiteColor),
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                child: TextField(
                  style: whiteTextStyle,
                  obscureText: true,
                  controller: oldPasswordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password Lama",
                    hintStyle: whiteTextStyle,
                    fillColor: Colors.red,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: whiteColor),
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                child: TextField(
                  controller: newPasswordController,
                  style: whiteTextStyle,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password Baru",
                    hintStyle: whiteTextStyle,
                    fillColor: Colors.red,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: whiteColor),
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                child: TextField(
                  controller: newPasswordConfirmationController,
                  style: whiteTextStyle,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Konfirmasi Password Baru",
                    hintStyle: whiteTextStyle,
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
                    String oldPassword = oldPasswordController.text;
                    String newPassword = newPasswordController.text;
                    String newPasswordConfirmation =
                        newPasswordConfirmationController.text;

                    if (oldPassword.isEmpty ||
                        newPassword.isEmpty ||
                        newPasswordConfirmation.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(
                            milliseconds: 1000,
                          ),
                          backgroundColor: alertColor,
                          content: const Text(
                            "Data Belum Lengkap",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      if (await authProvider.updatePassword(
                          oldPassword: oldPassword,
                          newPassword: newPassword,
                          newPasswordConfirmation: newPasswordConfirmation,
                          token: authProvider.user.token)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(
                              milliseconds: 1000,
                            ),
                            backgroundColor: successColor,
                            content: const Text(
                              "Berhasil Update Password!",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(
                              milliseconds: 1000,
                            ),
                            backgroundColor: alertColor,
                            content: const Text(
                              "Gagal Update Password, Coba Lagi!",
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
                    backgroundColor: yellowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: (isLoading)
                      ? CircularProgressIndicator(
                          color: whiteColor,
                        )
                      : Text(
                          "Ubah Password",
                          style: blackTextStyle.copyWith(fontWeight: semiBold),
                        ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
