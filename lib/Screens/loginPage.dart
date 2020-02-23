//import 'dart:js';

import 'package:day12_login/Animation/FadeAnimation.dart';
import 'package:day12_login/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                      right: 360,
                      top: 40,
                        child: FadeAnimation( 
                          1.2,
                            IconButton(
                            icon: Icon(Icons.arrow_back),
                            color: Colors.black,
                            onPressed: () {
                            Navigator.pushReplacementNamed(context, "/choose");
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
                            )
                          ],
                        ),
                      )
	                  )),
	                  SizedBox(height: 60,),
	                  FadeAnimation(2, 
	                  SizedBox(
                      height: 50,
                      child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                      
                      onPressed: () async {
                        signIn();
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
	                  SizedBox(height: 40,),
	                  FadeAnimation(1.5, Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
	                ],
	              ),
	            )
	          ],
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
        FirebaseUser user = 
        (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user)));
      }catch(e) {
        print('*************ERROR MESSAGE*************');
        print(e);
        return false;
      }
    }
    return false;
  } 
}
      

// class LoginPage extends StatelessWidget {
//   String _email, _password;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//       	child: Container(
// 	        child: Column(
// 	          children: <Widget>[
// 	            Container(
// 	              height: 400,
// 	              decoration: BoxDecoration(
// 	                image: DecorationImage(
// 	                  image: AssetImage('assets/images/background.png'),
// 	                  fit: BoxFit.fill
// 	                )
// 	              ),
// 	              child: Stack(
// 	                children: <Widget>[
// 	                  Positioned(
// 	                    left: 30,
// 	                    width: 80,
// 	                    height: 200,
// 	                    child: FadeAnimation(1, Container(
// 	                      decoration: BoxDecoration(
// 	                        image: DecorationImage(
// 	                          image: AssetImage('assets/images/light-1.png')
// 	                        )
// 	                      ),
// 	                    )),
// 	                  ),
// 	                  Positioned(
// 	                    left: 140,
// 	                    width: 80,
// 	                    height: 150,
// 	                    child: FadeAnimation(1.3, Container(
// 	                      decoration: BoxDecoration(
// 	                        image: DecorationImage(
// 	                          image: AssetImage('assets/images/light-2.png')
// 	                        )
// 	                      ),
// 	                    )),
// 	                  ),
// 	                  Positioned(
// 	                    right: 40,
// 	                    top: 40,
// 	                    width: 80,
// 	                    height: 150,
// 	                    child: FadeAnimation(1.5, Container(
// 	                      decoration: BoxDecoration(
// 	                        image: DecorationImage(
// 	                          image: AssetImage('assets/images/clock.png')
// 	                        )
// 	                      ),
// 	                    )),
// 	                  ),
// 	                  Positioned(
// 	                    child: FadeAnimation(1.6, Container(
// 	                      margin: EdgeInsets.only(top: 50),
// 	                      child: Center(
// 	                        child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
// 	                      ),
// 	                    )),
// 	                  ),
//                     Positioned(
//                       right: 360,
//                       top: 40,
//                         child: FadeAnimation( 
//                           1.2,
//                             IconButton(
//                             icon: Icon(Icons.arrow_back),
//                             color: Colors.black,
//                             onPressed: () {
//                             Navigator.pushReplacementNamed(context, "/choose");
//                           }
//                       ),
//                         ),
//                     ),
// 	                ],
// 	              ),
// 	            ),
// 	            Padding(
// 	              padding: EdgeInsets.all(30.0),
// 	              child: Column(
// 	                children: <Widget>[
// 	                  FadeAnimation(1.8, Container(
// 	                    padding: EdgeInsets.all(5),
// 	                    decoration: BoxDecoration(
// 	                      color: Colors.white,
// 	                      borderRadius: BorderRadius.circular(10),
// 	                      boxShadow: [
// 	                        BoxShadow(
// 	                          color: Color.fromRGBO(143, 148, 251, .2),
// 	                          blurRadius: 20.0,
// 	                          offset: Offset(0, 10)
// 	                        )
// 	                      ]
// 	                    ),
// 	                    child: Form(
//                         key: _formKey,
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               padding: EdgeInsets.all(8.0),
//                               decoration: BoxDecoration(
//                                 border: Border(bottom: BorderSide(color: Colors.grey[100]))
//                               ),
//                               child: TextFormField(
//                                 validator: (input) {
//                                   if(input.isEmpty) {
//                                     return 'Plese provide an email';
//                                   }
//                                 },
//                                 onSaved: (input) {
//                                   _email = input;
//                                 }, 
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: "Email",
//                                   hintStyle: TextStyle(color: Colors.grey[400])
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(8.0),
//                               child: TextFormField(
//                                 validator: (input) {
//                                   if(input.length < 6) {
//                                     return 'Plese provide a password with more than 6 values';
//                                   }
//                                 },
//                                 onSaved: (input) {
//                                   _password = input;
//                                 }, 
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: "Password",
//                                   hintStyle: TextStyle(color: Colors.grey[400]),
                                  
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       )
// 	                  )),
// 	                  SizedBox(height: 60,),
// 	                  FadeAnimation(2, 
// 	                  SizedBox(
//                       height: 50,
//                       child: FlatButton(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                      
//                       onPressed: signIn(context),

//                       child: Ink(
//                         decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                         colors: <Color>[Color.fromRGBO(143, 148, 251, 1),
// 	                          Color.fromRGBO(143, 148, 251, .6),],
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(80.0)),
//                       ),
//                           child: Center(
//                             child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                         )
//                       ),
// 	                      ),
// 	                  ),
// 	                  ),
// 	                  SizedBox(height: 40,),
// 	                  FadeAnimation(1.5, Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
// 	                ],
// 	              ),
// 	            )
// 	          ],
// 	        ),
// 	      ),
//       )
//     );
    
//   }
//   Future<void> signIn(BuildContext context) async{
    
//     final formState = _formKey.currentState;
//     if(formState.validate()) {
//       formState.save();
//       try {
//         FirebaseUser user = 
//         (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)) as FirebaseUser;
//         Navigator.pushReplacementNamed(context, "/choose");
//       }catch(e) {
//         print(e.message);
//       }
//     }
//   }
  
// }

// class EnterField extends StatelessWidget {
//   String _email, _password;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               border: Border(bottom: BorderSide(color: Colors.grey[100]))
//             ),
//             child: TextFormField(
//               validator: (input) {
//                 if(input.isEmpty) {
//                   return 'Plese provide an email';
//                 }
//               },
//               onSaved: (input) {
//                 _email = input;
//               }, 
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: "Email",
//                 hintStyle: TextStyle(color: Colors.grey[400])
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(8.0),
//             child: TextFormField(
//               validator: (input) {
//                 if(input.length < 6) {
//                   return 'Plese provide a password with more than 6 values';
//                 }
//               },
//               onSaved: (input) {
//                 _password = input;
//               }, 
//               obscureText: true,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: "Password",
//                 hintStyle: TextStyle(color: Colors.grey[400]),
                
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//     Future<void> signIn() async{
//     final formState = _formKey.currentState;
//     if(formState.validate()) {
//       formState.save();
//       try {
//         FirebaseUser user = 
//         (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)) as FirebaseUser;
//         Navigator.pushReplacementNamed(context, "/choose");
//       }catch(e) {
//         print(e.message);
//       }
//     }
//   }
//   }
  
// }
