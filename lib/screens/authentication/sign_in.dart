
import 'package:firebase_testing/constants/colours.dart';
import 'package:firebase_testing/constants/styles.dart';
import 'package:firebase_testing/services/auth.dart';
import 'package:flutter/material.dart';

class Sign_In extends StatefulWidget {

  final Function toggle;
  const Sign_In({super.key, required this.toggle});

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  // reference for the class
  final AuthServices _auth = AuthServices();

  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Email Password States
  String email = "";
  String password = "";

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   description,
              //   style: descriptionStyle,
              // ),
              Center(
                  child: Image.asset('assets/images/covid-19.png',
                  height: 400,
                  )
              ) ,
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                  children: [
                    // email
                    TextFormField(
                      style: textFormStyle,
                      decoration: textInputDecorations,
                      validator: (value)=>
                      value?.isEmpty == true ? "Enter a valid email" : null,
                      onChanged: (value){
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20,),
                    // password
                    TextFormField(
                      style: textFormStyle,
                      decoration: textInputDecorations.copyWith(hintText: "Password"),
                      validator: (value)=>
                      value!.length < 6 ? "Enter a valid password" : null,
                      onChanged: (value){
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    // google
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                        "Login with social accounts",
                        style: descriptionStyle
                    ),
                    GestureDetector(
                      // Sign in with Google
                      onTap: (){},
                      child: Center(
                          child: Image.asset('assets/images/GoogleIcon.png',
                            height: 50,)
                      ),
                    ) ,
                    const SizedBox(height: 20),
                    // register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text("Do not have an account?",
                      style: descriptionStyle,
                      ),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        // Land to the Register Page
                        onTap:(){
                          widget.toggle();
                        },
                        child: const Text(
                          "REGISTER",
                          style: TextStyle(color: mainBlue,
                          fontWeight: FontWeight.w900,
                        ),
                        ),
                      )]
                    ),
                    const SizedBox(height: 20),
                    // button
                    GestureDetector(
                      // Method For Login User
                      onTap: (){},

                      child: Container(
                        height: 40,
                          width: 200,
                        decoration: BoxDecoration(
                            color: mainBlue,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2, color: mainYellow)),
                        child: const Center(
                            child: Text("LOG IN",
                          style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w700),
                        ),
                        )
                      ),
                    ),
                    const SizedBox(height: 15,),
                    // anonymous
                    GestureDetector(
                      // Method For Login User
                      onTap: (){},

                      child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                              color: mainBlue,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 2, color: Colors.red)),
                          child: const Center(
                            child: Text("LOG IN AS GUEST",
                              style: TextStyle(color: Colors.red,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                      ),
                    )
                  ],
                )),
              )
            ],
          ),
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
