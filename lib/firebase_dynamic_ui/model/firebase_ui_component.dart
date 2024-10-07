import 'package:flutter/material.dart';

import '../components/firebase_component.dart';

// Base class for all UI components
abstract class FirebaseUiComponent {
  final Map<String, dynamic> properties;

  FirebaseUiComponent({required this.properties});

  factory FirebaseUiComponent.fromJson(Map<String, dynamic> json) {
    switch (json['Type'] ?? json['type']) {
      case 'Text':
        return FirebaseText(properties: json);
      case 'TextView':
        return FirebaseTextView(properties: json);
      case 'Button':
        return FirebaseButton(properties: json);
      default:
        throw Exception('Unknown component type');
    }
  }

  Widget build(BuildContext context);
}
