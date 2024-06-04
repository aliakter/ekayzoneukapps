import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/views/ad_details/controllers/ad_details_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/controller/home_controller.dart';
import 'package:ekayzoneukapps/apps/views/public_profile/controller/public_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompareButton extends StatelessWidget {
  const CompareButton(
      {super.key,
      required this.productId,
      this.from,
      this.index,
      this.adsUserId,
      this.logInUserId});

  final int productId;
  final String? from;
  final int? index;
  final int? adsUserId;
  final int? logInUserId;
  final double height = 28;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print(logInUserId);
        print(adsUserId);
        print("dddddddddddddddd");
        if (logInUserId == adsUserId && logInUserId != 0) {
          Utils.toastMsg("You can not add your ads to your compare list");
        } else {
          ///check for 3 item limit
          // if (Get.find<HomeController>().compareList.length < 3) {
          ///remove from compare list.
          if (Get.find<HomeController>().compareAdList.contains(productId)) {
            Utils.toastMsg("Item remove from your compare list");
            Get.find<HomeController>().removedFromCompareList(productId);
            Get.find<AdDetailsController>().getAdDetails();
            Get.find<PublicProfileController>().getPublicProfile();
          } else {
            ///add to compare list
            Utils.toastMsg("Item added to your compare list");
            Get.find<HomeController>().addToCompareList(productId);
            Get.find<AdDetailsController>().getAdDetails();
            Get.find<PublicProfileController>().getPublicProfile();
          }
        }
      },
      child: Get.find<HomeController>().checkIfCompareList(productId)
          ? const Icon(Icons.change_circle, color: Colors.black, size: 20)
          : Icon(Icons.change_circle_outlined,
              color: Colors.grey.shade500, size: 20),
    );
  }
}
