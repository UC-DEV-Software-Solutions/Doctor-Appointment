import 'package:firebase_testing/screens/home/PreviousAppointmentScreen.dart';
import 'package:firebase_testing/screens/home/doctorDetails.dart';
import 'package:firebase_testing/screens/home/makeAppointment.dart';
import 'package:firebase_testing/screens/home/profile.dart';
import 'package:flutter/material.dart';
import '../screens/home/home.dart';

List<Widget> homeScreenLayouts = [
  const Home(),
  Makeappointment(),
  const Doctordetails(),
  PreviousAppointmentScreen(),
  const Profile()
  // const AddPostScreen(),
  // const Text("Favorite"),
  // ProfileScreen(
  //   uid: FirebaseAuth.instance.currentUser!.uid,
  // ),
];