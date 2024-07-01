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
    return Scaffold(body:FutureBuilder<void>(
      future: timeController.initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              "Loading time data of your Zone....".text.gray400.make(),
              8.heightBox,
               const LinearProgressIndicator().box.width(120).make(),
            ],).centered(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          // Navigation should be performed outside the builder to avoid multiple navigations
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.off(() => const DataFetching());
          });
          return Container(); // Return an empty container while navigating
        } else {
          return const Center(
            child: Text('Unexpected state'),
          );
        }
      },
    ) ,);
  }
}


class DataFetching extends StatelessWidget {
  const DataFetching({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceController = Get.put(AttendanceController());

    return Scaffold(
      body: Obx(() {
        if (attendanceController.isDataFetched.value==true) {
          Future.delayed(Durations.long4, () {
            Get.off(()=>const NavigationScreen());
          });
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
              "Fetching  your information from database....".text.gray400.make(),
              8.heightBox,
               const LinearProgressIndicator().box.width(120).make(),
            ],).centered(),
          );
        } else {

          return  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              "Fetching  your information from database....".text.gray400.make(),
              8.heightBox,
               const LinearProgressIndicator().box.width(120).make(),
            ],).centered(),
          );
        }
      }),
    );
  }
}
