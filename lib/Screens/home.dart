import 'package:day12_login/Communication/chat.dart';
import 'package:day12_login/Models/user.dart';
import 'package:day12_login/Screens/choose.dart';
import 'package:day12_login/Screens/grade.dart';
import 'package:day12_login/services/auth.dart';
import 'package:day12_login/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(Home());

/// This Widget is the main application widget.
class Home extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    bool math, science, writing, language, reading;
    UserData userData;
    String name;

    
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
 
            
           return MaterialApp(
      title: _title,
      home: Scaffold(
        
        body: Container(
          color: Colors.grey[200],
          child: SafeArea(
            child: Column(
              children: <Widget>[
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
              
                FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Chat()));
                  },
                  child: Text("Let's chat!")
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
    }
  });  
  }
}

