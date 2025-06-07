import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:petscare/app_screens/mainscreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:petscare/app_screens/mainscreen.dart';
import 'package:petscare/logoscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Mainscreen(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Add a simple loading screen
          }
          return snapshot.hasData ? const Mainscreen() : const Logoscreen();
        },
      ),
    );
  }
}
