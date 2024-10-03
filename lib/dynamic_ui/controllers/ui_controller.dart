import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/api_service.dart';
import '../model/ui_component.dart';

class UIController extends GetxController {
  var components = <UIComponent>[].obs; // List of UI components
  var isLoading = false.obs;

  // New variables for form data
  var formData = <String, dynamic>{}.obs; // Store dynamic form data

  static const String baseUrl = 'http://192.168.88.50:8080';
  final ApiService apiService;

  UIController({required this.apiService});

  // Future<void> fetchComponents(String urlEndPoint) async {
  //   try {
  //     isLoading.value = true;
  //     String apiUrl = '$baseUrl/$urlEndPoint';
  //     final response = await apiService.makeApiCall(apiUrl, 'GET');
  //     if (response.isNotEmpty) {
  //       final componentList = (response as List)
  //           .map((item) => UIComponent.fromJson(item))
  //           .toList();
  //       components.value = componentList;
  //     } else {
  //       debugPrint('Error fetching components');
  //     }
  //   } catch (e) {
  //     debugPrint('Error fetching components: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> fetchComponents(String urlEndPoint) async {
    try {
      String apiUrl = '$baseUrl/$urlEndPoint';
      final response = await apiService.makeApiCall(apiUrl, 'GET');

      if (response.isNotEmpty) {
        // Check if the response is a Map or List
        if (response is Map<String, dynamic>) {
          // Handle the case where response is a map
          final values = LoginResponseModel.fromJson(response);
          if (values.statusCode == "0") {
            // Assuming components are in response['components']
            if (response['components'] is List) {
              components.clear();
              formData.clear();
              components.value = (response['components'] as List)
                  .map((item) => UIComponent.fromJson(item))
                  .toList();
            } else {
              debugPrint('Components are not in the expected List format');
            }
          }
          else {
            debugPrint('Error fetching components: ${values.statusMessage}');
          }
        } else {
          debugPrint('Unexpected response format: ${response.runtimeType}');
        }
      }
    } catch (e) {
      debugPrint('Error fetching components: $e');
    }
  }
  void updateInput(String label, dynamic value) {
    formData[label] = value; // Update formData with the value
  }
  void showCustomSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      isDismissible: true,
    );
  }

  Future<void> handleAction(UIComponent component, Map<String, dynamic> inputData) async {
    try {
      isLoading.value = true;
      final response = await apiService.makeApiCall(
        '$baseUrl${component.actionDetails!.url}',
        component.actionDetails!.method,
        body: inputData,
      );
      if (response != null) {
        final values = LoginResponseModel.fromJson(response);
        if (values.statusCode == "0") {
          debugPrint("Success");
          showCustomSnackbar('Success', values.statusMessage ?? "");
          if(values.components!.isNotEmpty){
            components.clear();
            formData.clear();
            if (response['components'] is List) {
              components.value = (response['components'] as List)
                  .map((item) => UIComponent.fromJson(item))
                  .toList();
            } else {
              debugPrint('Components are not in the expected List format');
            }
          }
        } else {
          debugPrint("Failed");
          Get.snackbar('Failed', values.statusMessage ?? "");
        }
      } else {
        debugPrint("Error during registration.");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
















// // lib/controllers/ui_controller.dart
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'api_service.dart';
// import 'ui_component.dart';
//
// class UIController extends GetxController {
//   var components = <UIComponent>[].obs;
//   var isLoading = false.obs;
//   static const String baseUrl = 'http://192.168.88.50:8080';
//   final ApiService apiService;
//
//   UIController({required this.apiService});
//
//   // @override
//   // void onInit() {
//   //   super.onInit();
//   //   fetchComponents(); // Call fetchComponents on initialization
//   // }
//
//   Future<void> fetchComponents(String urlEndPoint) async {
//     try {
//       // Call your API to fetch UI components
//       String apiUrl = '$baseUrl/$urlEndPoint';
//       // Example URL
//       final response = await apiService.makeApiCall(apiUrl, 'GET');
//       if(response.isNotEmpty){
//         final values = LoginResponseModel.fromJson(response);
//         if(values.statusCode == "0"){
//           components.value = values.components;
//           // components.value = (values as List)
//           //     .map((component) => UIComponent.fromJson(component))
//           //     .toList();
//         }else{
//           debugPrint('Error');
//         }
//
//       }
//
//     } catch (e) {
//       // Handle errors
//       debugPrint('Error fetching components: $e');
//     }
//   }
//   void showCustomSnackbar(String title, String message) {
//     Get.snackbar(
//       title,
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       duration: const Duration(seconds: 20),
//       backgroundColor: Colors.blue,
//       colorText: Colors.white,
//       borderRadius: 8,
//       margin: const EdgeInsets.all(16),
//       isDismissible: true,
//     );
//   }
//   Future<void> handleAction(UIComponent component, Map<String, dynamic> inputData) async {
//     try {
//       isLoading.value = true;
//       final response = await apiService.makeApiCall(
//         '$baseUrl${component.actionDetails!.url}',
//         component.actionDetails!.method,
//         body: inputData,
//       );
//       if(response != null){
//         final values = LoginResponseModel.fromJson(response);
//        if(values.statusCode == "0"){
//          debugPrint("Success");
//          showCustomSnackbar(
//            'Success',
//              values.statusMessage??""
//          );
//        }else{
//          debugPrint("Failed");
//          Get.snackbar('Failed', values.statusMessage??"");
//        }
//
//       }
//       else{
//         debugPrint("Error");
//       }
//       // Show success message or update state based on response
//
//     } catch (e) {
//       // Show error message
//      debugPrint(e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
// lib/controllers/ui_controller.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'api_service.dart';
// import 'ui_component.dart'; // Make sure to import your UIComponent model.
//
// class UIController extends GetxController {
//   var components = <UIComponent>[].obs;
//   var isLoading = false.obs;
//
//   // New variables for form data
//   var username = ''.obs;
//   var password = ''.obs;
//   var selectedGender = ''.obs;
//   var acceptTerms = false.obs;
//   var subscribeToNewsletter = false.obs;
//
//   static const String baseUrl = 'http://192.168.88.50:8080';
//   final ApiService apiService;
//
//   UIController({required this.apiService});
//
//   Future<void> fetchComponents(String urlEndPoint) async {
//     try {
//       String apiUrl = '$baseUrl/$urlEndPoint';
//       final response = await apiService.makeApiCall(apiUrl, 'GET');
//       if (response.isNotEmpty) {
//         final values = LoginResponseModel.fromJson(response);
//         if (values.statusCode == "0") {
//           components.value = values.components;
//         } else {
//           debugPrint('Error fetching components');
//         }
//       }
//     } catch (e) {
//       debugPrint('Error fetching components: $e');
//     }
//   }
//
//   void updateInput(String label, String value) {
//     switch (label) {
//       case 'Username':
//         username.value = value;
//         break;
//       case 'Password':
//         password.value = value;
//         break;
//       case 'Gender':
//         selectedGender.value = value;  // Example for gender
//         break;
//       case 'Accept Terms':
//         acceptTerms.value = value.toLowerCase() == 'true';  // Example for terms
//         break;
//       case 'Subscribe to Newsletter':
//         subscribeToNewsletter.value = value.toLowerCase() == 'true';  // Example for newsletter
//         break;
//       default:
//         break;
//     }
//   }
//   void showCustomSnackbar(String title, String message) {
//     Get.snackbar(
//       title,
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       duration: const Duration(seconds: 2),
//       backgroundColor: Colors.blue,
//       colorText: Colors.white,
//       borderRadius: 8,
//       margin: const EdgeInsets.all(16),
//       isDismissible: true,
//     );
//   }
//
//   Future<void> handleAction(UIComponent component, Map<String, dynamic> inputData) async {
//     try {
//       isLoading.value = true;
//       final response = await apiService.makeApiCall(
//         '$baseUrl${component.actionDetails!.url}',
//         component.actionDetails!.method,
//         body: inputData,
//       );
//       if (response != null) {
//         final values = LoginResponseModel.fromJson(response);
//         if (values.statusCode == "0") {
//           debugPrint("Success");
//           showCustomSnackbar('Success', values.statusMessage ?? "");
//         } else {
//           debugPrint("Failed");
//           Get.snackbar('Failed', values.statusMessage ?? "");
//         }
//       } else {
//         debugPrint("Error during registration.");
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
