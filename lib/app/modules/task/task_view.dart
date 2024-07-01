import 'package:attendanceapp/app/modules/home/widgets/taskbox.dart';
import 'package:attendanceapp/app/modules/task/controller/task_controller.dart';
import 'package:attendanceapp/app/modules/task/task_detail.dart';
import 'package:attendanceapp/app/modules/task/widget/completedtasks.dart';
import 'package:attendanceapp/app/modules/task/widget/reviewingtask.dart';
import 'package:attendanceapp/app/modules/task/widget/taskcontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskcontroller = Get.put(TaskController());
    return Scaffold(
      appBar: taskAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Task Overview"
                .text
                .bold
                .gray700
                .size(24)
                .make()
                .paddingSymmetric(horizontal: 16, vertical: 16),
            const TaskTop(),
            32.heightBox,
            "To-do list"
                .text
                .bold
                .gray700
                .size(24)
                .make()
                .paddingSymmetric(horizontal: 16),
            8.heightBox,
            Obx(
              () => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => TaskBox(
                        onpress: () => Get.to(() => TaskDetail(
                              task: taskcontroller.todolist[index],
                              onSubtaskUpdated: () {},
                            )),
                        title: taskcontroller.todolist[index].title!,
                        total: taskcontroller.todolist[index].subtasks!.length,
                        deadline: taskcontroller.todolist[index].deadline!,
                        priority: taskcontroller.todolist[index].priority!,
                      ).paddingSymmetric(horizontal: 16),
                  separatorBuilder: (_, index) => const SizedBox(
                        height: 16,
                      ),
                  itemCount: taskcontroller.todolist.length),
            ),
            80.heightBox
          ],
        ),
      ),
    );
  }

  AppBar taskAppBar() {
    return AppBar(
      title: "Check your Task".text.bold.size(24).white.make(),
      backgroundColor: Vx.gray600,
    );
  }
}

class TaskTop extends StatelessWidget {
  const TaskTop({super.key});

  @override
  Widget build(BuildContext context) {
    final taskcontroller = Get.put(TaskController());
    return Column(
      children: [
        Row(
          children: [
            Obx(
              () => Expanded(
                child: TaskContainer(
                  title: 'Ongoing',
                  subtitle:
                      "${taskcontroller.ongoinglist.length.toString()} task",
                  icon: Iconsax.activity5,
                ),
              ),
            ),
            16.widthBox,
            Obx(
              () => Expanded(
                child: TaskContainer(
                  icon: Iconsax.task_square5,
                  title: 'To do',
                  subtitle: "${taskcontroller.todolist.length.toString()} task",
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
        16.heightBox,
        Row(
          children: [
            Obx(
              () => Expanded(
                child: TaskContainer(
                  icon: Iconsax.receipt_search,
                  title: 'Reviewing',
                  subtitle:
                      "${taskcontroller.reviewinglist.length.toString()} task",
                )
                    .box
                    .border(color: Vx.gray600, width: 3)
                    .roundedSM
                    .shadowSm
                    .make()
                    .onTap(() => Get.to(() => const Reviewingtask())),
              ),
            ),
            16.widthBox,
            Obx(
              () => Expanded(
                child: TaskContainer(
                  icon: Icons.check_box_outlined,
                  title: 'Completed',
                  subtitle:
                      "${taskcontroller.completedlist.length.toString()} task",
                )
                    .box
                    .shadowSm
                    .border(color: Vx.gray600, width: 3)
                    .roundedSM
                    .make()
                    .onTap(() => Get.to(() => const CompletedTasks())),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }
}
