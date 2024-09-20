import 'dart:typed_data';
import 'package:firebase_testing/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colours.dart';
import '../../constants/styles.dart';
import '../../services/doctorDetails.dart';
import '../../widgets/statusBanner.dart';
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dNameController.dispose();
    _dtitleController.dispose();
    _dDescriptionController.dispose();
  }

  //this methode is for select the image from the gallery
  void selectImage() async {
    Uint8List doctorPic = await pickImage(ImageSource.gallery);
    setState(() {
      _doctorPic = doctorPic;
    });
  }

  String? statusMessage;
  bool isSuccess = true;

  // Method to handle doctor registration
  Future<void> addDoctor() async {
    // Clear previous messages
    setState(() {
      statusMessage = null;
    });

    // Check if any of the fields are empty
    if (_dNameController.text.isEmpty) {
      setState(() {
        statusMessage = "Please enter the doctor's name.";
        isSuccess = false;
      });
      return;
    }

    if (_dtitleController.text.isEmpty) {
      setState(() {
        statusMessage = "Please enter the doctor's title.";
        isSuccess = false;
      });
      return;
    }

    if (_dDescriptionController.text.isEmpty) {
      setState(() {
        statusMessage = "Please enter the doctor's description.";
        isSuccess = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Call the method from DoctorDetailsService to add the doctor
      await DoctorDetailsService().addDoctor(
        _dNameController.text,
        _dtitleController.text,
        _dDescriptionController.text,
        _doctorPic,
      );

      setState(() {
        isLoading = false;
        statusMessage = "Doctor added successfully!";
        isSuccess = true;
      });

      // Optionally clear the inputs after successful registration
      _dNameController.clear();
      _dtitleController.clear();
      _dDescriptionController.clear();
      _doctorPic = null;

      // Show success message or navigate away
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Handle error
      print('Error adding doctor: $error');
    }
  }

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
                  // Show the status message if available
                  if (statusMessage != null)
                    StatusBanner(
                      message: statusMessage,
                      isSuccess: isSuccess,
                    ),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      //if the profile image is null show the default image
                      _doctorPic != null
                          ?CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: MemoryImage(_doctorPic!),
                      ):
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
                                onPressed: selectImage
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
                                isPassword: false
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
                            isLoading
                                ? const CircularProgressIndicator(
                              color: mainBlue,
                            )
                                :
                            GestureDetector(
                              // Method For Register User
                              onTap: addDoctor,
                              child: Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: mainBlue,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(width: 2, color: mainBlue)
                                  ),
                                  child: const Center(
                                    child: Text("Add Doctor",
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