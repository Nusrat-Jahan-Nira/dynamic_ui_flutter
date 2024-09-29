// import 'package:flutter/material.dart';
//
// class DynamicUiScreen extends StatefulWidget {
//   const DynamicUiScreen({super.key});
//
//   @override
//   _DynamicUiScreenState createState() => _DynamicUiScreenState();
// }
//
// class _DynamicUiScreenState extends State<DynamicUiScreen> {
//   // Simulated JSON response
//   final Map<String, dynamic> jsonResponse = {
//     "widgets": [
//       {"type": "Image", "data": "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"},
//       {"type": "Text", "data": "Hello, World!"},
//       {"type": "Text", "data": "Hello,!"},
//       {"type": "Button", "data": "Click Me"},
//       {"type": "Button", "data": "Click"},
//       //{"type": "Image", "data": "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"}
//     ]
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dynamic UI'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: DynamicWidgetBuilder.buildWidgets(jsonResponse['widgets']),
//         ),
//       ),
//     );
//   }
// }
//
// class DynamicWidgetBuilder {
//   // Build widget based on type
//   static Widget buildWidget(Map<String, dynamic> widgetData) {
//     switch (widgetData['type']) {
//       case 'Text':
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(widgetData['data'], style: const TextStyle(fontSize: 18)),
//         );
//       case 'Button':
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             onPressed: () {
//               print("${widgetData['data']} button pressed");
//             },
//             child: Text(widgetData['data']),
//           ),
//         );
//       case 'Image':
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.network(widgetData['data']),
//         );
//       default:
//         return const SizedBox.shrink(); // Empty for unsupported widget types
//     }
//   }
//
//   // Build list of widgets from JSON array
//   static List<Widget> buildWidgets(List<dynamic> widgetsData) {
//     return widgetsData.map((widgetData) => buildWidget(widgetData)).toList();
//   }
// }
