import 'package:day12_login/Models/message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessagingWidget extends StatefulWidget {

  bool show;

  MessagingWidget(this.show);

  @override
  _MessagingWidgetState createState() => _MessagingWidgetState(show);

}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<Message> _messages = [];

  bool show;

  _MessagingWidgetState(this.show);


  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("Device Token: $deviceToken");
    });
  }

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _setMessage(message);
        show = true;
        // final notification = message['notification'];
        // setState(() {
        //   _messages.add(Message(
        //       title: notification['title'], body: notification['body']));
        // });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _setMessage(message);
        show = true;

        // final notification = message['data'];
        // setState(() {
        //   _messages.add(Message(
        //     title: '${notification['title']}',
        //     body: '${notification['body']}',
        //   ));
        // });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _setMessage(message);
        show = true;
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

   
_setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['message'];
    print("Title: $title, body: $body, message: $mMessage");
    setState(() {
      Message msg = Message(title: title, body: body, message: mMessage);
      _messages.add(msg);
    });
}

  @override
  void initState() {
    super.initState();
    _messages = List<Message>();
    _getToken();
    _configureFirebaseListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: ListView.builder(
        itemCount: null == _messages ? 0 : _messages.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                _messages[index].message,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                )
              )
            )
          );
        }
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) => ListView(
  //   children: messages.map(buildMessage).toList(),
  // );

  Widget buildMessage(Message message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );

  get getShow {
    return show;
  }
}

