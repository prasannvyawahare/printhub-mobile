import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/bottom_navigation_bar.dart';
import 'package:flutter_application_1/screens/order_details_screen.dart';
import 'package:flutter_application_1/screens/order_tracking_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import '../common_widget/print_hub_gradient_button.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/onbording_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/otp_verification_screen.dart';
import 'package:flutter_application_1/screens/home_details_screen.dart';
import 'package:flutter_application_1/screens/delivery_screen.dart';
import 'package:flutter_application_1/screens/order_success_screen.dart';
import 'firebase_options.dart';

void main() async {
  //await GetStorage.init(); // Important: Initialize storage
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:  FirebaseOptions(
      apiKey: 'AIzaSyAEHYlWExshSNkwBnoRkPHT6bhAJHgiQaA',
      appId: '1:260121636763:web:3a2ece312d2b266bc17b3e',
      messagingSenderId: '260121636763',
      projectId: 'printhub-92a6b',
      authDomain: 'printhub-92a6b.firebaseapp.com',
      storageBucket: 'printhub-92a6b.firebasestorage.app',
      measurementId: 'G-1WK7GSV9S2',
    )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Print Hub',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


