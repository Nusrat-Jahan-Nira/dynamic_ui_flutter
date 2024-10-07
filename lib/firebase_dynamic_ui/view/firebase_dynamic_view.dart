

import 'package:dynamic_ui_flutter/firebase_dynamic_ui/model/firebase_ui_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/firebase_dynamic_controller.dart';
import '../services/firebase_dynamic_api_service.dart';

class FirebaseDynamicView extends StatelessWidget {

  final FirebaseUiController controller = Get.put(FirebaseUiController(apiService: FirebaseDynamicApiService()));

  FirebaseDynamicView({super.key});

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                return controller.buildFirebaseUiComponents(controller.components);
              }),
            ),
          );
        }
      }),
    );
  }



}
