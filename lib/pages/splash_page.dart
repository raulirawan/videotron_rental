import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotron_rental/pages/login_page.dart';
import 'package:videotron_rental/providers/videotron_provider.dart';
import 'package:http/http.dart' as http;
import 'package:videotron_rental/theme.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    getInitPrice();
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

  getInitPrice() async {
      final response = await http.get(Uri.parse('https://karindo.jasproweb.com/api/setting'));
    
      if (response.statusCode == 200) {
        // Data fetched successfully
        final jsonData = jsonDecode(response.body);

        price = jsonData['data']['price_meter'] ?? 100000;
        // Parse jsonData into Dart objects
        // Example: List<dynamic> dataList = jsonData['data'];
      } else {
        // Handle errors
        print('Failed to fetch data: ${response.statusCode}');
      }
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
