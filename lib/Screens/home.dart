import 'package:day12_login/Animation/FadeAnimation.dart';
//import 'package:day12_login/Models/user.dart';
import 'package:day12_login/Screens/loginPage.dart';
import 'package:day12_login/Screens/registerPage.dart';
import 'package:day12_login/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day12_login/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:day12_login/main.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // DocumentReference uidCollection;
  // Database database = new Database(uid: 'NCPMKhL7AmNCJwYxzvs7sThy9d72');

  @override
  Widget build(BuildContext context) {

    bool science, math, language, writing, reading;

    User user = Provider.of<User>(context);
    final userData = Provider.of<UserData>(context) ?? [];
    //bool value = userData.science;
    // DocumentReference uidCollection = Firestore.instance.collection('active').document('NCPMKhL7AmNCJwYxzvs7sThy9d72');
    // Stream<DocumentSnapshot> data = Firestore.instance.collection('active').document('NCPMKhL7AmNCJwYxzvs7sThy9d72').snapshots();

    
    //Stream<UserData> userData = database.userData;

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Text(user.uid),
              
              Text(userData.toString()),
              //Text(user.uid),

            ],
          ),
        ),
      ),
    );
  }
}