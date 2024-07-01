import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveApplicationController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void showConfirmationDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Are you sure?"),
        content: const Divider(),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text("No"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              // Handle the submit action
              Get.back();
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
