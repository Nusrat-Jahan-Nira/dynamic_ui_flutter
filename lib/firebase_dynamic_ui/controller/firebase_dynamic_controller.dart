import 'dart:convert';

import 'package:dynamic_ui_flutter/firebase_dynamic_ui/model/firebase_ui_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/firebase_dynamic_api_service.dart';

import 'package:get/get.dart';

class FirebaseUiController extends GetxController {

  static const String baseUrl = 'http://192.168.88.50:8080';
  final FirebaseDynamicApiService apiService;
  var isLoading = true.obs;
  // Observable variable to hold the components
  var components = <Map<String, dynamic>>[].obs;

  FirebaseUiController({required this.apiService});

  // Method to update components (you could fetch this from your API)
  void updateComponents(List<Map<String, dynamic>> newComponents) {
    components.assignAll(newComponents);
  }

  @override
  void onInit() {
    super.onInit();
    fetchUIComponents('read/component');
  }

  Future<void> fetchUIComponents(String urlEndPoint) async {
    try {
      String apiUrl = '$baseUrl/$urlEndPoint';
      final response = await apiService.makeApiCall(apiUrl, 'GET');

      if (response.isNotEmpty) {
          debugPrint('Response result $response');
          if (response is List) {
            debugPrint('Decoded response: $response');
            updateComponents(response.cast<Map<String, dynamic>>());
          } else {
            debugPrint('Unexpected response format: ${response.runtimeType}');
          }

        } else {
          debugPrint('Unexpected response format: ${response.runtimeType}');
        }

    } catch (e) {
      debugPrint('Error fetching components: $e');
    }finally{
      isLoading(false);
    }
  }


  Widget buildFirebaseUiComponents(List<Map<String, dynamic>> componentsJson) {
    List<Widget> widgets = componentsJson.map((componentJson) {
      FirebaseUiComponent component = FirebaseUiComponent.fromJson(componentJson);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: component.build(Get.context!),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

}
