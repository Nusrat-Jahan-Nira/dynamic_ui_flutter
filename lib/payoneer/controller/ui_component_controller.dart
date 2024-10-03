import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../dynamic_ui/services/api_service.dart';
import '../model/ui_component.dart';

class UIComponentController extends GetxController {
  var components = <UIComponent>[].obs;
  var isLoading = true.obs;
  static const String baseUrl = 'http://192.168.88.50:8080';
  final ApiService apiService;

  UIComponentController({required this.apiService});

  @override
  void onInit() {
    super.onInit();
    fetchUIComponents('payoneer-ui-components');
  }

  Future<void> fetchUIComponents(String urlEndPoint) async {
    try {
      String apiUrl = '$baseUrl/$urlEndPoint';
      final response = await apiService.makeApiCall(apiUrl, 'GET');

      if (response.isNotEmpty) {
        // Check if the response is a Map or List
        if (response is Map<String, dynamic>) {
          // Handle the case where response is a map
          final values = APIResponse.fromJson(response);
          if (values.statusCode == "0") {
            // Assuming components are in response['components']
            if (response['components'] is List) {
              components.clear();
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
    }finally{
      isLoading(false);
    }
  }
}
