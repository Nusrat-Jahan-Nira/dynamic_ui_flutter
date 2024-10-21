import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../dynamic_ui/services/api_service.dart';
import 'form_element.dart';

class FormController extends GetxController {
  var formElements = <FormElement>[].obs; // Observable list for UI
  var formValues = <String, String>{}.obs; // To hold input values
  static const String baseUrl = 'http://10.11.200.26:8080';
  final ApiService apiService;
  var isLoading = false.obs;

  FormController({required this.apiService});

  @override
  void onInit() {
    super.onInit();
    fetchComponents('read/login','GET');
  }

  Future<void> fetchComponents(String urlEndPoint, String method) async {
    isLoading.value = true;
    try {
      String apiUrl = '$baseUrl/$urlEndPoint';
      final response = await apiService.makeApiCall(apiUrl, method);

      if (response.isNotEmpty) {
        if (response is List) { // Check if response is a List
          formElements.value = response.map((e) => FormElement.fromJson(e)).toList();
        } else {
          debugPrint('Unexpected response format: ${response.runtimeType}');
        }
      }
    } catch (e) {
      debugPrint('Error fetching components: $e');
    }finally{
      isLoading.value = false;
    }
  }


  void updateValue(String label, String value) {
    formValues[label] = value;
  }

  void submitForm() {
    print(formValues);
  }
}
