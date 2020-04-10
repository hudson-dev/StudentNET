import 'dart:core';
import 'dart:io';
import 'package:day12_login/Animation/FadeAnimation.dart';
import 'package:day12_login/Screens/grade.dart';
//import 'package:day12_login/Models/user.dart';
import 'package:day12_login/Screens/loginPage.dart';
import 'package:day12_login/Screens/registerPage.dart';
import 'package:day12_login/services/database.dart';
import 'package:day12_login/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day12_login/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:day12_login/main.dart';
class Quiz extends StatefulWidget {
 @override
 _QuizState createState() => _QuizState();
}
class _QuizState extends State<Quiz> {
 bool math, science, writing, language, reading;
 String name;
 bool buttonColor = false;
 bool pressAttention0 = false;
 bool pressAttention1 = false;
 bool pressAttention2 = false;
 bool pressAttention3 = false;
 bool pressAttention4 = false;
 UserData userData;
 
 Color active = Colors.yellow;
 Color inActive = Colors.yellow[200];
 // void changeColor(){
 //   setState(() {
 //     tapped1 = !tapped1;
    
 //   });
 // }
 
 @override
 Widget build(BuildContext context) {
 
   Person user = Provider.of<Person>(context);
   List<String> topics = ["Math", "Science", "Writing", "Language", "Reading"];
  
   sleep(const Duration(milliseconds: 200));

   if(user.uid == null) {
    return CircularProgressIndicator();
   } else {
   return StreamBuilder<UserData>(
     stream: Database(uid: user.uid).userData,
       builder: (context, snapshot) {
 
         if (snapshot.hasData) {
          userData = snapshot.data;
           math = userData.math;
           science = userData.science;
           writing = userData.writing;
           language = userData.language;
           reading = userData.reading;
           name = userData.name;
          
           return MaterialApp(
             home: Scaffold(
               body: SafeArea(
                 child: Stack(
                 children: <Widget>[
                  
                   Align(
                     alignment: Alignment.topCenter,
                     child: Text(
                       "What Are You Good At?",
                       style: TextStyle(fontSize: 64, color: Colors.black),
                      
                     ),
                   ),
                   GridView.count(
                     physics: ScrollPhysics(),
                     primary: false,
                     padding: const EdgeInsets.all(10),
                     crossAxisSpacing: 10,
                     mainAxisSpacing: 10,
                     crossAxisCount: 2,
                     children: <Widget>[
                       SizedBox(height: 0.2),
                       SizedBox(height: 0.2),
                       Container(
                         padding: const EdgeInsets.all(8),
                         child: FlatButton(
                           child: Text('Math'),
                           color: pressAttention0 ? active : inActive,
                          
                           onPressed: () {
                             math = !math;
                             setState(() => pressAttention0 = !pressAttention0);
                             print(pressAttention0);
                           }
                         ),
                       ),
                       Container(
                         padding: const EdgeInsets.all(8),
                         child: FlatButton(
                           child: Text('Science'),
                           color: pressAttention1 ? active : inActive,
                          
                           onPressed: () {
                             science = !science;
                             setState(() => pressAttention1 = !pressAttention1);
                             print(pressAttention1);
                           }
                         ),
                       ),
                       Container(
                         padding: const EdgeInsets.all(8),
                         child: FlatButton(
                           child: Text('Writing'),
                           color: pressAttention2 ? active : inActive,
                          
                           onPressed: () {
                             writing = !writing;
                             setState(() => pressAttention2 = !pressAttention2);
                             print(pressAttention2);
                           }
                         ),
                       ),
                       Container(
                         padding: const EdgeInsets.all(8),
                         child: FlatButton(
                           child: Text('Language'),
                           color: pressAttention3 ? active: inActive,
                          
                           onPressed: () {
                             language = !language;
                             setState(() => pressAttention3 = !pressAttention3);
                             print(pressAttention3);
                           }
                         ),
                       ),
                       Container(
                         padding: const EdgeInsets.all(8),
                         child: FlatButton(
                           child: Text('Reading'),
                           color: pressAttention4 ? active : inActive,
                          
                           onPressed: () {
                             reading = !reading;
                             setState(() => pressAttention4 = !pressAttention4);
                             print(pressAttention4);
                           }
                         ),
                       ),
                       SizedBox(height: 0.2),
                       
                      
                       ],
                     ),
                    
                       Align(
                           alignment: Alignment.bottomCenter,
                           child: SizedBox(
                             height: 10,
                         )
                       ),
                     Align(
                         alignment: Alignment.bottomCenter,
                         child: RaisedButton(
                           color: Colors.blue[100],
                           onPressed: () {
                             Database(uid: user.uid).updateUserData(pressAttention0, pressAttention1, pressAttention2, pressAttention3, pressAttention4, name, 0);
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Grade()));
                           },
                           child: Text("Next"),
                     )
                   ),
                 ]
               )
               )
             ),
           );
         }
         else {
           return Container(
             color: Colors.cyan[900],
             child: Center(
               child: SpinKitWave(
                 color: Colors.white,
                 size: 120
               ),
             ),
           );
         }
       });
   }
     }
}
