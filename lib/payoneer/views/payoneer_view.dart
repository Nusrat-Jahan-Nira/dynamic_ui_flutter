// import 'package:dynamic_ui_flutter/dynamic_ui/services/api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controller/ui_component_controller.dart';
// import '../model/ui_component.dart';
//
// class PayoneerView extends StatelessWidget {
//   final UIComponentController controller = Get.put(UIComponentController(apiService: ApiService()));
//   PayoneerView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dynamic Form'),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           return ListView.builder(
//             itemCount: controller.components.length,
//             itemBuilder: (context, index) {
//               final component = controller.components[index];
//               debugPrint("get components : $component");
//               return _buildComponent(component);
//             },
//           );
//         }
//       }),
//     );
//   }
//
//   Widget _buildComponent(UIComponent component) {
//     switch (component.type) {
//       case 'Label':
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text("${component.label}: ${component.value ?? ""}"),
//         );
//       case 'TextField':
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             decoration: InputDecoration(
//               labelText: component.label,
//               hintText: component.placeholder,
//             ),
//           ),
//         );
//       case 'Checkbox':
//         bool isChecked = component.value == "true";
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Checkbox(
//                 value: isChecked,
//                 onChanged: (bool? value) {
//                   isChecked = value ?? false;
//                 },
//               ),
//               Text(component.label),
//             ],
//           ),
//         );
//       case 'Button':
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             onPressed: () {
//               if (component.actionDetails != null) {
//                 // Handle button action
//                 _handleButtonAction(component.actionDetails!);
//               }
//             },
//             child: Text(component.label),
//           ),
//         );
//       default:
//         return Container();
//     }
//   }
//
//   void _handleButtonAction(ActionDetails actionDetails) {
//     // Here, you can perform the action like sending a POST request
//     // based on actionDetails.url and actionDetails.method.
//     Get.snackbar(
//       'Action',
//       actionDetails.successMessage,
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
// }
import 'package:dynamic_ui_flutter/dynamic_ui/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ui_component_controller.dart';
import '../model/ui_component.dart';

class PayoneerView extends StatelessWidget {
  final UIComponentController controller = Get.put(UIComponentController(apiService: ApiService()));

  PayoneerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Payoneer Form',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if(controller.components.isEmpty){
          return const Center(child: Text('No Components Found!'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: controller.components.length,
              itemBuilder: (context, index) {
                final component = controller.components[index];
                //debugPrint("get components : $component");
                return _buildComponent(component);
              },
            ),
          );
        }
      }),
    );
  }

  Widget _buildComponent(UIComponent component) {

    if (component.type == 'Card') {
      return Card(
        elevation: 5,
        color: Colors.white60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),

        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: component.children!.map((childComponent) => Column(
              children: [
                _buildComponent(childComponent),
                const Divider(),
              ],
            )).toList(), // Recursively build child components
          ),
        ),
      );
    }

    // Check the component type and add it to the list
    switch (component.type) {
      case 'Label':
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${component.label}: ", // Added colon after the label
                style: const TextStyle(
                    fontSize: 16.0,),
              ),
              Text(
                component.value ?? "",
                style: TextStyle(
                    fontWeight: component.type == 'Card'? FontWeight.bold: FontWeight.normal,
                    fontSize: 16.0),
              ),
            ],
          ),
        );

      case 'TextField':
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: component.label,
              hintText: component.placeholder,
              labelStyle: const TextStyle(
                  fontSize: 14.0
              ),
              hintStyle: const TextStyle(
                  fontSize: 14.0
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: const EdgeInsets.all(16.0), // Default padding if not provided
            ),

          ),
        );

      case 'Checkbox':
        bool isChecked = component.value == "true";
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  isChecked = value ?? false;
                },
              ),
              Text(component.label.toString()),
            ],
          ),
        );

      case 'Button':
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style:ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              foregroundColor: Colors.black,
              ),
            onPressed: () {
              if (component.actionDetails != null) {
                // Handle button action
                _handleButtonAction(component.actionDetails!);
              }
            },
            child: Text(component.label.toString()),
          ),
        );

      default:
        return Container();
    }
  }

  void _handleButtonAction(ActionDetails actionDetails) {
    // Here, you can perform the action like sending a POST request
    // based on actionDetails.url and actionDetails.method.
    Get.snackbar(
      'Action',
      actionDetails.successMessage,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
