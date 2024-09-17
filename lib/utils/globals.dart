import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/screens/doctorDetails/doctorDetails.dart';
import 'package:firebase_testing/screens/makeAppontment/makeAppointment.dart';
import 'package:flutter/material.dart';

import '../screens/home/home.dart';
// import 'package:instagram_clone/screens/main_screens/feed_screen.dart';
// import '../../screens/main_screens/add_post_screen.dart';
// import '../screens/main_screens/search_screen.dart';
// import '../screens/profile_screen.dart';

List<Widget> homeScreenLayouts = [
  const Home(),
  Makeappointment(),
  const Doctordetails(),
  // const AddPostScreen(),
  // const Text("Favorite"),
  // ProfileScreen(
  //   uid: FirebaseAuth.instance.currentUser!.uid,
  // ),
];