  import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

AppBar taskdetailappbar() {
    return AppBar(
      backgroundColor: Vx.gray600,
      foregroundColor: Vx.white,
      title: "Task Details".text.size(24).bold.white.make(),
    );
  }