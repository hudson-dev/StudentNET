class User{
  String uid;

  User({this.uid});
}

// MSWLR
class UserData {

 // final String name;
  bool math;
  bool science;
  bool writing;
  bool language;
  bool reading;

  String name;
  String photoUrl;
  int grade;

  UserData({this.math, this.science, this.writing, this.language, this.reading, this.name, this.grade, this.photoUrl});

}

class Message {

  String id;
  
  
  Message({this.id});
}

class WantedId {

   String wantedId;
  
  
  WantedId({this.wantedId});
}