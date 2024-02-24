import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videotron_rental/pages/login_page.dart';
import 'package:videotron_rental/pages/main_page.dart';
import 'package:videotron_rental/pages/register_page.dart';
import 'package:videotron_rental/pages/splash_page.dart';
import 'package:videotron_rental/providers/auth_provider.dart';
import 'package:videotron_rental/providers/transaction_provider.dart';
import 'package:videotron_rental/providers/videotron_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VideotronProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/main-page': (context) => const MainPage(
                selectedIndex: 0,
              ),
        },
      ),
    );
  }
}
