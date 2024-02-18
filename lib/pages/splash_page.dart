import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotron_rental/pages/login_page.dart';
import 'package:videotron_rental/providers/videotron_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    getInitCategory();
    getInitVideotron();
    init();
  }

  getInitVideotron() async {
    await Provider.of<VideotronProvider>(context, listen: false).getVideotron();
  }

  getInitCategory() async {
    await Provider.of<VideotronProvider>(context, listen: false).getCategory();
  }

  Future<void> init() async {
    // Fetch data from network or read from disk
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/bg-splash.png'),
          fit: BoxFit.cover,
        )),
        child: Center(
            child: Image.asset(
          'assets/image-splash.png',
          width: 252,
          height: 155,
        )),
      ),
    );
  }
}
