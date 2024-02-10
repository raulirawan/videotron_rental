import 'package:flutter/material.dart';
import 'package:videotron_rental/pages/history_page.dart';
import 'package:videotron_rental/theme.dart';
import 'package:videotron_rental/widgets/profile_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              "Alfan",
              style: whiteTextStyle.copyWith(
                fontSize: 24,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "083812345678",
              style: whiteTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const ProfileTile(
              title: "Ubah Profil",
              icon: 'assets/icon-profile.png',
            ),
            const ProfileTile(
              title: "Ganti Password",
              icon: 'assets/icon-lock.png',
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HistoryPage()));
              },
              child: const ProfileTile(
                title: "Riwayat Penyewaan",
                icon: 'assets/icon-calendar.png',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const ProfileTile(
              title: "Keluar",
              icon: 'assets/icon-exit.png',
              isButton: false,
            ),
          ],
        ),
      )),
    );
  }
}
