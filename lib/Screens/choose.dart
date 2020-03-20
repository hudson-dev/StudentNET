import 'package:day12_login/Animation/FadeAnimation.dart';
import 'package:day12_login/Screens/loginPage.dart';
import 'package:day12_login/Screens/registerPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Choose extends StatelessWidget {

  // Choose({Key key, this.context}) : super(key: key);

  // final BuildContext context;
  Color loginAndRegisterColor = Color(0xff4D8FAC);

  
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
	              child: Stack(
	                children: <Widget>[
                    ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        height: 400,
                        color: Colors.blue[200],
                      ),
                    ),
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
	                      margin: EdgeInsets.only(top: 170),
	                      child: Center(
	                        child: Text("Login or Register", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
	                      ),
	                    )),
	                  )
	                ],
	              ),
	            ),

              // MARKED
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
	                    child: Column(
	                      children: <Widget>[
	                        Container(
	                          padding: EdgeInsets.all(8.0),
	                          // decoration: BoxDecoration(
	                          //   border: Border(bottom: BorderSide(color: Colors.grey[100]))
	                          // ),
	                          child: RaisedButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                              child: Ink(
                                
                                child: Container(
                                  width: 400,
                                  height: 50,
                                  child: Center(
                                    child: Text('login', style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 30.0, color: loginAndRegisterColor))
                                  )
                                ),
                              )
                            )
	                        ),
                          Text('or', style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 19.0, color: Colors.purple[100])),
	                        Container(
	                          padding: EdgeInsets.all(8.0),
	                          child: RaisedButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                              child: Container(
                                width: 400,
                                height: 50,
                                child: Center(
                                  child: Text('register', style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 30.0, color: loginAndRegisterColor))
                                )
                              )
                            )
	                        )
	                      ],
	                    ),
	                  )
                    ),
	                  SizedBox(height: 30,),
                    /*
	                  FadeAnimation(2, Container(
	                    height: 50,
	                    decoration: BoxDecoration(
	                      borderRadius: BorderRadius.circular(10),
	                      gradient: LinearGradient(
	                        colors: [
	                          Colors.blue[200],
	                          Colors.blue[100],
	                        ]
	                      )
	                    ),
	                    child: Center(
	                      child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
	                    ),
	                  )),
                    */
	                ],
	              ),
	            )
	          ],
	        ),
	      ),
      )
    );
  }
}