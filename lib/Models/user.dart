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

  bool beingCalled;
  String chattingWith;
  String createdAt;
  String id;
  String nickname;
  String photoUrl;

  
  
  Message({this.beingCalled, this.chattingWith, this.createdAt, this.id, this.nickname,this.photoUrl});
}

class WantedId {

   String wantedId;
  
  
  WantedId({this.wantedId});
}