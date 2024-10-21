import 'package:dynamic_ui_flutter/dynamic_ui_from_configuration_web/form_element.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dynamic_ui/common/common_widgets.dart';
import '../dynamic_ui/services/api_service.dart';
import 'form_controller.dart';

class DynamicFormScreen extends StatelessWidget {
  final FormController controller = Get.put(FormController(apiService: ApiService()));
  DynamicFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Dynamic Form'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.formElements.isEmpty) {
            return const Center(child: Text('No components found'));
          }

          return ListView.builder(
              itemCount: controller.formElements.length,
              itemBuilder: (context, index) {
                return _buildComponent(controller.formElements[index]);
              },
            );
        }),

      ),
    );
  }

  Widget _buildComponent(FormElement component) {
    InputDecoration inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5), // Padding inside
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.teal.shade200), // Border color
      ),
      filled: true,
      fillColor: Colors.grey.shade100, // Background color
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Builder(
          builder: (context) {
            String? componentType = component.attributes['Type'];
            debugPrint("componentType : $componentType");
            switch (componentType) {
              case 'Text':
                return Center(
                  child: Text(
                    component.attributes['Label'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                );
              case 'EditText':
              // Extracting the data from componentData
                String label = component.attributes['Label'] ?? 'Label';
                String placeholder = component.attributes['Placeholder'] ?? 'Enter text here';
                bool isRequired = (component.attributes['Required'] == 'Yes') ? true : false;
                String validationMsg = component.attributes['ValidationMsg'] ?? 'This field is required';
                String value = component.attributes['Value'] ?? '';
                return TextFormField(
                  readOnly: false, // Set to true if it's a read-only field
                  initialValue: value, // Pre-filled value if available
                  decoration: inputDecoration.copyWith(
                    labelText: label, // Display label inside the TextFormField
                    hintText: placeholder, // Placeholder when the field is empty
                  ),
                  validator: (text) {
                    // Perform validation if required
                    if (isRequired && (text == null || text.isEmpty)) {
                      return validationMsg; // Show validation message if empty
                    }
                    return null; // No validation error
                  },
                );
              case 'Dropdown':
              // Extracting the data from componentData
                String label = component.attributes['Label'] ?? 'Select Item'; // Default label if null
                dynamic itemsData = component.attributes['Items'];
                List<String> items = (itemsData is String)
                    ? itemsData.split(',').map((item) => item.trim()).toList() // Split string by commas
                    : (itemsData is List<String>) ? List<String>.from(itemsData) : []; // Ensure it's a list, or set as empty
                if (!items.contains(label)) {
                  items.insert(0, label); // Insert the label at the beginning of the list
                }

                String requiredString = component.attributes['Required'] ?? 'No';
                bool isRequired = (requiredString == 'Yes') ? true : false;  // Convert "Yes" or "No" to bool
                String validationMsg = component.attributes['ValidationMsg'] ?? 'This field is required'; // Validation message
                dynamic selectedItem = component.attributes['SelectedItem'] ;

                if (!items.contains(selectedItem)) {
                  // If selectedItem is not in the items list, set to the first item or handle as needed
                  selectedItem = items.isNotEmpty ? items[0] : null; // Default to first item if available, or null
                }
                // The currently selected item
                //dynamic value = componentData['Value']; // Default selected value

                // Map the dropdown items to DropdownMenuItem widgets
                List<DropdownMenuItem<dynamic>> dropdownItems = items.map((item) {
                  return DropdownMenuItem(
                    value: item, // Value of the item (can be the item string itself)
                    child: Text(item), // Display label of the item
                  );
                }).toList();
                return DropdownButtonFormField(
                  value: selectedItem, // Initial selected value
                  decoration: InputDecoration(
                    labelText: label, // Display the label
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: dropdownItems.isNotEmpty ? dropdownItems : null, // Use items only if not empty
                  onChanged: (newValue) {
                    selectedItem = newValue; // Update the selected item
                  },
                  validator: (selectedValue) {
                    // Perform validation if required
                    if (isRequired && (selectedValue == null || selectedValue.toString().isEmpty)) {
                      return validationMsg; // Show validation message if no item is selected
                    }
                    return null; // No validation error
                  },
                  hint: const Text('Select an item'), // Placeholder when no item is selected
                );
              case 'Checkbox':
              // Extract values from componentData
                String label = component.attributes['Label'] ?? 'Checkbox'; // Default label if not provided
                bool checkboxValue = component.attributes['Value'] == 'True'?true : false; // Default to false if not provided

                return Row(
                  children: [
                    Checkbox(
                      value: checkboxValue, // Bind the value of the checkbox
                      onChanged: (value) {
                        // Update the state here (if using state management)
                        // For example, using GetX:
                        // componentController.updateCheckboxValue(value);
                      },
                    ),
                    Expanded( // Use Expanded to allow text to occupy available space
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal[800],
                        ),
                      ),
                    ),
                  ],
                );
              case 'Radio':
                return CommonWidgets.radio(
                  label: component.getAttribute('Label'),
                  groupValue: component.getAttribute('Label') ?? '',
                  options: component.getAttribute('Items'),
                  onChanged: (value) =>
                      controller.updateValue(component.getAttribute('Label'), value!),
                );
              case 'Button':
              // Extract values from componentData
                String buttonLabel = component.attributes['Label'] ?? 'Button Widget'; // Default label if not provided
                bool isEnabled = component.attributes['Required'] == 'Yes' || component.attributes['Required'] == true; // Check for string "Yes" or boolean true
                String actionType = component.attributes['ActionType'];
                String url = component.attributes['Url']; // URL can be used for navigation or actions
                String method = component.attributes['Method'] ?? ''; // The method can be an action name
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: isEnabled
                        ? () {

                      if(actionType == "Navigation"){
                        debugPrint(url);
                        Get.toNamed(url);
                      } else{
                        if (method.isEmpty) {
                          debugPrint('Executing method: $method');
                        }
                        else if (url.isEmpty) {
                          debugPrint('Executing url: $url');
                        }
                        else{
                          debugPrint("url method : $url $method");
                          controller.fetchComponents(url,method);
                        }
                      }


                    }
                        : null, // If not enabled, the button will be disabled
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(buttonLabel), // Use the label from componentData
                  ),
                );
              case 'Radio Button':
              // Extract values from componentData
                String title = component.attributes['Label'] ?? 'Radio Button Title'; // Default title if not provided
                int selectedValue = component.attributes['SelectedValue'] ?? 0; // Default selected value
                dynamic itemsData = component.attributes['Items'];

                List<String> radioOptions = (itemsData is String)
                    ? itemsData.split(',').map((item) => item.trim()).toList() // Split string by commas
                    : (itemsData is List<String>) ? List<String>.from(itemsData) : [];

                // Check if the selected value is valid, if not set it to the first item's index
                if (selectedValue < 0 || selectedValue >= radioOptions.length) {
                  selectedValue = 0; // Default to the first option
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align title to the start
                  children: [
                    Text(
                      title, // Use the title from componentData
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                      ),
                    ),
                    const SizedBox(height: 8), // Space between title and radio buttons
                    Column( // Use Column to stack radio buttons vertically
                      children: radioOptions.asMap().entries.map((entry) {
                        int index = entry.key;
                        String option = entry.value;

                        return Row(
                          children: [
                            Radio<int>(
                              value: index, // Assign the index as the value
                              groupValue: selectedValue, // Control which radio is selected
                              onChanged: (value) {
                                // Handle the value change here
                                // Update the selected value in your state management
                                // For example:
                                // setState(() {
                                //   selectedValue = value!;
                                // });
                              },
                            ),
                            Text(option), // Display the option text
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }


}
