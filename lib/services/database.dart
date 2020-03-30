import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day12_login/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  String uid;
  Database({this.uid});
  DocumentReference uidCollection;
  DocumentReference messageCollection;
  Future<UserData> value;

// MSWLR
  Future updateUserData(bool math, bool science, bool writing, bool language, bool reading, String name, int grade,) async{
    uidCollection = Firestore.instance.collection("active").document(uid);
    messageCollection = Firestore.instance.collection("messages").document(uid);

    

    await messageCollection.setData(
    {
      'nickname': name,
      'photoUrl': null,
      "id" : uid,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
      'chattingWith': null,
      'beingCalled': false,
    });


    return await uidCollection.setData(
    {
      "math" : math,
      "science" : science,
      "writing" : writing,
      "language" : language,
      "reading" : reading,
      "name" : name,
      "grade" : grade,
    });
  }

  // Future updateMessages(String photoUrl) async{
  //   uidCollection = Firestore.instance.collection("messages").document(uid);
    
  //   return await uidCollection.setData(
  //   {
  //    "photoUrl": photoUrl
  //   });
  // }


 
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
      name: snapshot.data["name"],
      grade: snapshot.data["grade"],
    );
  }

  Message _userDataFromMessage (DocumentSnapshot snapshot) {
    return Message(
      id: snapshot.data["id"],
    );
  }

  WantedId _beingCalled (DocumentSnapshot snapshot) {
    return WantedId(
      wantedId: snapshot.data["beingCalled"],
    );
  }

  Stream<UserData> get userData {
    uidCollection = Firestore.instance.collection('active').document(uid);
    // need to Somehow put "value" into the stream of data
    // value = uidCollection.get().then((value) =>  (_userDataFromSnapshot(value)));
    // return value;

    return uidCollection.snapshots().map(_userDataFromSnapshot);
    // are you getting a value here? There might be a problem here.
    // im not sure
    // can we call 
    //let me test first. not sure if the value uidCollection is being passed to userDataFromSnapshot
    // I cant run the code via Liveshare
    // make the changes and i will run it in my emulator and tell you the re

    //return Firestore.instance.collection('active').document(uid).get().then((value) =>  (_userDataFromSnapshot(value)));;
    // need to Somehow put "value" into the stream of data
    
  }

  Stream<Message> get messageData {
    messageCollection = Firestore.instance.collection('messages').document(uid);

    return messageCollection.snapshots().map(_userDataFromMessage);
  
  }

  Stream<WantedId> call(String wantedID) {
    messageCollection = Firestore.instance.collection('messages').document(wantedID);

    return messageCollection.snapshots().map(_beingCalled);
  
  }
}



   


  
