import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotron_rental/providers/auth_provider.dart';
import 'package:videotron_rental/theme.dart';

class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({super.key});

  @override
  State<ChangeProfilePage> createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    TextEditingController nameController =
        TextEditingController(text: authProvider.user.name);
    TextEditingController phoneController =
        TextEditingController(text: authProvider.user.phone);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
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
                  controller: nameController,
                  style: whiteTextStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: whiteTextStyle,
                    fillColor: Colors.red,
                    focusColor: whiteColor,
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
                  keyboardType: TextInputType.number,
                  style: whiteTextStyle,
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
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
                    String name = nameController.text;
                    String phone = phoneController.text;

                    if (name.isEmpty || phone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(
                            milliseconds: 1000,
                          ),
                          backgroundColor: alertColor,
                          content: const Text(
                            "Silahkan Isi Nama & Nomor Telepon",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      if (await authProvider.updateProfile(
                          name: nameController.text,
                          phone: phoneController.text,
                          token: authProvider.user.token)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(
                              milliseconds: 1000,
                            ),
                            backgroundColor: successColor,
                            content: const Text(
                              "Berhasil Update Profile!",
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
                              "Gagal Update Profile, Coba Lagi!",
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
                          "Ubah Profil",
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
