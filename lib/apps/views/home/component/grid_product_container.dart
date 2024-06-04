import 'package:ekayzoneukapps/apps/views/home/models/ad_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../../main.dart';
import '../../../core/utils/utils.dart';
import '../../main/controller/main_controller.dart';
import '../controller/home_controller.dart';
import 'product_card.dart';

class GridProductContainer extends StatefulWidget {
  const GridProductContainer(
      {super.key, required this.adModelList, this.from, this.title});

  final List<AdsModel> adModelList;
  final String? title;
  final String? from;

  @override
  State<GridProductContainer> createState() => GridProductContainerState();
}

class GridProductContainerState extends State<GridProductContainer> {
  final MainController mainController = MainController();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: MultiSliver(
        children: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                "${widget.title}",
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SliverLayoutBuilder(
            builder: (context, constraints) {
              if (widget.adModelList.isNotEmpty) {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 250,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: widget.adModelList.length,
                    (BuildContext context, int pIndex) => ProductCard(
                      adModel: widget.adModelList[pIndex],
                      index: pIndex,
                      onFavClick: (){
                        var userId = sharedPreferences.getString("userId");
                        if (userId == null) {
                          Get.snackbar("Warning", 'Login please',colorText: Colors.red.shade300, backgroundColor: Colors.white);
                        } else {
                          if (int.parse(userId) == widget.adModelList[pIndex].id) {
                            Utils.showSnackBar(context, "You can not add your ads to your favorite list ");
                          } else {
                            Get.find<HomeController>().homeModel!.latestAds[pIndex].isWishlist = Get.find<HomeController>().homeModel!.latestAds[pIndex].isWishlist;
                            Get.find<HomeController>().setUnsetWishlist(widget.adModelList[pIndex].id.toString());
                            Get.find<HomeController>().update();
                          }
                        }
                      },
                    ),
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.black54)),
                        child: const Text(
                          "Ads Not Found",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
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
