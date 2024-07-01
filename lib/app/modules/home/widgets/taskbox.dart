import 'package:attendanceapp/app/modules/home/widgets/prirotybox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class TaskBox extends StatelessWidget {
  const TaskBox({
    super.key,
    this.ongoing = false,
    required this.onpress,
    required this.title,
    this.done = 0,
    required this.total,
    required this.deadline,
    this.taskdone = false,
    required this.priority,
  });
  final bool ongoing;
  final VoidCallback onpress;
  final bool taskdone;
  final String title;
  final int? done;
  final int total;
  final String deadline;
  final String priority;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            title.text.capitalize.size(20).bold.gray800.make(),
            6.widthBox,
            PriorityBox(priority: priority)
          ],
        ),
        6.heightBox,
        if (ongoing == true)
          Column(
            children: [
              Row(
                children: [
                  "Completed: ".text.semiBold.size(16).make(),
                  "$done/$total".text.gray700.semiBold.make()
                ],
              ),
              4.heightBox,
              LinearProgressIndicator(
                value: (1 / total) * done!,
                color: Colors.blue,
                minHeight: 12,
                backgroundColor: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              12.heightBox,
            ],
          ),
        if (ongoing == false)
          (taskdone != true)
              ? "Subtask: $total task to complete".text.lg.semiBold.make()
              : "Subtask: $total task to completed".text.lg.semiBold.make(),
        Align(
            alignment: Alignment.bottomRight,
            child: "Deadline: $deadline".text.bold.size(16).gray800.make())
      ],
    )
        .paddingSymmetric(horizontal: 12, vertical: 10)
        .box
        .gray300
        .rounded
        .border(color: Vx.gray500, width: 1.5)
        .shadowXs
        .width(double.infinity)
        .make()
        .onTap(onpress);
  }
}
