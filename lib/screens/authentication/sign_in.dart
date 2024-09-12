import 'dart:js/js_wasm.dart';

import 'package:firebase_testing/constants/colours.dart';
import 'package:firebase_testing/constants/description.dart';
import 'package:firebase_testing/constants/styles.dart';
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
      backgroundColor: bgBlack,
      appBar: AppBar(
        title: const Text(
          "Sign In",
          style: TextStyle(
            color: mainWhite,
            // fontSize: 18.0,
            // fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: bgBlack,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // Text(
            //   description,
            //   style: descriptionStyle,
            // ),
            Center(
                child: Image.asset('assets/images/covid-19.png',
                height: 500,)
            ) ,
            Form(child: Column(
              children: [
                // email
                // password
                // google
                // register
                // button
                // anonymous
              ],        
            ))
          ],
        ),
      ),
    );
  }
}

// ElevatedButton(
// onPressed: () async{
// dynamic result = await _auth.signInAnonymous();
// if(result == Null){
// print("Error in Sign in Anonymously");
// }else{
// print("Signed in Anonymously");
// print(result.uid);
// }
// },
// child: const Text("Sign In Anonymously")),
