import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/providers/user_provider.dart';
import 'package:firebase_testing/responsive/mobile_screen_layout.dart';
import 'package:firebase_testing/responsive/responsive_layout_screen.dart';
import 'package:firebase_testing/responsive/web_screen_layout.dart';
import 'package:firebase_testing/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_testing/services/local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colours.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // to initialize firebase
  await LocalNotificationsService.init(); // to initialize local Notifications


  // Check whether the WEB app or Mobile app run
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBWqe6vziwfRcXCfSD6BLwAKixTO80vITY",
          authDomain: "authfirebase-aa9b3.firebaseapp.com",
          projectId: "authfirebase-aa9b3",
          storageBucket: "authfirebase-aa9b3.appspot.com",
          messagingSenderId: "845883872520",
          appId: "1:845883872520:web:0de2aacfdb608e9fa448bd"),
    );
  }else{
    await Firebase.initializeApp();  // to initialize firebase
  }
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
              );
            }

            return Wrapper();
          },
        ),
      ),
    );
  }
}

// ResponsiveLayout(
// mobileScreenLayout: MobileScreenLayout(),
// webScreenLayout: WebScreenLayout(),
// ),
