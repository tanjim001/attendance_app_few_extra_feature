import 'package:attendanceapp/app/modules/notice/notice_list.dart';
import 'package:attendanceapp/app/modules/task/task_view.dart';

import 'modules/attendance/attendance_view.dart';
import 'modules/home/home_view.dart';
import 'modules/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          iconSize: 24,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.grey[800],
          unselectedItemColor: Colors.grey[500],
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Iconsax.notification_15),
                label: 'Notices',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle),
                label: 'Attendance',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Iconsax.home_15),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.task_square5),
                label: 'Tasks',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_2user5),
                label: 'Profile',
                backgroundColor: Colors.white),
          ],
        );
      }),
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: const [
            NoticeList(),
            AttendanceView(),
            HomePage(), 
            TaskView(),
            ProfileView()
          ],
        );
      }),
    );
  }
}

class NavigationController extends GetxController {
  var selectedIndex = 2.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
