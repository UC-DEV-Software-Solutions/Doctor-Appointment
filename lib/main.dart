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
  // Check whether the WEB app or Mobile app run
  if (kIsWeb) {
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBWqe6vziwfRcXCfSD6BLwAKixTO80vITY",
            authDomain: "authfirebase-aa9b3.firebaseapp.com",
            projectId: "authfirebase-aa9b3",
            storageBucket: "authfirebase-aa9b3.appspot.com",
            messagingSenderId: "845883872520",
            appId: "1:845883872520:web:0de2aacfdb608e9fa448bd"),
      );
    } catch (e, st) {
      // Show initialization error immediately
      print('Firebase initializeApp (web) failed: $e');
      runApp(MaterialApp(
          home:
              Scaffold(body: Center(child: Text('Firebase init error: $e')))));
      return;
    }
  } else {
    try {
      await Firebase.initializeApp(); // to initialize firebase
    } catch (e, st) {
      print('Firebase initializeApp (iOS) failed: $e');
      runApp(MaterialApp(
          home: Scaffold(body: FirebaseInitErrorScreen(error: e.toString()))));
      return;
    }
  }
  // Initialize local notifications after Firebase is ready
  await LocalNotificationsService.init(); // to initialize local Notifications
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: false);
  runApp(const MyApp());
}

class FirebaseInitErrorScreen extends StatelessWidget {
  final String error;
  const FirebaseInitErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase initialization failed')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Error: $error', style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              const Text('Fix steps:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                  '- Download the GoogleService-Info.plist for your iOS app from the Firebase console.'),
              const Text(
                  '- Put the file into ios/Runner and add it to the Runner target in Xcode (check "Copy items if needed").'),
              const Text('- Run the following commands in the project root:'),
              const SizedBox(height: 8),
              const Text('  cd ios'),
              const Text('  pod install'),
              const Text('  cd ..'),
              const Text('  flutter clean'),
              const Text('  flutter pub get'),
              const Text('  flutter run -d <device-id>'),
              const SizedBox(height: 12),
              const Text(
                  'If you prefer a temporary testing workaround, I can add an explicit iOS FirebaseOptions fallback into code (not recommended for production).'),
            ],
          ),
        ),
      ),
    );
  }
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
