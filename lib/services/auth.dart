import 'package:day12_login/Models/user.dart';
import 'package:day12_login/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Database database = new Database();

  //convert the firebase user obj into User obj
  User _getUser(FirebaseUser user){
    return user != null ? User(uid:user.uid) : null;
  }

  Database get getDatabase {
    return database;
  }

  //Start a stream for users to set the state
  Stream<User> get user{
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
  Future registerWithEmailAndPassword(String email, String password)async{
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      User val = _getUser(user);
      database = Database(uid: val.uid);
      await Database(uid : user.uid).updateUserData(false, false, false, false, false, false);
      return val;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Method to SignIn with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email:  email, password:  password);
      FirebaseUser user = result.user;
      User val = _getUser(user);
      database = Database(uid: val.uid);
      return val;
    } catch (e) {
      print((e.toString()));
      return null;
    }
  }


  //Method to Sign Out
  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}