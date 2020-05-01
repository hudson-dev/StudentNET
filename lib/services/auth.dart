import 'package:day12_login/Models/user.dart';
import 'package:day12_login/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Database database = new Database();

  //convert the firebase user obj into User obj
  Person _getUser(FirebaseUser user) {
    return user != null ? Person(uid: user.uid) : null;
  }

  Database get getDatabase {
    return database;
  }

  Future<FirebaseUser> get currentUser async {
    return await _auth.currentUser();

  }


  Stream<Person> get user {
    return _auth.onAuthStateChanged.map(_getUser);
  }
  
  //Method to sign In Anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _getUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Method to Register in with email & password
  Future registerWithEmailAndPassword(String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      Person val = _getUser(user);
      database = Database(uid: val.uid);
      await Database(uid: user.uid)
          .updateUserData(false, false, false, false, false, name, 0);
      return val;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Method to SignIn with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      Person val = _getUser(user);
      database = Database(uid: val.uid);
      print(user);
      return val;
    } catch (e) {
      print((e.toString()));
      return null;
    }
  }

  //Method to Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch(e){
      print(e.toString());
      return false;
    }
  }

}


