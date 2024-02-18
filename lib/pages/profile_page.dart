import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotron_rental/pages/change_password_page.dart';
import 'package:videotron_rental/pages/change_profile_page.dart';
import 'package:videotron_rental/pages/history_page.dart';
import 'package:videotron_rental/pages/login_page.dart';
import 'package:videotron_rental/providers/auth_provider.dart';
import 'package:videotron_rental/theme.dart';
import 'package:videotron_rental/widgets/profile_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
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
              authProvider.user.name.toString(),
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangeProfilePage()));
              },
              child: const ProfileTile(
                title: "Ubah Profil",
                icon: 'assets/icon-profile.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordPage()));
              },
              child: const ProfileTile(
                title: "Ganti Password",
                icon: 'assets/icon-lock.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoryPage()));
              },
              child: const ProfileTile(
                title: "Riwayat Penyewaan",
                icon: 'assets/icon-calendar.png',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                if (await authProvider.logout(token: authProvider.user.token)) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(
                        milliseconds: 1000,
                      ),
                      backgroundColor: alertColor,
                      content: const Text(
                        "Gagal Logout, Coba Lagi!",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              child: const ProfileTile(
                title: "Keluar",
                icon: 'assets/icon-exit.png',
                isButton: false,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
