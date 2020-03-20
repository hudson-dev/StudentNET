import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day12_login/Animation/FadeAnimation.dart';
import 'package:day12_login/Screens/choose.dart';
import 'package:day12_login/Screens/home.dart';
import 'package:day12_login/Screens/quiz.dart';
import 'package:day12_login/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String incorrect = " ";
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;
  FirebaseUser currentUser;

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
	                          child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
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
	                          decoration: BoxDecoration(
	                            border: Border(bottom: BorderSide(color: Colors.grey[100]))
	                          ),
	                          child: TextFormField(
	                            validator: (input) {
	                              if(input.isEmpty) {
	                                return 'Please provide an email';
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
	                              if(input.isEmpty) {
	                                return 'Please provide a password';
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
	                        )
	                      ],
	                    ),
	                  )
	                    )),
	                SizedBox(height: 10),
	                FadeAnimation(1.5, Text(incorrect, style: TextStyle(color: Colors.red),)),
	                  
	                    FadeAnimation(2, 
	                    SizedBox(
	                  height: 50,
	                  child: FlatButton(
	                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
	                  
	                  onPressed: () async {
	                    signIn();
	                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
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
	                        child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
	                    )
	                  ),
	                        ),
	                    ),
	                    ),
                      SizedBox(height: 10),
                      FadeAnimation(2, 
	                    SizedBox(
	                  height: 50,
	                  child: FlatButton(
	                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
	                  
	                  onPressed: () async {
	                    signInWithGoogle();
	                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
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
	                        child: Text("Login with Google", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
	                    )
	                  ),
	                        ),
	                    ),
	                    ),
	                SizedBox(height: 30,),
	                    FadeAnimation(1.5, Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
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
  Future<bool> signIn() async{
    
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try {
        AuthService auth = new AuthService();
        dynamic user = await auth.signInWithEmailAndPassword( _email, _password);
        if(user == null) {
          incorrect = "Incorrect Email or Password!";
          setState(() {
            
          });
        } 
      }catch(e) {
        print('*************ERROR MESSAGE*************');
        print(e);
        return false;
      }
    }
    return false;
  } 

  Future<Null> signInWithGoogle() async {
    prefs = await SharedPreferences.getInstance();

   

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result =
          await Firestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance.collection('users').document(firebaseUser.uid).setData({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoUrl,
          'id': firebaseUser.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null
        });

        // Write data to local
        currentUser = firebaseUser;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('nickname', currentUser.displayName);
        await prefs.setString('photoUrl', currentUser.photoUrl);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('nickname', documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        await prefs.setString('aboutMe', documents[0]['aboutMe']);
      }
      Fluttertoast.showToast(msg: "Sign in success");
      

      Navigator.push(context, MaterialPageRoute(builder: (context) => Quiz()));
    } else {
      Fluttertoast.showToast(msg: "Sign in fail");
      
    }
  }

  
}

  
   