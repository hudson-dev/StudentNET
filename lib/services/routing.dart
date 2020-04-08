import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day12_login/Communication/Video_Chat/calling.dart';
import 'package:day12_login/Communication/Messaging/chat.dart';
import 'package:day12_login/Communication/Messaging/texting.dart';
import 'package:day12_login/Models/user.dart';
import 'package:day12_login/Screens/choose.dart';
import 'package:day12_login/Screens/grade.dart';
import 'package:day12_login/Screens/home.dart';
import 'package:day12_login/services/auth.dart';
import 'package:day12_login/services/database.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() => runApp(Routing());
/// This Widget is the main application widget.
class Routing extends StatefulWidget {

  String uid;
  String topic;

  Routing({Key key, @required this.uid, @required this.topic}) : super(key: key);

 static const String _title = 'Flutter Code Sample';
  @override
  _RoutingState createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
  
 final Firestore db = Firestore.instance;

 bool math, science, writing, language, reading;
  UserData userData;
  String name, photoUrl;
  int grade;
  bool buttonColor = false;
  bool pressAttention0 = false;
  bool pressAttention1 = false;
  bool pressAttention2 = false;
  bool pressAttention3 = false;
  bool pressAttention4 = false;
  Color active = Colors.yellow;
  Color inActive = Colors.yellow[200];
  String topic;
  var connectID;
  var test;

  




 @override
 Widget build(BuildContext context) {

   Person person = Provider.of<Person>(context); 
   
   StreamBuilder<UserData>(
     stream: Database(uid: person.uid).userData,
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
          grade = userData.grade;
          photoUrl = userData.photoUrl;
          
   }
 }); 
 


    return MaterialApp(
      
      title: Routing._title,
            home: Scaffold(
              body: Container(
                color: Colors.grey[200],
                child: Stack(
                  children: <Widget>[
                     Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "What Do You Need Help With?",
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
                              setState(() => pressAttention0 = !pressAttention0);
                              topic = "math";
                              getHelp(topic, grade)
                              .then((QuerySnapshot docs) {
                                if(docs.documents.isNotEmpty) {
                                  connectID = docs.documents[0].documentID;
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Chat(peerId: connectID, peerAvatar: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFile%3ACircle-icons-profile.svg&psig=AOvVaw2UrpVRemI5oO7yRxwcjvpV&ust=1585635848126000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODIy_7HwegCFQAAAAAdAAAAABAQ')));;
                                } else {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                                  setState(() => pressAttention2 = !pressAttention0);
                                }
                              });

                            }
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: FlatButton(
                            child: Text('Science'),
                            color: pressAttention1 ? active : inActive,

                            onPressed: () { 
                              setState(() => pressAttention1 = !pressAttention1);
                              topic = "science";
                              getHelp(topic, grade)
                             .then((QuerySnapshot docs) {
                                if(docs.documents.isNotEmpty) {
                                  connectID = docs.documents[0].documentID;
                                  setState(() => pressAttention2 = !pressAttention1);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Chat(peerId: connectID, peerAvatar: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFile%3ACircle-icons-profile.svg&psig=AOvVaw2UrpVRemI5oO7yRxwcjvpV&ust=1585635848126000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODIy_7HwegCFQAAAAAdAAAAABAQ')));
                                } else {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                                  setState(() => pressAttention2 = !pressAttention1);
                                }
                              });
                            }
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: FlatButton(
                            child: Text('Writing'),
                            color: pressAttention2 ? active : inActive,

                            onPressed: () { 

                              setState(() => pressAttention2 = !pressAttention2);
                              topic = "writing";
                              getHelp(topic, grade)
                              .then((QuerySnapshot docs) {
                                if(docs.documents.isNotEmpty) {
                                  connectID = docs.documents[0].documentID;
                                  setState(() => pressAttention2 = !pressAttention1);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Chat(peerId: connectID, peerAvatar: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFile%3ACircle-icons-profile.svg&psig=AOvVaw2UrpVRemI5oO7yRxwcjvpV&ust=1585635848126000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODIy_7HwegCFQAAAAAdAAAAABAQ')));
                                } else {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                                  setState(() => pressAttention2 = !pressAttention1);
                                }
                              });
                            }
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: FlatButton(
                            child: Text('Language'),
                            color: pressAttention3 ? active: inActive,

                            onPressed: () { 
                              setState(() => pressAttention3 = !pressAttention3);
                              topic = "language";
                             getHelp(topic, grade)
                              .then((QuerySnapshot docs) {
                                if(docs.documents.isNotEmpty) {
                                  connectID = docs.documents[0].documentID;
                                  setState(() => pressAttention3 = !pressAttention3);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Chat(peerId: connectID, peerAvatar: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFile%3ACircle-icons-profile.svg&psig=AOvVaw2UrpVRemI5oO7yRxwcjvpV&ust=1585635848126000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODIy_7HwegCFQAAAAAdAAAAABAQ')));
                                } else {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                                  setState(() => pressAttention3 = !pressAttention3);
                                }
                              });
                            }
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: FlatButton(
                            child: Text('Reading'),
                            color: pressAttention4 ? active : inActive,

                            onPressed: () { 
                              setState(() => pressAttention4 = !pressAttention4);
                              topic = "reading";
                              getHelp(topic, grade)
                              .then((QuerySnapshot docs) {
                                if(docs.documents.isNotEmpty) {
                                  connectID = docs.documents[0].documentID;
                                  setState(() => pressAttention4 = !pressAttention4);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Chat(peerId: connectID, peerAvatar: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFile%3ACircle-icons-profile.svg&psig=AOvVaw2UrpVRemI5oO7yRxwcjvpV&ust=1585635848126000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODIy_7HwegCFQAAAAAdAAAAABAQ')));

                                } else {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                                  setState(() => pressAttention4 = !pressAttention4);
                                }
                              });
                            }
                          ),
                        ),
                        SizedBox(height: 0.2),


                        ],
                      ),
                  ],
                )
              ),
              ),
            );
          }

    getHelp(String topic, int grade) {
      return db
        .collection('active')
        .where(topic, isEqualTo: true)
        .where('grade', isEqualTo: grade)
        .getDocuments();
    }
  }

    
  
