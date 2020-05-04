import 'dart:async';
import 'dart:io';

import 'package:day12_login/Models/user.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:day12_login/Communication/Video_Chat/call.dart';

// grab message content from firebase then display if it is a message or not

// import 'package:firebase_auth/firebase_auth.dart';

class MessageHandle extends StatefulWidget {

  String uid;
  bool displayMessage;

  MessageHandle(this.uid, this.displayMessage);

  @override
  _MessageHandleState createState() => _MessageHandleState(uid, displayMessage);
}

class _MessageHandleState extends State<MessageHandle> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Person user;

  StreamSubscription iosSubscription;

  String uid;
  bool displayMessage;

  _MessageHandleState(this.uid, this.displayMessage);
  
  @override
  Future<void> initState()   {
    super.initState();
    
    

      if (Platform.isIOS) {
        iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
          print(data);
          _saveDeviceToken();
        });

        _fcm.requestNotificationPermissions(IosNotificationSettings());
      } else {
        _saveDeviceToken();
      }

      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          // final snackbar = SnackBar(
          //   content: Text(message['notification']['title']),
          //   action: SnackBarAction(
          //     label: 'Go',
          //     onPressed: () => null,
          //   ),
          // );

          var type = message['data']['type'].toString();


          // return showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(
          //         content: ListTile(
          //           title: Text(message['notification']['title']),
          //           subtitle: Text(message['notification']['body']),
          //         ),
          //         actions: <Widget>[
          //           FlatButton(
          //             color: Colors.blue,
          //             child: Text('Join'),
          //             onPressed: () => Navigator.pushReplacement(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (context) => CallPage(
          //                                     channelName: user.uid,
          //                                   )))
          //           ),
          //         ],
          //       ),
          // );

          // Scaffold.of(context).showSnackBar(snackbar);

          if(type == "Message" && displayMessage != true) {
            return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: ListTile(
                    title: Text(message['notification']['title']),
                    subtitle: Text(message['notification']['body']),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      color: Colors.blue,
                      child: Text('Dismiss'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
          );
          } 
          if(type == "Call") {
            return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: ListTile(
                    title: Text(message['notification']['title']),
                    subtitle: Text(message['notification']['body']),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      color: Colors.blue,
                      child: Text('Join'),
                      onPressed: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CallPage(
                                              channelName: uid.toString(),
                                            )))
                    ),
                  ],
                ),
          );
          } 
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          // TODO optional
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          // TODO optional
        },
      );
  }

  @override
  void dispose() {
    if (iosSubscription != null) iosSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _handleMessages(context);
    
    return Container(
    );
  }

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    // Get the current user
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken().then((value) {
      // var tokens = _db
      //     .collection('messages')
      //     .document(uid)
      //     .collection('tokens')
      //     .document(value);

      var tokens =
        _db.document('messages/${uid}/tokens/${value}');

      tokens.setData({
        'token': value,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }) ;

    // Save it to Firestore
  }

  /// Subscribe the user to a topic
  _subscribeToTopic() async {
    // Subscribe the user to a topic
    _fcm.subscribeToTopic('puppies');
  }
}