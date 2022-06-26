import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:internsearch_mobile/screens/auth/login_page.dart';
import 'package:internsearch_mobile/screens/auth/register_page.dart';
import 'package:internsearch_mobile/screens/home/home.dart';
import 'package:internsearch_mobile/screens/main_page.dart';
import 'package:internsearch_mobile/services/shared_services.dart';

Widget _defaultHome = const LoginPage();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Rubik",
        primaryColor: Color.fromARGB(255, 229, 22, 7),
        backgroundColor: Color.fromARGB(255, 255, 249, 249),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.blue[300],
          background: Colors.grey[300],
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => MainPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage()
      },
    );
  }
}
