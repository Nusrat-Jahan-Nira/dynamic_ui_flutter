// lib/services/api_service.dart

// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiService {
//   Future<Map<String, dynamic>> makeApiCall(String url, String method, {Map<String, dynamic>? body}) async {
//     http.Response response;
//
//     if (method.toUpperCase() == 'POST') {
//       response = await http.post(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(body),
//       );
//     } else {
//       response = await http.get(Uri.parse(url));
//     }
//
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }

//3

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  /// Makes an API call.
  ///
  /// [url]: The endpoint to call.
  /// [method]: The HTTP method to use (GET or POST).
  /// [body]: Optional request body for POST requests.
  ///
  /// Returns a decoded JSON response as a Map<String, dynamic>.
  /// Throws an exception on failure.
  Future<T> makeApiCall<T>(String url, String method, {Map<String, dynamic>? body}) async {
    http.Response response;

    try {
      if (method.toUpperCase() == 'POST') {
        response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body),
        );
      } else {
        debugPrint(Uri.parse(url).toString());
        response = await http.get(Uri.parse(url));
      }

      _logRequest(url, method, body, response);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body) as T;
      } else {
        debugPrint(_handleError(response).toString());
        throw _handleError(response);
      }
    } catch (e) {
      // Handle any exceptions (network errors, etc.)
      throw Exception('An error occurred: $e');
    }
  }

  /// Logs the request and response for debugging.
  void _logRequest(String url, String method, Map<String, dynamic>? body, http.Response response) {
    print('Request: $method $url');
    if (body != null) {
      print('Request Body: ${json.encode(body)}');
    }
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');
  }

  /// Handles errors based on the response status code.
  Exception _handleError(http.Response response) {
    switch (response.statusCode) {
      case 400:
        return Exception('Bad Request: ${response.body}');
      case 401:
        return Exception('Unauthorized: ${response.body}');
      case 403:
        return Exception('Forbidden: ${response.body}');
      case 404:
        return Exception('Not Found: ${response.body}');
      case 500:
        return Exception('Server Error: ${response.body}');
      default:
        return Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }
}