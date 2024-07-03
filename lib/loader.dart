import 'package:attendanceapp/app/core/utils/constants/string_const.dart';
import 'package:attendanceapp/app/core/utils/local_storage/storage_utility.dart';
import 'package:attendanceapp/app/data/service/api/locationtimecontroller.dart';
import 'package:attendanceapp/app/modules/attendance/controller/attendancecontroller.dart';
import 'package:attendanceapp/app/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    final timeController = Get.put(LocationTimeController());

    return Scaffold(
      body: Obx(() => timeController.isDataFetched.value
          ? const DataFetching()
          : const TimeFetch()),
    );
  }
}

class TimeFetch extends StatelessWidget {
  const TimeFetch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          "Loading time data of your Zone....".text.gray400.make(),
          8.heightBox,
          const LinearProgressIndicator().box.width(120).make(),
        ],
      ),
    );
  }
}

class DataFetching extends StatelessWidget {
  const DataFetching({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceController = Get.put(AttendanceController());
    LocalStorage localStorage = LocalStorage();

    // Perform the necessary actions and save data
    if (attendanceController.isDataFetched.value) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.off(() => const NavigationScreen());
      });
      localStorage.saveData(StringConst.fasttimeloggedin, true);
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Fetching your information from the database...."
                .text
                .gray400
                .make(),
            8.heightBox,
            const LinearProgressIndicator().box.width(120).make(),
          ],
        ),
      ),
    );
  }
}
