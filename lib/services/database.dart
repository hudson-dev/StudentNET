import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day12_login/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  String uid;
  Database({this.uid});
  DocumentReference uidCollection;
  Future<UserData> value;

// MSWLR
  Future updateUserData(bool math, bool, science, bool writing, bool language, bool reading) async{
    uidCollection = Firestore.instance.collection("active").document(uid);
    
    return await uidCollection.setData(
    {
      "math" : math,
      "science" : science,
      "writing" : writing,
      "language" : language,
      "reading" : reading,
    });
  }
  //convert the firebase user obj into User obj
  User _getUser(FirebaseUser user){
    return user != null ? User(uid:user.uid) : null;
  }


  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
     // name: snapshot.data['name'],
      math: snapshot.data["math"],
      science: snapshot.data["science"],
      writing: snapshot.data["writing"],
      language: snapshot.data["language"],
      reading: snapshot.data["reading"],
    );
  }

  List<UserData> _preferencesFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return UserData(
        language: doc.data['language'] ?? false,
        math: doc.data['math'] ?? false,
        reading: doc.data['reading'] ?? false,
        science: doc.data['science'] ?? false,
        writing: doc.data['writing'] ?? false,
      );
    }).toList();
  }

  Stream<UserData> get userData {
    uidCollection = Firestore.instance.collection('active').document(uid);
    // need to Somehow put "value" into the stream of data
    // value = uidCollection.get().then((value) =>  (_userDataFromSnapshot(value)));
    // return value;

    return uidCollection.snapshots().map(_userDataFromSnapshot);

    //return Firestore.instance.collection('active').document(uid).get().then((value) =>  (_userDataFromSnapshot(value)));;
    // need to Somehow put "value" into the stream of data
    
  }
}

   


  
