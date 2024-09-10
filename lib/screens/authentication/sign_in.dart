import 'package:firebase_testing/services/auth.dart';
import 'package:flutter/material.dart';

class Sign_In extends StatefulWidget {
  const Sign_In({super.key});

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {

  // reference for the class
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In"),
      ),
      body: ElevatedButton(
          onPressed: () async{
            dynamic result = await _auth.signInAnonymous();
            if(result == Null){
              print("Error in Sign in Anonymously");
            }else{
              print("Signed in Anonymously");
              print(result.uid);
            }
          },
          child: const Text("Sign In Anonymously")),
    );
  }
}
