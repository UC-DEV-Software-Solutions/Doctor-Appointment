import 'package:flutter/material.dart';

import '../constants/colours.dart';

class Mainbanner extends StatefulWidget {
  const Mainbanner({super.key});

  @override
  State<Mainbanner> createState() => _MainbannerState();
}

class _MainbannerState extends State<Mainbanner> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: 150,
        width: 400,
        decoration: BoxDecoration(
          color: mainBlue,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 2, color: mainBlue),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "DOCTOR APPOINTMENT",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 25,
              ),
            ),
            // const SizedBox(height: ),
            SizedBox(
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: mainGreen,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 2, color: mainBlue),
                ),
                child: const Center( // Use Center here to align the text vertically in this inner container
                  child: Text(
                    "ONLINE SYSTEM",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20, // Adjust font size for inner container
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Spacing between text and image
            // Image.asset(
            //   'assets/images/covid-19.png',
            //   height: 50, // Adjust height as needed
            // ),
          ],
        ),
      ),
    );
  }
}
