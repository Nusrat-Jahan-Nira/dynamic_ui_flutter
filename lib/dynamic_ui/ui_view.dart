// lib/views/ui_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_service.dart';
import 'ui_component.dart';
import 'ui_controller.dart';

class UIView extends StatefulWidget {

  const UIView({super.key});

  @override
  State<UIView> createState() => _UIViewState();
}

class _UIViewState extends State<UIView> {
  final UIController controller = Get.put(UIController(apiService: ApiService()));

  @override
  void initState() {
    // TODO: implement initState
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
            return const Center(child: Text('No components found')); // Show message if no components
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
    switch (component.type) {
      case 'text':
      case 'password':
        return _buildTextField(component);
      case 'dropdown':
        return _buildDropdown(component);
      case 'radio':
        return _buildRadio(component);
      case 'checkbox':
        return _buildCheckbox(component);
      case 'switch':
        return _buildSwitch(component);
      case 'text_button':
        return _buildTextButton(component);
      case 'elevated_button':
        return _buildElevatedButton(component);
      default:
        return const SizedBox.shrink(); // Return an empty box for unhandled types
    }
  }

  Widget _buildTextField(UIComponent component) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: component.label,
            hintText: component.placeholder,
          ),
          obscureText: component.type == 'password',
          onChanged: (value) {
            controller.updateInput(component.label, value);
          },
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }

  Widget _buildRadio(UIComponent component) {
    return Column(
      children: [
        Text(component.label),
        Row(
          children: ['Male', 'Female', 'Other'].map((gender) {
            return Row(
              children: [
                Obx(() => Radio<String>(
                  value: gender,
                  groupValue: controller.formData[component.label] ?? '',
                  onChanged: (value) {
                    // Update the value in formData based on the radio button's label
                    controller.updateInput(component.label, value!);
                  },
                )),
                Text(gender),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

// Method to build a Dropdown (for 'dropdown' type)
  Widget _buildDropdown(UIComponent component) {
    List<String> dropdownItems = component.options ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(component.label),
        Obx(() => DropdownButton<String>(
          value: controller.formData[component.label] ?? dropdownItems[0],
          items: dropdownItems.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              controller.updateInput(component.label, newValue);
            }
          },
        )),
        const SizedBox(height: 5.0),
      ],
    );
  }

  Widget _buildCheckbox(UIComponent component) {
    return Row(
      children: [
        Obx(() => Checkbox(
          value: controller.formData[component.label] ?? false,
          onChanged: (value) {
            if (value != null) {
              // Update the value in formData based on the checkbox's label
              controller.updateInput(component.label, value);
            }
          },
        )),
        Text(component.label),
      ],
    );
  }


  Widget _buildSwitch(UIComponent component) {
    return Row(
      children: [
        Obx(() => Switch(
          value: controller.formData[component.label] ?? false,
          onChanged: (value) {
            // Update the value in formData based on the switch's label
            controller.updateInput(component.label, value);
          },
        )),
        Text(component.label),
      ],
    );
  }


  Widget _buildTextButton(UIComponent component) {
    return TextButton(
      onPressed: () async {
        //Get.toNamed(component.actionDetails!.url);
        final inputData = {
          for (var entry in controller.formData.entries)
            entry.key: entry.value is Rx ? entry.value.value : entry.value,
        };

        // Pass the inputData to the handleAction method
        await controller.handleAction(component, inputData);
      },
      child: Text(component.label),
    );
  }

  Widget _buildElevatedButton(UIComponent component) {
    return Column(
      children: [
        const SizedBox(height: 5.0),
        ElevatedButton(
          onPressed: () async {
            // Use the formData map to collect all input values
            final inputData = {
              for (var entry in controller.formData.entries)
                entry.key: entry.value is Rx ? entry.value.value : entry.value,
            };

            // Pass the inputData to the handleAction method
            await controller.handleAction(component, inputData);
          },
          child: Text(component.label),
        ),
      ],
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Dynamic UI'),backgroundColor:  Colors.blue,),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Obx(() {
//           if (controller.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           return ListView.builder(
//             itemCount: controller.components.length,
//             itemBuilder: (context, index) {
//               final component = controller.components[index];
//
//               if (component.type == 'text') {
//                 return Column(
//                   children: [
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: component.label,
//                         hintText: component.placeholder,
//                       ),
//                       onChanged: (value) {
//                         // Store user input for action
//                         // This could be a map or list based on your requirement
//                       },
//                     ),
//                     const SizedBox(height: 5.0,),
//                   ],
//                 );
//               } else if (component.type == 'button') {
//                 return Column(
//                   children: [
//                     const SizedBox(height: 5.0,),
//                     ElevatedButton(
//                       onPressed: () async {
//                         // Assume you have collected the input data for this example
//                         final inputData = {
//                           'userId': 'admin', // Replace with actual input
//                           'pass': '1234', // Replace with actual input
//                         };
//                         await controller.handleAction(component, inputData);
//                       },
//                       child: Text(component.label),
//                     ),
//                   ],
//                 );
//               }
//
//               return const SizedBox.shrink(); // Return an empty box for unhandled types
//             },
//           );
//         }),
//       ),
//     );
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Dynamic UI'), backgroundColor: Colors.blue),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Obx(() {
//           if (controller.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           return ListView.builder(
//             itemCount: controller.components.length,
//             itemBuilder: (context, index) {
//               final component = controller.components[index];
//
//               if (component.type == 'text' || component.type == 'password') {
//                 return Column(
//                   children: [
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: component.label,
//                         hintText: component.placeholder,
//                       ),
//                       obscureText: component.type == 'password',
//                       onChanged: (value) {
//                         // Store user input for action
//                         controller.updateInput(component.label, value);
//                       },
//                     ),
//                     const SizedBox(height: 5.0),
//                   ],
//                 );
//               } else if (component.type == 'radio') {
//                 return Column(
//                   children: [
//                     Text(component.label),
//                     Row(
//                       children: ['Male', 'Female', 'Other'].map((gender) {
//                         return Row(
//                           children: [
//                             Radio<String>(
//                               value: gender,
//                               groupValue: controller.selectedGender.value,
//                               onChanged: (value) {
//                                 controller.selectedGender.value = value!;
//                               },
//                             ),
//                             Text(gender),
//                           ],
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 );
//               } else if (component.type == 'checkbox') {
//                 return Row(
//                   children: [
//                     Checkbox(
//                       value: controller.acceptTerms.value,
//                       onChanged: (value) {
//                         controller.acceptTerms.value = value!;
//                       },
//                     ),
//                     Text(component.label),
//                   ],
//                 );
//               } else if (component.type == 'switch') {
//                 return Row(
//                   children: [
//                     Switch(
//                       value: controller.subscribeToNewsletter.value,
//                       onChanged: (value) {
//                         controller.subscribeToNewsletter.value = value;
//                       },
//                     ),
//                     Text(component.label),
//                   ],
//                 );
//               } else if (component.type == 'text_button') {
//                 return TextButton(
//                   onPressed: () {
//                     Get.toNamed(component.actionDetails!.url!);
//                   },
//                   child: Text(component.label),
//                 );
//               } else if (component.type == 'elevated_button') {
//                 return Column(
//                   children: [
//                     const SizedBox(height: 5.0),
//                     ElevatedButton(
//                       onPressed: () async {
//                         final inputData = {
//                           'username': controller.username.value,
//                           'password': controller.password.value,
//                           'gender': controller.selectedGender.value,
//                           'termsAccepted': controller.acceptTerms.value,
//                           'newsletterSubscribed': controller.subscribeToNewsletter.value,
//                         };
//                         await controller.handleAction(component, inputData);
//                       },
//                       child: Text(component.label),
//                     ),
//                   ],
//                 );
//               }
//
//               return const SizedBox.shrink(); // Return an empty box for unhandled types
//             },
//           );
//         }),
//       ),
//     );
//   }
// }