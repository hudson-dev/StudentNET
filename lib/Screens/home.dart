import 'dart:async';

import 'package:day12_login/Communication/Video_Chat/calling.dart';
import 'package:day12_login/Communication/Messaging/chat.dart';
import 'package:day12_login/Communication/Messaging/texting.dart';
import 'package:day12_login/Models/user.dart';
import 'package:day12_login/Notifications/messageHandler.dart';
import 'package:day12_login/Notifications/messaging_widget.dart';
import 'package:day12_login/Screens/choose.dart';
import 'package:day12_login/services/auth.dart';
import 'package:day12_login/services/database.dart';
import 'package:day12_login/services/routing.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:day12_login/Communication/Video_Chat/call.dart';
import 'package:day12_login/Notifications/videoHandler.dart';

void main() => runApp(Home());
/// This Widget is the main application widget.
class Home extends StatefulWidget {
 static const String _title = 'Flutter Code Sample';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool show = true;

  @override
  void initState() {
    super.initState();


  }

  // Widget _initializeTimer() {
  //   _timer = Timer.periodic(const Duration(seconds: 7), (_) => setState(() {
  //   show = false;
  //   return Container();
  //   }));
  // }

 @override
 Widget build(BuildContext context) {
   Person user = Provider.of<Person>(context);
   bool math, science, writing, language, reading;
   UserData userData;
   String name, photoUrl;
   FirebaseMessaging fcm = new FirebaseMessaging();
   var token = fcm.getToken();
   

   if(user.uid == null) {CircularProgressIndicator();} else {
  
   return StreamBuilder<UserData>(
     stream: Database(uid: user.uid).userData,
       builder: (context, snapshot) {
       // var userSnapshot = Provider.of<UserData>(context);
         if (snapshot.hasData) {
          userData = snapshot.data;
          math = userData.math;
          science = userData.science;
          writing = userData.writing;
          language = userData.language;
          reading = userData.reading;
          name = userData.name;
          photoUrl = userData.photoUrl;
          
          return MaterialApp(
     title: Home._title,
     home: Scaffold(
       body: Container(
         color: Colors.grey[200],
         child: SafeArea(
           child: Column(
             children: <Widget>[
              SizedBox(
                height: 50,
                child: MessageHandle(user.uid, false),
              ), 
              Row(
                 children: <Widget>[
                   
                   Align(
                     alignment: Alignment.topLeft,
                     child: IconButton(
                       icon: Icon(Icons.arrow_back),
                       color: Colors.black,
                       onPressed: () async{
                         AuthService auth = new AuthService();
                         await auth.signOut();
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Choose()));
                     }
                     ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 65),
                   child: Text(
                     "Welcome ${name}",
                     style: TextStyle(fontSize: 30)
                       ),
                 ),
                   ],
                 ),
            
               RaisedButton(
                 color: Colors.white,
                 elevation: 100,
                 onPressed: () {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Texting(currentUserId: user.uid,)));
                 },
                 child: Text("Let's chat!"),
               ),
               RaisedButton(
                 color: Colors.white,
                 elevation: 100,
                 onPressed: () {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CallPage(channelName: user.uid,)));
                 },
                 child: Text("Let's call!")
               ),
               RaisedButton(
                 color: Colors.white,
                 elevation: 100,
                 onPressed: () {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Routing()));
                 },
                 child: Text("Let's connect!")
               ),
               RaisedButton(
                 color: Colors.white,
                 elevation: 100,
                 onPressed: () {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Texting(currentUserId: user.uid,)));
                 },
                 child: Text("Past Chats")
               ),
               Center(
                 child: Text(
                   "UID: ${user.uid}",
                   style: TextStyle(fontSize: 30)
                   ),
               ),
             ]
             ),
         ),
       ),
       ),
     );
   } else {
     return CircularProgressIndicator();
   }
 }); 
   }
 }
}
 
 

