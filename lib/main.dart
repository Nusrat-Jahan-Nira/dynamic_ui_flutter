// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'login.dart';
// import 'login_screen.dart';
//
// void main() {
//   runApp( const MyApp());
// }
//
// // Main Application
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Dynamic Login UI with GetX',
//       home: LoginScreen(),
//     );
//   }
// }
//
// lib/main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dynamic_ui/ui_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter API Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UIView(),
    );
  }
}
