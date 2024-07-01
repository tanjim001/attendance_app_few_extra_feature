import 'package:attendanceapp/app/modules/auth/login/controller/logincontroller.dart';
import 'package:attendanceapp/app/modules/auth/login/widget/loginbutton.dart';
import 'package:attendanceapp/app/modules/auth/login/widget/loginform.dart';
import 'package:attendanceapp/app/modules/auth/login/widget/tologinscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        ()=> LoginForm(
                          email: controller.loginEmailController,
                          password: controller.loginPasswordController,
                          showpassword: controller.showPassword.value,
                          onpressed: () => controller.showPassword.value =
                              !controller.showPassword.value,
                        ),
                      ),
                      const SizedBox(height: 64.0),
                      LoginButton(
                        onPressed: () => controller.signInWithEmailAndPassword(),
                      ),
                      32.heightBox,
                      const ToRegisterScreen()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







