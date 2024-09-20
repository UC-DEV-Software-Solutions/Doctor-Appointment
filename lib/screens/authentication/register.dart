import 'dart:typed_data';

import 'package:firebase_testing/screens/home/home.dart';
import 'package:firebase_testing/screens/wrapper.dart';
import 'package:firebase_testing/widgets/mainBanner.dart';
import 'package:firebase_testing/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colours.dart';
import '../../constants/styles.dart';
import '../../responsive/mobile_screen_layout.dart';
import '../../responsive/responsive_layout_screen.dart';
import '../../responsive/web_screen_layout.dart';
import '../../services/auth.dart';
import '../../utils/util_functions.dart';

class Register extends StatefulWidget {
  final Function toggle;
  const Register({super.key, required this.toggle});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // Controllers for TextFields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _profileImage;
  bool isLoading = false;

  // reference for the class
  final AuthServices _auth = AuthServices();

  //register the user
  void registerUser() async {
    setState(() {
      isLoading = true;
    });
    //get the user data from the text fields
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String userName = _nameController.text.trim();

    //register the user
    String result = await _auth.registerWithEmailAndPassword(
      email: email,
      password: password,
      userName: userName,
      profilePic: _profileImage,
    );

    //show the snakbar if the user is created or not
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
          Wrapper()
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

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
    _nameController.dispose();
  }

  //this methode is for select the image from the gallery
  void selectImage() async {
    Uint8List _profileImage = await pickImage(ImageSource.gallery);
    setState(() {
      this._profileImage = _profileImage;
    });
  }


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
                  const Mainbanner(),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      //if the profile image is null show the default image
                      _profileImage != null
                      ?CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: MemoryImage(_profileImage!),
                      ):const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1631&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                          right: 0,
                          child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: mainWhite,
                          borderRadius: BorderRadiusDirectional.circular(30),
                        ),
                        child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo)),
                      ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Form(
                        // key: _formKey,
                        child: Column(
                          children: [
                            // Name
                            TextInputField(
                                controller: _nameController,
                                hintText: "Name",
                                inputKeyboardType: TextInputType.text,
                                isPassword: false
                            ),
                            const SizedBox(height: 20,),
                            // email
                            TextInputField(
                                controller: _emailController,
                                hintText: "Email",
                                inputKeyboardType: TextInputType.emailAddress,
                                isPassword: false
                            ),
                            const SizedBox(height: 20,),
                            // password
                            TextInputField(
                                controller: _passwordController,
                                hintText: "Password",
                                inputKeyboardType: TextInputType.visiblePassword,
                                isPassword: true
                            ),
                            // google
                            const SizedBox(
                              height: 20,
                            ),
                            // error
                            // Text(error, style: const TextStyle(color: Colors.red),),
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
                            const SizedBox(height: 0),
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
                            const SizedBox(height: 0),
                            // button
                            //button for login
                            const SizedBox(
                              height: 30,
                            ),
                            isLoading
                                ? const CircularProgressIndicator(
                              color: primaryColor,
                            )
                                : GestureDetector(
                              // Method For Register User
                              onTap: registerUser,
                              child: Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: mainBlue,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(width: 2, color: mainBlue)
                                  ),
                                  child: const Center(
                                    child: Text("REGISTER",
                                      style: TextStyle(color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                              ),
                            ),

                            const SizedBox(height: 100,),
                            // anonymous

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

