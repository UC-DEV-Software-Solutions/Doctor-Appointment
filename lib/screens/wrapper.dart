import 'package:firebase_testing/models/UserModel.dart';
import 'package:firebase_testing/screens/authentication/authenticate.dart';
import 'package:firebase_testing/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // The user data that the provider provides can be data or null
    final user = Provider.of<UserModel?>(context);
    if (user == null){
      return const Authenticate();
    } else{
      return const ResponsiveLayout(
        webScreenLayout: WebScreenLayout(),
        mobileScreenLayout: MobileScreenLayout(),
      );
    }
  }
}