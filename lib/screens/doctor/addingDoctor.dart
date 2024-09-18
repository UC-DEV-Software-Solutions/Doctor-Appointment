import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../constants/colours.dart';
import '../../constants/styles.dart';
import '../../widgets/textField.dart';

class Addingdoctor extends StatefulWidget {
  const Addingdoctor({super.key});

  @override
  State<Addingdoctor> createState() => _AddingdoctorState();
}

class _AddingdoctorState extends State<Addingdoctor> {

  // Controllers for TextFields
  final TextEditingController _dNameController = TextEditingController();
  final TextEditingController _dtitleController = TextEditingController();
  final TextEditingController _dDescriptionController = TextEditingController();
  Uint8List? _doctorPic;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainWhite,
      appBar: AppBar(
        title: const Text(
          "Add Doctor",
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
                  // const Mainbanner(),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      //if the profile image is null show the default image
                      // _profileImage != null
                      //     ?CircleAvatar(
                      //   radius: 50,
                      //   backgroundColor: Colors.grey[300],
                      //   backgroundImage: MemoryImage(_profileImage!),
                      // ):
                      const CircleAvatar(
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
                                onPressed: (){}
                                // selectImage
                                ,
                                icon: Icon(Icons.add_a_photo)),
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
                                controller: _dNameController,
                                hintText: "Name *",
                                inputKeyboardType: TextInputType.text,
                                isPassword: false
                            ),
                            const SizedBox(height: 20,),
                            // email
                            TextInputField(
                                controller: _dtitleController,
                                hintText: "Title *",
                                inputKeyboardType: TextInputType.text,
                                isPassword: false
                            ),
                            const SizedBox(height: 20,),
                            // password
                            TextInputField(
                                controller: _dDescriptionController,
                                hintText: "Description *",
                                inputKeyboardType: TextInputType.text,
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
                                  const Text("Do you want to edit Doctor",
                                    style: descriptionStyle,
                                  ),
                                  const SizedBox(width: 10,),
                                  GestureDetector(
                                    // Land to the SignIn Page
                                    onTap:(){
                                      // widget.toggle();
                                    },
                                    child: const Text(
                                      "Edit",
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
                            // isLoading
                            //     ? const CircularProgressIndicator(
                            //   color: primaryColor,
                            // )
                            //     :
                            GestureDetector(
                              // Method For Register User
                              onTap: (){},
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