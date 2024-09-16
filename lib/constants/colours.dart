import 'package:flutter/material.dart';

const Color bgBlack = Color(0xff121212);
const Color textLight = Color(0xff9E9595);
const Color mainYellow = Color(0xffFFCE00);
const Color mainBlue = Color(0xff4285F4);
const Color mainWhite = Color(0xffFFFFFF);
const Color mainGreen = Color(0xff40C63E);


const mobileBackgroundColor = Color.fromRGBO(0, 0, 0, 1);
const webBackgroundColor = Color.fromRGBO(18, 18, 18, 1);
const mobileSearchColor = Color.fromRGBO(38, 38, 38, 1);
const mainYellowColor = Color.fromRGBO(254, 222, 0, 1);
const primaryColor = Colors.white;
const secondaryColor = Colors.grey;

// Define dark theme colors
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: mainYellow,
  scaffoldBackgroundColor: bgBlack,
  appBarTheme: const AppBarTheme(
    backgroundColor: bgBlack,
    titleTextStyle: TextStyle(color: mainWhite),
  ),
  textTheme: const TextTheme(
    // bodyText1: TextStyle(color: textLight),
    // bodyText2: TextStyle(color: mainWhite),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: mainBlue,
  ),
);

// Define light theme colors
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: mainBlue,
  scaffoldBackgroundColor: mainWhite,
  appBarTheme: const AppBarTheme(
    backgroundColor: mainWhite,
    titleTextStyle: TextStyle(color: bgBlack),
  ),
  textTheme: const TextTheme(
    // bodyText1: TextStyle(color: bgBlack),
    // bodyText2: TextStyle(color: textLight),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: mainGreen,
  ),
);