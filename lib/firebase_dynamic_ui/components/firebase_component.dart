// Component for a simple text label
import 'package:flutter/material.dart';

import '../model/firebase_ui_component.dart';

class FirebaseText extends FirebaseUiComponent {
  FirebaseText({required super.properties});

  @override
  Widget build(BuildContext context) {
    return Text(
      properties['Label'],
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

// Component for a text input field
class FirebaseTextView extends FirebaseUiComponent {
  FirebaseTextView({required super.properties});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: properties['Label'],
        hintText: properties['Placeholder'],
      ),
    );
  }
}

// Component for buttons
class FirebaseButton extends FirebaseUiComponent {
  FirebaseButton({required super.properties});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.black
      ),
      onPressed: () {
        // Handle button action based on properties
        String method = properties['Method'] ?? '';
        String url = properties['Url'] ?? '';
        if (method.isNotEmpty) {
          // Implement your action logic here
          debugPrint('Method: $method, URL: $url');
        } else {
          // Default action
          debugPrint('Button pressed: ${properties['Label']}');
        }
      },
      child: Text(properties['Label']),
    );
  }
}