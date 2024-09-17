import 'package:firebase_testing/constants/colours.dart';
import 'package:firebase_testing/constants/styles.dart';
import 'package:firebase_testing/screens/home/home.dart';
import 'package:firebase_testing/services/auth.dart';
import 'package:flutter/material.dart';

import '../../responsive/mobile_screen_layout.dart';
import '../../responsive/responsive_layout_screen.dart';
import '../../responsive/web_screen_layout.dart';
import '../../utils/util_functions.dart';
import '../../widgets/textField.dart';

class Sign_In extends StatefulWidget {

  final Function toggle;
  const Sign_In({super.key, required this.toggle});

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {

  // Controllers for TextFields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  // reference for the class
  final AuthServices _auth = AuthServices();

  // Form Key
  // final _formKey = GlobalKey<FormState>();

  // Email Password States
  // String email = "";
  // String password = "";
  // String error = "";
  @override

  //this  dispose methode is for remove the controller data from the memory
  void dispose() {
    super.dispose();
    //dispose the controllers
    _emailController.dispose();
    _passwordController.dispose();
  }

  //login the user
  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    String result = await _auth.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    //show the snak bar if the user is created or not

    if (result == "email-already-in-use" ||
        result == "weak-password" ||
        result == "invalid-email") {
      showSnakBar(context, result);
    } else if (result == 'success') {
      //here the pushReplacement is used for remove the back button from the screen

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const
          ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
        )
        ),
      );
    }

    setState(() {
      isLoading = false;
    });

    print("user logged in");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            color: mainWhite,
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: bgBlack,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                        child: Column(
                      children: [
                        // email
                        // TextFormField(
                        //   style: textFormStyle,
                        //   decoration: textInputDecorations,
                        //   validator: (value)=>
                        //   value?.isEmpty == true ? "Enter a valid email" : null,
                        //   onChanged: (value){
                        //     setState(() {
                        //       email = value;
                        //     });
                        //   },
                        // ),
                        //text field for email
                        TextInputField(
                          hintText: 'Enter Email',
                          controller: _emailController,
                          isPassword: false,
                          inputKeyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20,),
                        // password
                        // TextFormField(
                        //   obscureText: true,
                        //   style: textFormStyle,
                        //   decoration: textInputDecorations.copyWith(hintText: "Password"),
                        //   validator: (value)=>
                        //   value!.length < 6 ? "Enter a valid password" : null,
                        //   onChanged: (value){
                        //     setState(() {
                        //       password = value;
                        //     });
                        //   },
                        // ),
                        //text feild for password
                        TextInputField(
                          hintText: 'Enter Password',
                          controller: _passwordController,
                          isPassword: true,
                          inputKeyboardType: TextInputType.visiblePassword,
                        ),
                        // Text(error, style: const TextStyle(color:Colors.red),),
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
                          const Text('Don\'t have an account?',
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
                        isLoading
                            ? const CircularProgressIndicator(
                          color: primaryColor,
                        )
                            : GestureDetector(
                          // Method For Login User
                          onTap: loginUser,
                          // async{
                          //   dynamic result = await _auth.signInUsingEmailAndPassword(
                          //       email, password);
                          //   if(result == null){
                          //     setState(() {
                          //       error = "Could not sign in with these credentials";
                          //     });
                          //   }

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
                          onTap: () async{
                            await _auth.signInAnonymous();
                          },
                    
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
