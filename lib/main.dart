import 'package:firebase_testing/models/UserModel.dart';
import 'package:firebase_testing/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_testing/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // to initialize firebase
  await Firebase.initializeApp();  // to initialize firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      initialData: UserModel(uid: ""),
      value:AuthServices().user,
        child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
