import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day12_login/Animation/FadeAnimation.dart';
import 'package:day12_login/Models/user.dart';
import 'package:day12_login/Screens/choose.dart';
import 'package:day12_login/Screens/loginPage.dart';
import 'package:day12_login/services/auth.dart';
import 'package:day12_login/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'quiz.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  String _email, _password, _name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      	child: SafeArea(
          child: Container(
	        child: Column(
	          children: <Widget>[
	            Container(
	              height: 400,
	              decoration: BoxDecoration(
	                image: DecorationImage(
	                  image: AssetImage('assets/images/background.png'),
	                  fit: BoxFit.fill
	                )
	              ),
	              child: Stack(
	                children: <Widget>[
	                  Positioned(
	                    left: 30,
	                    width: 80,
	                    height: 200,
	                    child: FadeAnimation(1, Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/light-1.png')
	                        )
	                      ),
	                    )),
	                  ),
	                  Positioned(
	                    left: 140,
	                    width: 80,
	                    height: 150,
	                    child: FadeAnimation(1.3, Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/light-2.png')
	                        )
	                      ),
	                    )),
	                  ),
	                  Positioned(
	                    right: 40,
	                    top: 40,
	                    width: 80,
	                    height: 150,
	                    child: FadeAnimation(1.5, Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/clock.png')
	                        )
	                      ),
	                    )),
	                  ),
	                  Positioned(
	                    child: FadeAnimation(1.6, Container(
	                      margin: EdgeInsets.only(top: 50),
	                      child: Center(
	                        child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
	                      ),
	                    )),
	                  ),
                    Positioned(
                      right: 350,
                      top: 30,
                        child: FadeAnimation( 
                          1.2,
                            IconButton(
                            icon: Icon(Icons.arrow_back),
                            color: Colors.black,
                            onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Choose()));
                          }
                      ),
                        ),
                    ),
	                ],
	              ),
	            ),
	            Padding(
	              padding: EdgeInsets.all(30.0),
	              child: Column(
	                children: <Widget>[
	                  FadeAnimation(1.8, Container(
	                    padding: EdgeInsets.all(5),
	                    decoration: BoxDecoration(
	                      color: Colors.white,
	                      borderRadius: BorderRadius.circular(10),
	                      boxShadow: [
	                        BoxShadow(
	                          color: Color.fromRGBO(143, 148, 251, .2),
	                          blurRadius: 20.0,
	                          offset: Offset(0, 10)
	                        )
	                      ]
	                    ),
	                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (input) {
                                  if(input.length < 0) {
                                    return 'Plese provide your name.';
                                  }
                                },
                                onSaved: (input) {
                                  _name = input;
                                }, 
                                obscureText: false,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Name",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextFormField(
                                validator: (input) {
                                  if(input.isEmpty) {
                                    return 'Plese provide an email';
                                  }
                                },
                                onSaved: (input) {
                                  _email = input;
                                }, 
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (input) {
                                  if(input.length < 6) {
                                    return 'Plese provide a password with more than 6 values';
                                  }
                                },
                                onSaved: (input) {
                                  _password = input;
                                }, 
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      )
	                  )),
	                  SizedBox(height: 40,),
	                  FadeAnimation(2, 
	                  SizedBox(
                      height: 50,
                      child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                      
                      onPressed: () async {
                        signUp();
                      },
                      

                      child: Ink(
                        decoration: const BoxDecoration(
                        gradient: LinearGradient(
                        colors: <Color>[Color.fromRGBO(143, 148, 251, 1),
	                          Color.fromRGBO(143, 148, 251, .6),],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      ),
                          child: Center(
                            child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        )
                      ),
	                      ),
	                  ),
	                  ),
	                  SizedBox(height: 40,),
	                  //FadeAnimation(1.5, Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
	                ],
	              ),
	            )
	          ],
	        ),
	      ),
      	),
      )
    );
    
  }
  Future<bool> signUp() async{
    
    final formState = _formKey.currentState;
    User user = Provider.of<User>(context);
    bool math, science, writing, language, reading;
    UserData userData;
    String name, photoUrl;

    if(formState.validate()) {
      formState.save();
      try {
        
      
      StreamBuilder<UserData>(
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
            photoUrl = userData.photoUrl;
 
            AuthService auth = new AuthService();
            dynamic user1 = auth.registerWithEmailAndPassword( _email, _password, _name);
            final QuerySnapshot result =
              getDocuments(user.uid) as QuerySnapshot;
            final List <DocumentSnapshot> documents = result.documents;
            Firestore.instance.collection('users').document(user.uid).setData(
                { 'nickname': name, 'photoUrl': photoUrl, 'id': user.uid });
            // if(user1 == null) {
            //   return false;   
            // } 
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Quiz()));
            
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
      
      
      }catch(e) {
        print('*************ERROR MESSAGE*************');
        print(e);
        return false;
      }
    }
    return false;
  } 
}

Future<QuerySnapshot> getDocuments(String uid) async {
  final QuerySnapshot result =
    await Firestore.instance.collection('users').where('id', isEqualTo: uid).getDocuments();
  return result;
}
      
