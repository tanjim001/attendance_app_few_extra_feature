import 'package:attendanceapp/app/modules/home/widgets/taskbox.dart';
import 'package:attendanceapp/app/modules/task/controller/task_controller.dart';
import 'package:attendanceapp/app/modules/task/task_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final taskcontroller = Get.put(TaskController());

    return Scaffold(
      appBar: AppBar(
        title: "Completed".text.size(24).bold.white.make(),
        backgroundColor: Vx.gray600,
        foregroundColor: Vx.white,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: taskcontroller.completedlist.length,
          itemBuilder: (BuildContext context, int index) {
            final taskdata = taskcontroller.completedlist[index];
            return TaskBox(
              taskdone: true,
                onpress: () =>
                    TaskDetail(task: taskdata, onSubtaskUpdated: () {}),
                title: taskdata.title.toString(),
                total: taskdata.subtasks!.length,
                deadline: taskdata.deadline.toString(), priority: taskdata.priority!,);
          },
        ),
      ),
    );
  }
}
