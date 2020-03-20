import 'package:day12_login/Screens/quiz.dart';
import 'package:day12_login/Screens/choose.dart';
import 'package:day12_login/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return Choose();
    } else {
      return Quiz();
    }
  }
}