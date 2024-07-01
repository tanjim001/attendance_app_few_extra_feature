import 'package:attendanceapp/app/modules/attendance/askforleave.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceFloatButton extends StatelessWidget {
  const AttendanceFloatButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(()=>const LeaveApplication());
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded square shape
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 24, vertical: 16), // Padding for button content
        backgroundColor: Colors.green, // Background color
        foregroundColor: Colors.white, // Text color
      ),
      child: const Text(
        'Ask for Leave',
        style: TextStyle(
          fontSize: 16, // Font size
          fontWeight: FontWeight.bold, // Font weight
        ),
      ),
    );
  }
}
