import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/models/UserModel.dart';
import 'package:firebase_testing/services/storage.dart';
import '../../models/UserModel.dart' as user_model;

class AuthServices{

  //Firebase Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;


  //get the current user details
  Future<user_model.UserModel> getCurrentUser() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot =
    await _fireStore.collection('users').doc(currentUser.uid).get();

    return user_model.UserModel.fromJSON(snapshot.data() as Map<String, dynamic>);
  }

  // create a user form firebase and uid
  // UserModel? _userwithFirebaseUserUid(User? user){
  //   return user != null ? UserModel(uid: user.uid) : null;
  // }

  // create the stream for checking the auth changes in the user
  // Stream<UserModel?> get user{
  //   return _auth.authStateChanges().map(_userwithFirebaseUserUid);
  // }

  //Sign in anonymous
  // Future ==> async ==> await
  Future signInAnonymous() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      // return _userwithFirebaseUserUid(user);
    }catch(err){
      return null;
    }
  }

  //Register using Email and Password
//   Future registerWithEmailAndPassword(String email,String password) async {
//     try{
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       User? user = result.user;
//       return _userwithFirebaseUserUid(user);
//     }
//     catch(err){
//       print(err.toString());
//       return null;
//     }
// }
  Future <String> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
    required Uint8List profilePic,
}) async {
    String res = "An error occurred";
    try{
      if(userName.isNotEmpty &&
      password.isNotEmpty &&
      email.isNotEmpty && profilePic.isNotEmpty){
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
        
        // upload the profilepic to the storage
        String photoURL = await StorageServices().uploadImage(folderName: "ProfileImages", isPrescription: false, file: profilePic);

        UserModel user = UserModel(uid: _auth.currentUser!.uid,email: email,userName: userName,profilePic: photoURL);

        if (userCredential.user != null){
          await _fireStore.collection('users').doc(_auth.currentUser!.uid).set(user.toJSON(),);
          res = 'success';
        }

      }
    }
    // extra error handling
    on FirebaseAuthException catch (error){
      if(error.code == 'invalid-email'){
        res = 'invalid-email';
      }else if(error.code == 'weak-password'){
        res = 'weak-password';
      }else if(error.code == 'email-already-in-use'){
        res = 'email-already-in-use';
      }
    }
    catch(error){
      error.toString();

    }
    return res;
  }
  //Sign in using Gmail
  // Future signInUsingEmailAndPassword(String email,String password) async {
  //   try{
  //     UserCredential result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     User? user = result.user;
  //     // return _userwithFirebaseUserUid(user);
  //   }catch(err){
  //     print(err);
  //     return null;
  //   }
  // }

  //login user
  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    String res = "An error occured";

    try {
      //if the inputs are not empty
      if (email.isNotEmpty && password.isNotEmpty) {
        //login the user with email and password
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = "success";
      } else {
        res = "Please enter email and password";
      }
    }

    //catch the errors extra error handling
    on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        res = "Invalid email";
      } else if (error.code == "weak-password") {
        res = "Weak password";
      } else if (error.code == "email-already-in-use") {
        res = "Email already in use";
      }
    } catch (error) {
      res = error.toString();
    }

    return res;
  }

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