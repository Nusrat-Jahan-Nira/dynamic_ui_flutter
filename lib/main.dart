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
import 'dynamic_ui/views/ui_view.dart';
import 'dynamic_ui_from_configuration_web/dynamic_form_screen.dart';
import 'dynamic_ui_from_configuration_web/registration_page.dart';
import 'firebase_dynamic_ui/view/firebase_dynamic_view.dart';
import 'payoneer/views/payoneer_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        //GetPage(name: '/', page: () => HomePage()), // Your home page
        GetPage(name: '/RegistrationPage', page: () => const RegistrationPage()), // Register the RegistrationPage route
        // Add more routes as needed
      ],
      title: 'Flutter API Example',
      theme: ThemeData(
        primarySwatch: Colors.green, // Change this to your desired primary color
        hintColor: Colors.greenAccent, // Change this to your desired accent color
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.green, // Default button color
        ),
        // Customize other theme properties as needed
      ),
      //home: const UIView(),
     // home: PayoneerView(),
      home: DynamicFormScreen(),
    );
  }
}
