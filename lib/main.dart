import 'package:day12_login/Screens/choose.dart';
import 'package:day12_login/Screens/registerPage.dart';
import 'package:flutter/material.dart';
import 'Screens/home.dart';
import 'Screens/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Choose(),
      routes: {
        "/choose": (_) => Choose(),
        "/register": (_) => RegisterPage(),
        "/login": (_) => LoginPage(),
        "/home": (_) => Home(),
      },
    );
  }
}