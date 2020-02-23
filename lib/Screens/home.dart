import 'package:day12_login/Animation/FadeAnimation.dart';
import 'package:day12_login/Screens/loginPage.dart';
import 'package:day12_login/Screens/registerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key key, @required this.user}) : super(key: key);
  final FirebaseUser user;


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text(user.name)
        // body: StreamBuilder<DocumentSnapshot> (
            
        //   )
        ),
      );
  }
}