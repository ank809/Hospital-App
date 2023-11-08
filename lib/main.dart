import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/controllers/auth.dart';
import 'package:hospital_app/firebase_options.dart';
import 'package:hospital_app/views/authentication/login.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) =>  Get.put(Auth()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}