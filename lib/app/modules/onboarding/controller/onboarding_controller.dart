import 'package:attendanceapp/app/core/constant/string_const.dart';
import 'package:attendanceapp/app/core/utils/local_storage/storage_utility.dart';
import 'package:attendanceapp/app/modules/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  LocalStorage localStorage=LocalStorage();
  var currentPage = 0.obs;

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  void nextPage() {
    if (currentPage.value == 2) {
      localStorage.saveData(StringConst.isfirst,true);
      Get.to(()=>const LoginScreen());
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  bool get isLastPage => currentPage.value == 2;
}

