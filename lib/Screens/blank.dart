import 'package:day12_login/Screens/quiz.dart';
import 'package:flutter/material.dart';

void main() => runApp(Blank());
/// This Widget is the main application widget.
class Blank extends StatelessWidget {
 static const String _title = 'Flutter Code Sample';
 @override
 Widget build(BuildContext context) {
   Container(
     color: Colors.grey,
   );
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Quiz()));
 }
}
 
 

