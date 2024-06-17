import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:todo_app/home_screen.dart';
import 'package:todo_app/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}
