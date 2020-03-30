import 'package:day12_login/Screens/choose.dart';
import 'package:day12_login/Screens/grade.dart';
import 'package:day12_login/Screens/home.dart';
import 'package:day12_login/Screens/registerPage.dart';
import 'package:day12_login/services/auth.dart';
import 'package:day12_login/services/database.dart';
import 'package:day12_login/services/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/user.dart';
import 'Screens/quiz.dart';
import 'Screens/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ValueListenableProvider(builder: (_) => ValueNotifier(true)),
        StreamProvider<User>(create: (_) => AuthService().user),
        StreamProvider<Message>(create: (_) => Database().messageData),
        //StreamProvider<WantedId>(create: (_) => Database().call),
      ],
        child: MaterialApp(
        home: Choose(),
        routes: {
          "/choose": (_) => Choose(),
          "/register": (_) => RegisterPage(),
          "/login": (_) => LoginPage(),
          "/quiz": (_) => Quiz(),
          "/grade": (_) => Grade(),
          "/home": (_) => Home(),
        },
      ),
    );
  }
}