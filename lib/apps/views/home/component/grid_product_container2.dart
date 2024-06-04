import 'package:ekayzoneukapps/apps/core/utils/k_images.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/views/ads/controller/ads_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/component/product_card.dart';
import 'package:ekayzoneukapps/apps/views/home/controller/home_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/models/ad_model.dart';
import 'package:ekayzoneukapps/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridProductContainer2 extends StatelessWidget {
  const GridProductContainer2(
      {super.key, required this.adModelList, required this.onPressed, required this.controller});

  final List<AdsModel> adModelList;
  final Function onPressed;
  final AdsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              if (adModelList.isNotEmpty) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 300),
                  itemCount: adModelList.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      adModel: adModelList[index],
                      logInUserId: controller.userId == ""
                          ? 0
                          : int.parse(controller.userId),
                      index: index,
                      onFavClick: () {
                        var userId = sharedPreferences.getString("userId");
                        if (userId == null) {
                          Get.snackbar("Warning", 'Login please',
                              colorText: Colors.red.shade300,
                              backgroundColor: Colors.white);
                        } else {
                          if (int.parse(userId) == adModelList[index].id) {
                            Utils.showSnackBar(context,
                                "You can not add your ads to your favorite list ");
                          } else {
                            Get.find<AdsController>()
                                    .adListMode[index]
                                    .isWishlist =
                                !Get.find<AdsController>()
                                    .adListMode[index]
                                    .isWishlist;
                            Get.find<HomeController>().setUnsetWishlist(
                                Get.find<AdsController>()
                                    .adListMode[index]
                                    .id
                                    .toString());
                            Get.find<AdsController>().update();
                          }
                        }
                      },
                    );
                  },
                );
              } else {
                return SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(child: Image.asset(KImages.noDataImage)),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
