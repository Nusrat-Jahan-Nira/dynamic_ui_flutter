// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'login_controller.dart';
//
// class LoginScreen extends StatelessWidget {
//   final Map<String, dynamic> jsonResponse = {
//     "widgets": [
//       {"type": "Text", "data": "Login"},
//       {"type": "TextField", "hint": "Enter Username"},
//       {"type": "TextField", "hint": "Enter Password", "obscureText": true},
//       {"type": "Button", "data": "Login"}
//     ]
//   };
//
//   LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // LoginController will handle state management for username and password
//     final LoginController loginController = Get.put(LoginController());
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Dynamic Login UI with GetX'),
//       backgroundColor:  Colors.blue,),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: DynamicWidgetBuilder.buildWidgets(
//               jsonResponse['widgets'],
//               loginController,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // DynamicWidgetBuilder for building widgets based on JSON data
// class DynamicWidgetBuilder {
//   static Widget buildWidget(
//       Map<String, dynamic> widgetData, LoginController controller) {
//     switch (widgetData['type']) {
//       case 'Text':
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             widgetData['data'],
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//         );
//       case 'TextField':
//         bool obscureText = widgetData['obscureText'] ?? false;
//         String hint = widgetData['hint'];
//
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: TextField(
//             obscureText: obscureText,
//             decoration: InputDecoration(
//               border: const OutlineInputBorder(),
//               labelText: hint,
//             ),
//             onChanged: (value) {
//               if (hint == "Enter Username") {
//                 controller.username.value = value;
//               } else if (hint == "Enter Password") {
//                 controller.password.value = value;
//               }
//             },
//           ),
//         );
//       case 'Button':
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             onPressed: () {
//               controller.login(); // Call the login method from controller
//             },
//             child: Text(widgetData['data']),
//           ),
//         );
//       default:
//         return const SizedBox.shrink(); // For unsupported widget types
//     }
//   }
//
//   // Build a list of widgets from JSON array
//   static List<Widget> buildWidgets(
//       List<dynamic> widgetsData, LoginController controller) {
//     return widgetsData
//         .map((widgetData) => buildWidget(widgetData, controller))
//         .toList();
//   }
// }