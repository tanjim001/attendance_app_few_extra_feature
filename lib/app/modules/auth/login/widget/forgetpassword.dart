import 'package:attendanceapp/app/modules/auth/forgot_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        "Forget Password"
            .text
            .blue500
            .size(16)
            .semiBold
            .make()
            .onTap(() => Get.to(() => const ForgotPasswordScreen()))
      ],
    );
  }
}

