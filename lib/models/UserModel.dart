// create a user with UID

class UserModel{
  // schema
  final String uid;
  final String email;
  final String userName;
  final String? profilePic;
  final String userType;

  // constructor
  UserModel({
    required this.uid,
    required this.email,
    required this.userName,
    required this.userType,
    this.profilePic,
  });

  // userData into json object
  Map<String, dynamic> toJSON(){
    return{
      'uid':uid,
      'email':email,
      'userName':userName,
      'profilePic':profilePic,
      'userType':userType,
    };
  }

  // json object convert to userData
  factory UserModel.fromJSON(Map<String,dynamic> json){
    return UserModel(
        uid: json['uid'],
        email: json['email'],
        userName: json['userName'],
        profilePic: json['profilePic'],
        userType: json['userType']
    );
  }
}