// lib/common/common_widgets.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/common_styles.dart';

class CommonWidgets {
  static Widget textField({
    required String label,
    required String hintText,
    required bool? obscureText,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: CommonStyles.labelTextStyle),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
          ),
          obscureText: obscureText?? false,
          onChanged: onChanged,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  static Widget dropdown({
    required String label,
    required String selectedItem,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: CommonStyles.labelTextStyle),
        DropdownButton<String>(
          value: selectedItem,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  static Widget elevatedButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: CommonStyles.elevatedButtonStyle,
      child: Text(label, style: CommonStyles.buttonTextStyle),
    );
  }

  static Widget radio({
    required String label,
    required String groupValue,
    required List<String> options,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: CommonStyles.labelTextStyle),
        Row(
          children: options.map((option) {
            return Row(
              children: [
                Radio<String>(
                  value: option,
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  static Widget switchWidget({
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Switch(value: value, onChanged: onChanged),
        Text(label, style: CommonStyles.labelTextStyle),
      ],
    );
  }
}
