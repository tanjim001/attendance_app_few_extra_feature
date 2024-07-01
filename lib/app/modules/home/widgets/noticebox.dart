import 'package:attendanceapp/app/data/models/noticemodel.dart';
import 'package:attendanceapp/app/modules/notice/notice_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class NoticeBox extends StatelessWidget {
  const NoticeBox({
    super.key,
    required this.notice, // Making notice required and non-nullable
  });

  final Notice? notice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (notice?.title ?? "No notice")
            .text
            .white
            .size(20)
            .bold
            .make()
            .box
            .topRounded(value: 12)
            .width(double.infinity)
            .padding(const EdgeInsets.all(10))
            .gray600
            .make(),
        (notice?.description ?? "")
            .text
            .ellipsis
            .xl
            .semiBold
            .maxLines(4)
            .make()
            .box
            .padding(const EdgeInsets.all(10))
            .gray200 // Use Colors.white for white color
            .bottomRounded(value: 12)
            .width(double.infinity)
            .make()
            .onTap(() {
          if (notice != null) {
            Get.to(() => NoticeView(notice: notice!));
          }
        }),
      ],
    ).box.shadow.rounded.make().p(4).onTap(() {
      if (notice != null) {
        Get.to(() => NoticeView(notice: notice!));
      }
    });
  }
}
