import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  //Firebase Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Sign in anonymous
  // Future ==> async ==> await
  Future signInAnonymous() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    }catch(err){
      return null;
    }
  }

  //Register using Email and Password
  //Sign in using Gmail
  //SignOut
}