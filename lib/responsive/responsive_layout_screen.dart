import 'package:firebase_testing/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class ResponsiveLayout extends StatefulWidget {

  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  //this is the list of the states
  addStates() async {
    //add the states
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constrains) {
          if(constrains.maxWidth > webScrenSize){
            return widget.webScreenLayout;
          }
          else{
            return widget.mobileScreenLayout;
          }
        },
    );
  }
}
