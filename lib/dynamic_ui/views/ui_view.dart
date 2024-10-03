// lib/views/ui_view.dart

import 'package:dynamic_ui_flutter/dynamic_ui/model/ui_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/common_widgets.dart';
import '../controllers/ui_controller.dart';
import '../services/api_service.dart';

class UIView extends StatefulWidget {
  const UIView({super.key});

  @override
  State<UIView> createState() => _UIViewState();
}

class _UIViewState extends State<UIView> {
  final UIController controller = Get.put(UIController(apiService: ApiService()));

  @override
  void initState() {
    super.initState();
    controller.fetchComponents('registration-form');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic UI'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.components.isEmpty) {
            return const Center(child: Text('No components found'));
          }

          return ListView.builder(
            itemCount: controller.components.length,
            itemBuilder: (context, index) {
              return _buildComponent(controller.components[index]);
            },
          );
        }),
      ),
    );
  }

  Widget _buildComponent(UIComponent component) {

    return SizedBox(
        width: double.infinity, // Ensures the widget takes full width
        child: Builder(
        builder: (context)
    {
      switch (component.type) {
        case 'text':
        case 'password':
          return CommonWidgets.textField(
            label: component.label,
            hintText: component.placeholder ?? '',
            obscureText: component.type == 'password',
            onChanged: (value) =>
                controller.updateInput(component.label, value),
          );
        case 'dropdown':
          return CommonWidgets.dropdown(
            label: component.label,
            selectedItem: controller.formData[component.label] ??
                component.options![0],
            items: component.options!,
            onChanged: (newValue) {
              if (newValue != null) controller.updateInput(
                  component.label, newValue);
            },
          );
        case 'radio':
          return CommonWidgets.radio(
            label: component.label,
            groupValue: controller.formData[component.label] ?? '',
            options: ['Male', 'Female', 'Other'],
            onChanged: (value) =>
                controller.updateInput(component.label, value!),
          );
        case 'switch':
          return CommonWidgets.switchWidget(
            label: component.label,
            value: controller.formData[component.label] ?? false,
            onChanged: (value) =>
                controller.updateInput(component.label, value),
          );
        case 'elevated_button':
          return CommonWidgets.elevatedButton(
            label: component.label,
            onPressed: () async {
              final inputData = {
                for (var entry in controller.formData.entries)
                  entry.key: entry.value is Rx ? entry.value.value : entry
                      .value,
              };
              await controller.handleAction(component, inputData);
            },
          );
        default:
          return const SizedBox.shrink();
      }
    })
    );

  }
}
