import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/k_images.dart';
import 'package:ekayzoneukapps/apps/views/my_ads/component/my_ads_card.dart';
import 'package:ekayzoneukapps/apps/views/my_ads/controller/my_ads_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAdsScreen extends GetView<MyAdsController> {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Ads"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp, color: iconThemeColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.userAdModel?.data.data.length!=0
                ? RefreshIndicator(
                    onRefresh: () async {
                      return controller.getAdsData();
                    },
                    child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      controller: controller.scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              Obx(() => Column(
                                    children: [
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.adList.value.length,
                                        itemBuilder: (context, index) {
                                          return CustomerAdListCard(
                                              adModel: controller
                                                  .adList.value[index],
                                              myAdsController: controller);
                                        },
                                      ),
                                      Visibility(
                                          visible:
                                              controller.gettingMoreData.value,
                                          child:
                                              const CircularProgressIndicator())
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: Image.asset(KImages.noDataImage))),
      ),
    );
  }
}
