import 'package:attendanceapp/app/modules/auth/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ToRegisterScreen extends StatelessWidget {
  const ToRegisterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        "Don't Have Account? ".text.semiBold.gray500.size(16).make(),
        "Register Here"
            .text
            .bold
            .gray600
            .size(16)
            .make()
            .onTap(() => Get.to(() => const RegisterScreen()))
      ],
    );
  }
}