import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekayzoneukapps/apps/core/utils/k_images.dart';
import 'package:ekayzoneukapps/apps/routes/routes.dart';
import 'package:ekayzoneukapps/apps/views/home/models/ad_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/constants.dart';
import '../controller/home_controller.dart';
import 'list_product_card.dart';

class HorizontalProductContainer extends GetView<HomeController> {
  const HorizontalProductContainer({super.key, required this.adsModel});

  final List<AdsModel> adsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Ads",
                style: GoogleFonts.lato(
                  fontSize: 14.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.carouselController.previousPage();
                    },
                    onTapDown: controller.onTapPreviousDown,
                    onTapUp: controller.onTapPreviousUp,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey.shade300),
                        color:
                            controller.isPreviousTap ? redColor : Colors.white,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        size: 18,
                        color:
                            controller.isPreviousTap ? Colors.white : redColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      controller.carouselController.nextPage();
                    },
                    onTapDown: controller.onTapNextDown,
                    onTapUp: controller.onTapNextUp,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey.shade300),
                        color: controller.isNextTap ? redColor : Colors.white,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: controller.isNextTap ? Colors.white : redColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            child: LayoutBuilder(builder: (context, constraints) {
              return adsModel.isEmpty
                  ? SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.asset(KImages.noDataImage),
                      ),
                    )
                  : SizedBox(
                      height: 270,
                      child: CarouselSlider.builder(
                        carouselController: controller.carouselController,
                        itemCount: adsModel.length,
                        options: CarouselOptions(
                            scrollDirection: Axis.horizontal,
                            autoPlay: false,
                            viewportFraction: 1.5,
                            height: 270),
                        itemBuilder: (context, index, realIndex) {
                          return GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.adDetailsScreen,
                                  arguments: adsModel[index].slug);
                            },
                            child: ListProductCard(
                              adsModel: adsModel[index],
                              logInUserId: controller.userId == ""? 0 : int.parse(controller.userId),
                              index: index,
                            ),
                          );
                        },
                      ),
                    );
            }),
          ),
        ],
      ),
    );
  }
}
