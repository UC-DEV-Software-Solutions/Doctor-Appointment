import 'package:flutter/material.dart';

import '../../constants/colours.dart';
import '../../constants/styles.dart';
import '../../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggle;
  const Register({super.key, required this.toggle});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // reference for the class
  final AuthServices _auth = AuthServices();

  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Email Password States
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainWhite,
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(
            color: bgBlack,
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: mainWhite,
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
                          obscureText: true,
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
                        // error
                        Text(error, style: const TextStyle(color: Colors.red),),
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
                        // Sign In Page
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Do you have an account?",
                                style: descriptionStyle,
                              ),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                // Land to the SignIn Page
                                onTap:(){
                                  widget.toggle();
                                },
                                child: const Text(
                                  "LOG IN",
                                  style: TextStyle(color: mainBlue,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              )]
                        ),
                        const SizedBox(height: 20),
                        // button
                        GestureDetector(
                          // Method For Register User
                          onTap: () async {
                            dynamic result = await _auth.registerWithEmailAndPassword(
                                email, password);
                            if(result == null){
                              // error
                              setState(() {
                                error = "Please enter a valid email";
                              });
                            }

                          },

                          child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: mainBlue,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(width: 2, color: mainBlue)),
                              child: const Center(
                                child: Text("REGISTER",
                                  style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                          ),
                        ),
                        const SizedBox(height: 15,),
                        // anonymous

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

