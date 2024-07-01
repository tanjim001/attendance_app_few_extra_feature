import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

AppBar profileappbar() {
  return AppBar(
    backgroundColor: Vx.gray600,
    title: "Profile".text.bold.white.size(24).make(),
    actions: [IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit,color: Vx.white,))],
  );
}
