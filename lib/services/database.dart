import 'package:cloud_firestore/cloud_firestore.dart';

class database {
  final String uid;
  database({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection("user");

  Future updateUserData()async{
    return await userCollection.document(uid).setData(
    {
      map : "strengths",
      "name" : name,
      "strength" : strength
    });
  }

  
}