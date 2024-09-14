import 'package:firebase_testing/constants/colours.dart';
import 'package:flutter/material.dart';

const TextStyle descriptionStyle = TextStyle(
  fontSize: 15,
  color: textLight,
  fontWeight: FontWeight.w200
);

const textInputDecorations = InputDecoration(
    hintText: "Email",
    hintStyle: TextStyle(color: textLight , fontSize: 15),
    fillColor: bgBlack,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainGreen, width: 3),
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        )
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainGreen, width: 3),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        )
    )
);