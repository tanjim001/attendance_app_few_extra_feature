import 'popmenuebutton.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

AppBar attendanceAppBar() {
  return AppBar(
    surfaceTintColor: Colors.white,
    backgroundColor: Vx.gray600,
    title: "Check Your Attendance".text.bold.white.size(24).make(),
    actions: const [CustomPoPMenue()],
  );
}
