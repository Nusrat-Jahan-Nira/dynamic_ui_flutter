// import 'package:flutter/material.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   // Simulated JSON response for the login form
//   // final Map<String, dynamic> jsonResponse = {
//   //   "widgets": [
//   //     {"type": "Text", "data": "Login"},
//   //     {"type": "TextField", "hint": "Enter Username"},
//   //     {"type": "TextField", "hint": "Enter User Full Name"},
//   //     {"type": "TextField", "hint": "Enter Password", "obscureText": true},
//   //     {"type": "Button", "data": "Login"}
//   //   ]
//   // };
//
//   final Map<String, dynamic> jsonResponse = {
//     "widgets": [
//       {"type": "Text", "data": "Registration"},
//       {"type": "TextField", "hint": "Enter Username"},
//       {"type": "TextField", "hint": "Enter User Full Name"},
//       {"type": "TextField", "hint": "Enter Password", "obscureText": true},
//       {"type": "Button", "data": "Login"}
//     ]
//   };
//
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dynamic Login UI'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: DynamicWidgetBuilder.buildWidgets(
//               jsonResponse['widgets'],
//               _usernameController,
//               _passwordController,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DynamicWidgetBuilder {
//   // Build widget based on type
//   static Widget buildWidget(Map<String, dynamic> widgetData,
//       [TextEditingController? usernameController,
//         TextEditingController? passwordController]) {
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
//         TextEditingController? controller;
//         if (widgetData['hint'] == 'Enter Username') {
//           controller = usernameController;
//         } else if (widgetData['hint'] == 'Enter Password') {
//           controller = passwordController;
//         }
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: TextField(
//             controller: controller,
//             obscureText: obscureText,
//             decoration: InputDecoration(
//               border: const OutlineInputBorder(),
//               labelText: widgetData['hint'],
//             ),
//           ),
//         );
//       case 'Button':
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             onPressed: () {
//               print("Login Button Pressed");
//               print("Username: ${usernameController?.text}");
//               print("Password: ${passwordController?.text}");
//             },
//             child: Text(widgetData['data']),
//           ),
//         );
//       default:
//         return const SizedBox.shrink(); // Empty widget for unsupported types
//     }
//   }
//
//   // Build list of widgets from JSON array
//   static List<Widget> buildWidgets(
//       List<dynamic> widgetsData,
//       TextEditingController usernameController,
//       TextEditingController passwordController) {
//     return widgetsData
//         .map((widgetData) =>
//         buildWidget(widgetData, usernameController, passwordController))
//         .toList();
//   }
// }