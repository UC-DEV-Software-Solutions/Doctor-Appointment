import 'package:firebase_testing/services/auth.dart';
import 'package:firebase_testing/widgets/Carosel.dart';
import 'package:flutter/material.dart';

import '../../constants/colours.dart';
import '../../constants/styles.dart';
import '../wrapper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // create a obj from AuthService
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        title: const Text("WELCOME",
          style: TextStyle(
          color: bgBlack,
          fontSize: 35.0,
          fontWeight: FontWeight.bold,),
        ),
          actions: [
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red),
                  foregroundColor: MaterialStatePropertyAll(bgBlack),
                ),
                onPressed: () async{
              await _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Wrapper(), // Replace with your SignIn page widget
                ),
              );
            }, child: const Icon(Icons.logout))
          ],
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Carosel(),
                // Text(
                //   description,
                //   style: descriptionStyle,
                // ),
                Center(
                    child: Image.asset('assets/images/covid-19.png',
                      height: 400,
                    )
                ) ,
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Form(
                      child: Column(
                        children: [


                          // password

                          // google
                          const SizedBox(
                            height: 20,
                          ),
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
                          const SizedBox(height: 20),
                          // register
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Do you have an account?",
                                  style: descriptionStyle,
                                ),
                                const SizedBox(width: 10,),
                                GestureDetector(
                                  // Land to the Register Page
                                  onTap:(){},
                                  child: const Text(
                                    "LOG IN",
                                    style: TextStyle(color: mainBlue,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                )]
                          ),
                          const SizedBox(height: 20),
                          // button
                          GestureDetector(
                            // Method For Login User
                            onTap: (){},

                            child: Container(
                                height: 40,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: mainBlue,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(width: 2, color: mainBlue)),
                                child: const Center(
                                  child: Text("HOME",
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                            ),
                          ),
                          const SizedBox(height: 15,),
                          // anonymous

                        ],
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
