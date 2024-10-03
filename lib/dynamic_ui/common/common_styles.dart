// lib/common/common_styles.dart

import 'package:flutter/material.dart';

class CommonStyles {
  static const EdgeInsets commonPadding = EdgeInsets.all(8.0);

  static const TextStyle labelTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.blue
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    backgroundColor: Colors.blue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
