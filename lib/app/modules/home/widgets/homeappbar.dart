import 'package:attendanceapp/app/modules/profile/controller/profilecontroller.dart';
import 'package:attendanceapp/app/modules/profile/widget/customshimer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

AppBar homeAppBar() {
  final profileController = Get.put(ProfileController());

  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Vx.gray600,
    surfaceTintColor: Colors.grey[900],
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          final data = profileController.userdata.value;
          return 'Hey ${data.name}'.text.bold.size(28).white.capitalize.make();
        }),
        5.heightBox,
        'Good Morning! Make your attendance'
            .text
            .semiBold
            .size(16)
            .white
            .make(),
      ],
    ),
    actions: [
      Obx(() {
        final data = profileController.userdata.value;
        return CircleAvatar(
          backgroundColor: Colors.grey[400],
          radius: 28,
          child: ClipOval(
            child: data.profilepic != null
                ? CachedNetworkImage(
                    width: 56,
                    height: 56,
                    imageUrl: data.profilepic ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CustomCircleShimmer(height: 56, width: 56),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.person),
                  )
                : const Icon(Icons.person, size: 100, color: Vx.gray700),
          ),
        )
            .box
            .roundedFull
            .border(color: Vx.white, width: 1.5)
            .make()
            .paddingSymmetric(horizontal: 16);
      }),
    ],
  );
}
