import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/controller/ad_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdPostScreen extends GetView<AdPostController> {
  const AdPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(
              child: Text(
                'Ad Post',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: redColor,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator(color: redColor))
              : CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    const SliverPadding(
                      padding:
                          EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          'Select A Category',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(color: redColor))
                          : SliverPadding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  childCount:
                                      controller.categoryList.value.length,
                                  (context, index) {
                                    var category =
                                        controller.categoryList.value[index];
                                    return Column(
                                      children: [
                                        Material(
                                          color: redColor.withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: InkWell(
                                            onTap: () {
                                              controller
                                                  .getSubcategory(category.id);
                                              controller.changeCategory(
                                                  category,
                                                  controller,
                                                  category.id.toString());
                                              // controller.brandList.value =
                                              //     controller.homeController
                                              //             .categoryList.value
                                              //             .singleWhere(
                                              //                 (element) =>
                                              //                     element.id ==
                                              //                     category.id)
                                              //             .brands;

                                              // Future.delayed(
                                              //         const Duration(milliseconds: 200))
                                              //     .then((value2) {
                                              //   controller.naveListener.sink.add(1);
                                              //   controller.animationController
                                              //       .forward(from: 0.0);
                                              // });
                                            },
                                            splashColor:
                                                redColor.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 12),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      child: Text(
                                                        category.name,
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  const Icon(
                                                      Icons.arrow_forward)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                    ),
                  ],
                )
          // StreamBuilder(
          //         initialData: 0,
          //         stream: controller.naveListener.stream,
          //         builder: (context, AsyncSnapshot<int> snapshot) {
          //           int index = snapshot.data ?? 0;
          //           return Column(
          //             children: [
          //               Expanded(
          //                 child: FadeTransition(
          //                   opacity: controller.animationController,
          //                   child: IndexedStack(
          //                       index: index, children: controller.pageList),
          //                 ),
          //               ),
          //               Visibility(
          //                 visible: index == 1,
          //                 child: Container(
          //                   padding: const EdgeInsets.symmetric(
          //                       horizontal: 16, vertical: 16),
          //                   decoration:
          //                       BoxDecoration(color: Colors.white, boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.grey.withOpacity(0.2),
          //                       blurRadius: 6,
          //                       offset: const Offset(1, 1),
          //                     )
          //                   ]),
          //                   child: Row(
          //                     children: [
          //                       Expanded(
          //                         child: SizedBox(
          //                           height: 45,
          //                           child: Obx(
          //                             () => ElevatedButton(
          //                               style: ElevatedButton.styleFrom(
          //                                 shape: RoundedRectangleBorder(
          //                                   borderRadius:
          //                                       BorderRadius.circular(6),
          //                                 ),
          //                               ),
          //                               onPressed: () {
          //                                 Utils.closeKeyBoard(context);
          //                                 if (controller
          //                                     .featureFormKey.currentState!
          //                                     .validate()) {
          //                                   controller.postAds();
          //                                 }
          //                               },
          //                               child: controller.isPostAdsLoading.value
          //                                   ? const Center(
          //                                       child:
          //                                           CircularProgressIndicator(
          //                                               color: Colors.white))
          //                                   : Text(
          //                                       index == 1
          //                                           ? AppLocalizations.of(
          //                                                   context)
          //                                               .translate('post_ad')!
          //                                           : "Next Step",
          //                                       style: const TextStyle(
          //                                           color: Colors.white),
          //                                     ),
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               )
          //             ],
          //           );
          //         },
          //       ),
          ),
    );
  }
}
