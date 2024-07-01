import 'package:attendanceapp/app/modules/attendance/controller/askforpermit_controller.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DescriptionTextField extends StatelessWidget {
  final LeaveApplicationController controller;

  const DescriptionTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.descriptionController,
      maxLines: 20,
      maxLength: 1000,
      decoration: const InputDecoration(   
        border: OutlineInputBorder(),
      ),
    ).box.make();
  }
}