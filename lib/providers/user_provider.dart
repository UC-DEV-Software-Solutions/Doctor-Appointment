import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/UserModel.dart';
import '../services/auth.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final AuthServices _auth = AuthServices();
  //getter
  UserModel get getUser => _user!;

  //methode for registering the user
  Future<void> refreshUser() async {
    UserModel user = await _auth.getCurrentUser();
    _user = user;

    //notify the listeners
    notifyListeners();
  }
}