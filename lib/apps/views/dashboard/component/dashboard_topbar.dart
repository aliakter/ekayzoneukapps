import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/custom_image.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/data/remote_urls.dart';
import 'package:ekayzoneukapps/apps/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/routes.dart';

class DashboardTopBar extends StatelessWidget {
  final DashboardController controller;

  const DashboardTopBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration:
              const BoxDecoration(color: redColor, shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CustomImage(
              path: controller.dashboardModel?.data.dashBoardUser.image != ''
                  ? "${RemoteUrls.rootUrl}${controller.dashboardModel?.data.dashBoardUser.image}"
                  : null,
              height: 50.h,
              width: 50.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.dashboardModel!.data.dashBoardUser.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Joined: ${Utils.formatDate(controller.dashboardModel!.data.dashBoardUser.createdAt)}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.white.withAlpha(910),
          elevation: 3,
          shadowColor: const Color(0xFFFFFFFF),
          borderOnForeground: true,
          shape: const CircleBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              Get.toNamed(Routes.editProfile);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.edit, color: redColor, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
