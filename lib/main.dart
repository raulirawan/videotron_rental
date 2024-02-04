import 'package:flutter/material.dart';
import 'package:videotron_rental/pages/index_page.dart';
import 'package:videotron_rental/pages/login_page.dart';
import 'package:videotron_rental/pages/main_page.dart';
import 'package:videotron_rental/pages/register_page.dart';
import 'package:videotron_rental/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/main-page': (context) => const MainPage(),
      },
    );
  }
}
