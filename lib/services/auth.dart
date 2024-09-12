import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/models/UserModel.dart';

class AuthServices{

  //Firebase Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create a user form firebase and uid
  UserModel? _userwithFirebaseUserUid(User? user){
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // create the stream for checking the auth changes in the user
  Stream<UserModel?> get user{
    return _auth.authStateChanges().map(_userwithFirebaseUserUid);
  }

  //Sign in anonymous
  // Future ==> async ==> await
  Future signInAnonymous() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userwithFirebaseUserUid(user);
    }catch(err){
      return null;
    }
  }

  //Register using Email and Password
  //Sign in using Gmail
  //SignOut
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(err){
      print(err.toString());
      return null;
    }
  }
}