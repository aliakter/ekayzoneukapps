import 'package:ekayzoneukapps/apps/core/utils/custom_image.dart';
import 'package:ekayzoneukapps/apps/core/utils/k_images.dart';
import 'package:ekayzoneukapps/apps/data/remote_urls.dart';
import 'package:ekayzoneukapps/apps/views/ads/controller/ads_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdsAppBar {
  static appBar(context, AdsController controller) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      centerTitle: true,
      pinned: true,
      // scrolledUnderElevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      title: const CustomImage(
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        path: KImages.allAppLogo,
      ),
      // title: Obx(
      //   () => controller.homeController.isSettingLoading.value
      //       ? Container()
      //       : Container(
      //           padding: const EdgeInsets.all(5),
      //           decoration: const BoxDecoration(
      //             shape: BoxShape.circle,
      //           ),
      //           child: ClipRRect(
      //             borderRadius: BorderRadius.circular(100),
      //             child: CustomImage(
      //               path: controller.homeController.settingModel.value!.data
      //                           .logoImage !=
      //                       ''
      //                   ? "${RemoteUrls.rootUrl}${controller.homeController.settingModel.value!.data.logoImage}"
      //                   : null,
      //               height: 60,
      //               width: 60,
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         ),
      // ),
    );
  }
}
