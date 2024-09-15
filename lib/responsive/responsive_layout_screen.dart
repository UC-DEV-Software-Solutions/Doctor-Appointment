import 'package:firebase_testing/utils/constants.dart';
import 'package:flutter/material.dart';

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
