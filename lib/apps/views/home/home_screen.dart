import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/views/home/component/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ekayzoneukapps/apps/routes/routes.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:ekayzoneukapps/apps/views/home/models/category_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../main.dart';
import '../../core/utils/custom_image.dart';
import '../../core/utils/k_images.dart';
import '../../global_widget/custom_text_feild.dart';
import '../splash/localization/app_localizations.dart';
import 'component/grid_product_container.dart';
import 'component/home_screen_shinner_widget.dart';
import 'component/list_product_card.dart';
import 'controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        scrolledUnderElevation: 0,
        title: const CustomImage(
          height: 100,
          width: 100,
          fit: BoxFit.cover,
          path: KImages.allAppLogo,
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('United Kingdom',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Visibility(
            visible: false,
            child: SizedBox(
              child: PopupMenuButton(
                icon: Material(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Text(
                      controller.getCountryName(
                          AppLocalizations.of(context).languageCode),
                      // "United Kingdom",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                itemBuilder: (context) => <PopupMenuEntry>[
                  ...List.generate(controller.languages.length, (index) {
                    List<Flag> flags = [
                      Flag.fromCode(
                        FlagsCode.GB,
                        height: 20,
                        width: 20,
                      ),
                      Flag.fromCode(
                        FlagsCode.CN,
                        height: 20,
                        width: 20,
                      ),
                      Flag.fromCode(
                        FlagsCode.FR,
                        height: 20,
                        width: 20,
                      ),
                      Flag.fromCode(
                        FlagsCode.VU,
                        height: 20,
                        width: 20,
                      ),
                    ];
                    return PopupMenuItem(
                      onTap: () {
                        controller.toChange(controller.languages[index].code);
                      },
                      child: Row(
                        children: [
                          flags[index],
                          const SizedBox(width: 16),
                          Text(controller.languages[index].name),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => RefreshIndicator(
            onRefresh: () => Future.delayed(
                  const Duration(seconds: 1),
                  () => controller.getHomeData(),
                ),
            child: Obx(
              () => controller.isLoading.value
                  ? const SingleChildScrollView(
                      child: HomeScreenShimmerWidget())
                  : CustomScrollView(
                      controller: controller.scrollController2,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        /// SEARCH, FILTER FILED
                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, top: 14, bottom: 14),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration:
                                const BoxDecoration(color: Color(0XFFF7E7F3)),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black12, width: 8),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                children: [
                                  DropdownButtonFormField<Category>(
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                        hintText: "Category"),
                                    value: controller.category,
                                    items: controller.categoryList.value
                                        .map<DropdownMenuItem<Category>>((e) {
                                      return DropdownMenuItem<Category>(
                                        value: e,
                                        child: Text(e.name),
                                      );
                                    }).toList(),
                                    onChanged: (Category? value) {
                                      controller.selectedCategory =
                                          value!.name.toString();
                                    },
                                  ),
                                  CustomTextField(
                                    controller: controller.searchController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    isObsecure: false,
                                    enabled: true,
                                    hintext: "What are you looking for?",
                                  ),
                                  TypeAheadFormField(
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                            controller:
                                                controller.locationController,
                                            decoration: const InputDecoration(
                                                hintText: 'Location')),
                                    suggestionsCallback: (pattern) async {
                                      await controller.getPlaces(pattern, "za");
                                      return controller.placesSearchResult
                                          .where((element) => element
                                              .description!
                                              .toLowerCase()
                                              .contains(pattern
                                                  .toString()
                                                  .toLowerCase()))
                                          .take(10)
                                          .toList();
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        title:
                                            Text("${suggestion.description}"),
                                      );
                                    },
                                    transitionBuilder:
                                        (context, suggestionsBox, controller) {
                                      return suggestionsBox;
                                    },
                                    onSuggestionSelected:
                                        (Prediction suggestion) {
                                      controller.locationController.text =
                                          suggestion.description
                                              .toString()
                                              .trim()
                                              .substring(
                                                  0,
                                                  suggestion.description
                                                      .toString()
                                                      .trim()
                                                      .indexOf(','));
                                    },
                                  ),
                                  Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    height: 48,
                                    child: DropdownButtonHideUnderline(
                                      child: Obx(() => DropdownButton<String>(
                                            hint: Text('Entire city',
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade400)),
                                            isDense: true,
                                            isExpanded: true,
                                            onChanged: (dynamic value) {
                                              controller.selectedCity.value =
                                                  value;
                                            },
                                            value: controller
                                                        .selectedCity.value ==
                                                    ""
                                                ? null
                                                : controller.selectedCity.value,
                                            items: dropDownListData
                                                .map((location) {
                                              return DropdownMenuItem<String>(
                                                value: location['value'],
                                                child: Text(
                                                    "${location['title']}"),
                                              );
                                            }).toList(),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.adsScreen,
                                                arguments: [
                                              controller.searchController.text,
                                              controller.selectedCategory,
                                              controller
                                                  .locationController.text,
                                              controller.selectedCity.value,
                                            ])!
                                            .then((value) {
                                          controller.clear();
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero),
                                          backgroundColor:
                                              const Color(0xFF212d6e)),
                                      child: const Text("Find it"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        ///Category Section
                        // SliverToBoxAdapter(
                        //   child: Visibility(
                        //     visible: true,
                        //     child: Column(
                        //       children: [
                        //         ///TITLE
                        //         Center(
                        //           child: Column(
                        //             children: [
                        //               RichText(
                        //                 text: TextSpan(
                        //                   text: AppLocalizations.of(context)
                        //                       .translate('browse'),
                        //                   style: const TextStyle(
                        //                       fontWeight: FontWeight.bold,
                        //                       color: Colors.black,
                        //                       fontSize: 18),
                        //                   children: <TextSpan>[
                        //                     const TextSpan(text: " "),
                        //                     TextSpan(
                        //                         text: AppLocalizations.of(context)
                        //                             .translate('categories'),
                        //                         style: const TextStyle(
                        //                             fontWeight: FontWeight.bold,
                        //                             color: Colors.green,
                        //                             fontSize: 18)),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Container(
                        //                 width: 70.0,
                        //                 margin: const EdgeInsets.fromLTRB(
                        //                     0.0, 5.0, 0.0, 0.0),
                        //                 child: const Column(
                        //                   children: [
                        //                     Divider(
                        //                       height: 1,
                        //                       color: Colors.black,
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               const SizedBox(
                        //                 width: 40.0,
                        //                 child: Divider(
                        //                   height: 6,
                        //                   color: Colors.black,
                        //                 ),
                        //               ),
                        //               const SizedBox(height: 10)
                        //             ],
                        //           ),
                        //         ),
                        //
                        //         ///Category cards
                        //         Container(
                        //           alignment: Alignment.center,
                        //           child: GridView.builder(
                        //             physics: const NeverScrollableScrollPhysics(),
                        //             scrollDirection: Axis.vertical,
                        //             gridDelegate:
                        //                 const SliverGridDelegateWithFixedCrossAxisCount(
                        //               crossAxisCount: 3,
                        //               mainAxisSpacing: 10,
                        //               crossAxisSpacing: 0,
                        //               childAspectRatio: 1.2,
                        //             ),
                        //             shrinkWrap: true,
                        //             itemCount:
                        //                 controller.homeModel?.categories.length,
                        //             itemBuilder: (BuildContext context, int index) {
                        //               return GestureDetector(
                        //                 onTap: () {
                        //                   Get.toNamed(Routes.adsScreen, arguments: [
                        //                     "",
                        //                     controller.homeModel?.categories[index]
                        //                             .slug
                        //                             .toString() ??
                        //                         "",
                        //                   ])!
                        //                       .then((value) {
                        //                     controller.searchController.text = "";
                        //                   });
                        //                 },
                        //                 child: Container(
                        //                   padding: const EdgeInsets.symmetric(
                        //                       horizontal: 16),
                        //                   child: Column(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.center,
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.center,
                        //                     children: [
                        //                       CircleAvatar(
                        //                         radius: 20,
                        //                         backgroundColor:
                        //                             Colors.grey.shade300,
                        //                         child: ClipRRect(
                        //                           borderRadius:
                        //                               BorderRadius.circular(100),
                        //                           child: CustomImage(
                        //                             path:
                        //                                 "${RemoteUrls.rootUrl}${controller.homeModel?.categories[index].image}",
                        //                             fit: BoxFit.cover,
                        //                             height: Get.height,
                        //                             width: Get.width,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       const SizedBox(height: 5),
                        //                       Expanded(
                        //                         child: SizedBox(
                        //                           child: Text(
                        //                             "${controller.homeModel?.categories[index].name}",
                        //                             maxLines: 3,
                        //                             textAlign: TextAlign.center,
                        //                             overflow: TextOverflow.ellipsis,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        ///Sponsored Ads
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverToBoxAdapter(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sponsored Ads",
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    height: 1.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.scrollOff();
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          color: Colors.white,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_back,
                                          size: 18,
                                          color: Color(0xFF212d6e),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        controller.scrollOn();
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          color: Colors.white,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          size: 18,
                                          color: Color(0xFF212d6e),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///Sponsored Ads List
                        SliverPadding(
                          padding: const EdgeInsets.all(12),
                          sliver: SliverToBoxAdapter(
                            child: SizedBox(
                              height: 270,
                              child: ListView.separated(
                                controller: controller.scrollController,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    controller.homeModel!.featureAds.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 10);
                                },
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.adDetailsScreen,
                                          arguments:
                                              "${controller.homeModel?.featureAds[index].slug}");
                                    },
                                    child: ListProductCard(
                                      adsModel: controller
                                          .homeModel!.featureAds[index],
                                      logInUserId: controller.userId == ""
                                          ? 0
                                          : int.parse(controller.userId),
                                      index: index,
                                      width: 200,
                                      onFavClick: () {
                                        var userId = sharedPreferences
                                            .getString("userId");
                                        if (userId == null) {
                                          Get.snackbar(
                                              "Warning", 'Login please',
                                              colorText: Colors.red.shade300,
                                              backgroundColor: Colors.white);
                                        } else {
                                          if (int.parse(userId) ==
                                              controller.homeModel!
                                                  .featureAds[index].id) {
                                            Utils.showSnackBar(context,
                                                "You can not add your ads to your favorite list ");
                                          } else {
                                            Get.find<HomeController>()
                                                    .homeModel!
                                                    .featureAds[index]
                                                    .isWishlist =
                                                !controller
                                                    .homeModel!
                                                    .featureAds[index]
                                                    .isWishlist;
                                            Get.find<HomeController>()
                                                .setUnsetWishlist(controller
                                                    .homeModel!
                                                    .featureAds[index]
                                                    .id
                                                    .toString());
                                            controller.update();
                                          }
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        ///LATEST AD SECTION
                        const SliverToBoxAdapter(child: SizedBox(height: 10)),

                        // SliverPadding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 16),
                        //   sliver: SliverToBoxAdapter(
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("Latest Ads",style: GoogleFonts.lato(
                        //           fontSize: 18,
                        //           height: 1.5,
                        //           fontWeight: FontWeight.w600,
                        //         ),),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        ///Latest Ad Section
                        // GridProductContainer(
                        //   adModelList: controller.homeModel?.latestAds ?? [],
                        //   title: "Latest Ads",
                        // ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: MultiSliver(
                            children: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "Latest Ads",
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
                                  if (controller
                                      .homeModel!.latestAds.isNotEmpty) {
                                    return SliverGrid(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        mainAxisExtent: 250,
                                      ),
                                      delegate: SliverChildBuilderDelegate(
                                        childCount: controller
                                            .homeModel?.latestAds.length,
                                        (BuildContext context, int pIndex) =>
                                            ProductCard(
                                          adModel: controller
                                              .homeModel?.latestAds[pIndex],
                                          logInUserId: controller.userId == ""
                                              ? 0
                                              : int.parse(controller.userId),
                                          index: pIndex,
                                          onFavClick: () {
                                            var userId = sharedPreferences
                                                .getString("userId");
                                            if (userId == null) {
                                              Get.snackbar(
                                                  "Warning", 'Login please',
                                                  colorText:
                                                      Colors.red.shade300,
                                                  backgroundColor:
                                                      Colors.white);
                                            } else {
                                              if (int.parse(userId) ==
                                                  controller
                                                      .homeModel
                                                      ?.latestAds[pIndex]
                                                      .userId) {
                                                Utils.showSnackBar(context,
                                                    "You can not add your ads to your favorite list ");
                                              } else {
                                                Get.find<HomeController>()
                                                        .homeModel!
                                                        .latestAds[pIndex]
                                                        .isWishlist =
                                                    !controller
                                                        .homeModel!
                                                        .latestAds[pIndex]
                                                        .isWishlist;
                                                Get.find<HomeController>()
                                                    .setUnsetWishlist(controller
                                                        .homeModel!
                                                        .latestAds[pIndex]
                                                        .id
                                                        .toString());
                                                controller.update();
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
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: Colors.black54)),
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
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 16)),
                      ],
                    ),
            )),
      ),
    );
  }
}
