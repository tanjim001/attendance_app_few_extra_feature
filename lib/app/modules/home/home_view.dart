import 'package:attendanceapp/app/modules/home/controller/homecontroller.dart';
import 'package:attendanceapp/app/modules/home/widgets/checkincheckout.dart';
import 'package:attendanceapp/app/modules/home/widgets/customslider.dart';
import 'package:attendanceapp/app/modules/home/widgets/homeappbar.dart';
import 'package:attendanceapp/app/modules/home/widgets/noticebox.dart';
import 'package:attendanceapp/app/modules/home/widgets/taskbox.dart';
import 'package:attendanceapp/app/modules/home/widgets/timeanddate.dart';
import 'package:attendanceapp/app/modules/home/widgets/titleandtextbutton.dart';
import 'package:attendanceapp/app/modules/notice/controller/noticecontroller.dart';
import 'package:attendanceapp/app/modules/task/controller/task_controller.dart';
import 'package:attendanceapp/app/modules/task/task_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final noticeecontroller = Get.put(NoticeController());
    final taskcontroller = Get.put(TaskController());
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: homeAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TimeAndDate().paddingSymmetric(horizontal: 16,vertical: 8),
              const ChekInCheckOut().paddingSymmetric(horizontal: 16),
              36.heightBox,
              TitleAndTextButton(
                title: "Notice/Event",
                onPressed: () {},
              ).paddingSymmetric(horizontal: 20),
              8.heightBox,
              Obx(() {
                final noticedata = noticeecontroller.latestNotice;
                return NoticeBox(notice: noticedata)
                    .paddingSymmetric(horizontal: 16);
              }),
              32.heightBox,
              Obx(
                () => CustomSlider(
                  action: () => controller.checkincheckout(),
                  checkin: controller.checkedIn.value,
                  checkout: controller.checkedOut.value,
                ).paddingSymmetric(horizontal: 16),
              ),
              32.heightBox,
              TitleAndTextButton(
                title: 'Ongoing',
                onPressed: () {},
              ).paddingSymmetric(horizontal: 20),
              8.heightBox,
              Obx(
                () => ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final taskdata = taskcontroller.ongoinglist[index];
                      final donenum = 0.obs;
                      donenum.value = taskcontroller
                          .ongoinglist[index].subtasks!
                          .where((v) => v.done!)
                          .length;

                      return Obx(
                        () => TaskBox(
                          ongoing: true,
                          onpress: () => Get.to(() => TaskDetail(
                                task: taskdata,
                                onSubtaskUpdated: () {
                                  donenum.value = taskcontroller
                                      .ongoinglist[index].subtasks!
                                      .where((v) => v.done!)
                                      .length;
                                },
                              )),
                          done: donenum.value,
                          title: taskcontroller.ongoinglist[index].title!,
                          total: taskcontroller
                              .ongoinglist[index].subtasks!.length,
                          deadline: taskcontroller.ongoinglist[index].deadline!,
                          priority: taskcontroller.ongoinglist[index].priority!,
                        ).paddingSymmetric(horizontal: 16),
                      );
                    },
                    separatorBuilder: (_, index) => const SizedBox(
                          height: 16,
                        ),
                    itemCount: taskcontroller.ongoinglist.length),
              ),
              32.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
