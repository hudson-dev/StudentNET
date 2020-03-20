import 'package:day12_login/Models/user.dart';
import 'package:day12_login/Screens/home.dart';
import 'package:day12_login/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

void main() => runApp(Grade());

/// This Widget is the main application widget.
class Grade extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        
        body: Container(
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "I am currently a",
                style: TextStyle(fontSize: 30)
                ),
              Center(
                
                child: DropDown(),
              ),
              SizedBox(height: 20),
              
            ] 
            ),
        ),
        ),
      );
  }
}

class DropDown extends StatefulWidget {
  
  DropDown({Key key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {

  String dropdownValue = 'none';


  String holder = '' ;


 int getDropDownItem(){

    if(dropdownValue == "none"){
      return 0;
    }
    if(dropdownValue == "1st grader"){
      return 1;
    }
    if(dropdownValue == "2nd grader"){
      return 2;
    }
    if(dropdownValue == "3rd grader"){
      return 3;
    }
    if(dropdownValue == "4th grader"){
      return 4;
    }
    if(dropdownValue == "5th grader"){
      return 5;
    }
    if(dropdownValue == "6th grader"){
      return 6;
    }
    if(dropdownValue == "7th grader"){
      return 7;
    }
    if(dropdownValue == "8th grader"){
      return 8;
    }
    if(dropdownValue == "Freshman"){
      return 9;
    }
    if(dropdownValue == "Sophomore"){
      return 10;
    }

    if(dropdownValue == "Junior"){
      return 11;
    }
    if(dropdownValue == "Senior"){
      return 12;
    }
    if(dropdownValue == "College"){
      return 13;
    }
    if(dropdownValue == "other"){
      return 14;
    }
  }
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
 
            
            return Center(
      child: Column(
        children: <Widget>[
          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 20,
            elevation: 16,
            style: TextStyle(color: Colors.blueGrey[300], fontSize: 30),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['none','1st grader','2nd grader','3rd grader','4th grader','5th grader','6th grader','7th grader','8th grader','Freshman','Sophomore','Junior','Senior','College','other',]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          RaisedButton(
            color: Colors.blue[100],
            onPressed: () {
              int grade = getDropDownItem();
              print(grade.toString());
              Database(uid: user.uid).updateUserData(math, science, writing, language, reading, name, grade);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
            },
            child: Text("Next")
          )
        ],
      ),
    );
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




    
  }
}