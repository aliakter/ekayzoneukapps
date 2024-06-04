import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/global_widget/custom_text_feild.dart';
import 'package:ekayzoneukapps/apps/views/ads/component/ads_appbar.dart';
import 'package:ekayzoneukapps/apps/views/ads/controller/ads_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/component/grid_product_container2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:ekayzoneukapps/apps/views/home/models/category_model.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../splash/localization/app_localizations.dart';

class AdsScreen extends GetView<AdsController> {
  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdsController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              controller.clear();
              return controller.getAdsListData();
            },
            child: CustomScrollView(
              controller: controller.scrollController,
              scrollDirection: Axis.vertical,
              slivers: [
                MultiSliver(children: [
                  AdsAppBar.appBar(context, controller),

                  ///Search and Filtering area
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 14, bottom: 14),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(color: Color(0XFFF7E7F3)),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12, width: 8),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            ///Search text filed
                            DropdownButtonFormField<Category>(
                              isExpanded: true,
                              decoration:
                                  const InputDecoration(hintText: "Category"),
                              value: controller.category,
                              items: controller
                                  .homeController.categoryList.value
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
                              textFieldConfiguration: TextFieldConfiguration(
                                  controller: controller.locationController,
                                  decoration: const InputDecoration(
                                      hintText: 'Location')),
                              suggestionsCallback: (pattern) async {
                                await controller.getPlaces(pattern, "za");
                                return controller.placesSearchResult
                                    .where((element) => element.description!
                                        .toLowerCase()
                                        .contains(
                                            pattern.toString().toLowerCase()))
                                    .take(10)
                                    .toList();
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text("${suggestion.description}"),
                                );
                              },
                              transitionBuilder:
                                  (context, suggestionsBox, controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (Prediction suggestion) {
                                controller.locationController.text = suggestion
                                    .description
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              height: 48,
                              child: DropdownButtonHideUnderline(
                                child: Obx(() => DropdownButton<String>(
                                      hint: Text('Entire city',
                                          style: TextStyle(
                                              color: Colors.grey.shade400)),
                                      isDense: true,
                                      isExpanded: true,
                                      onChanged: (dynamic value) {
                                        controller.selectedCity.value = value;
                                      },
                                      value: controller.selectedCity.value == ""
                                          ? null
                                          : controller.selectedCity.value,
                                      items: dropDownListData.map((location) {
                                        return DropdownMenuItem<String>(
                                          value: location['value'],
                                          child: Text("${location['title']}"),
                                        );
                                      }).toList(),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  Utils.closeKeyBoard(context);
                                  controller.getAdsListData();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero),
                                    backgroundColor: const Color(0xFF212d6e)),
                                child: const Text("Find it"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Custom Price filtering
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: controller.minPriceController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  height: 48,
                                  isObsecure: false,
                                  // fillColor: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(4),
                                  hintext: "Min",
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: CustomTextField(
                                  controller: controller.maxPriceController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  height: 48,
                                  isObsecure: false,
                                  // fillColor: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(4),
                                  hintext: "Max",
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: SizedBox(
                                  height: 48,
                                  child: ElevatedButton(
                                    style: OutlinedButton.styleFrom(
                                      elevation: 5,
                                      shadowColor: Colors.grey.shade300,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    onPressed: () {
                                      Utils.closeKeyBoard(context);
                                      if (controller.minPriceController.text
                                              .trim() ==
                                          "") {
                                        Utils.errorSnackBar(
                                            context, "Please enter min price");
                                      } else if (controller
                                              .maxPriceController.text
                                              .trim() ==
                                          "") {
                                        Utils.errorSnackBar(
                                            context, "Please enter max price");
                                      } else {
                                        controller.getAdsListData();
                                      }
                                    },
                                    child: const Text(
                                      "Apply",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          /// Filtering dropdown
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text("Ads",
                                  style: TextStyle(
                                      fontSize: 18,
                                      height: 1.5,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(width: 50),
                              Obx(
                                () => Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: const Text('Sort By',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        isDense: true,
                                        isExpanded: true,
                                        borderRadius: BorderRadius.circular(10),
                                        onChanged: (dynamic value) {
                                          controller.selectedSortingValue
                                              .value = value;
                                          controller.getAdsListData();
                                        },
                                        value: controller.selectedSortingValue
                                                    .value ==
                                                ""
                                            ? null
                                            : controller
                                                .selectedSortingValue.value,
                                        items:
                                            myItemSortListData.map((location) {
                                          return DropdownMenuItem<String>(
                                            value: location['value'],
                                            child: Text("${location['name']}"),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ),

                  Obx(
                    () => controller.isLoading.value
                        ? const SizedBox(
                            height: 400,
                            child: Center(child: CircularProgressIndicator()))
                        : SliverToBoxAdapter(
                            child: Column(
                              children: [
                                GridProductContainer2(
                                  controller: controller,
                                    onPressed: () {
                                    },
                                    adModelList: controller.adListMode),
                                Visibility(
                                  visible: controller.gettingMoreData.value,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: const Center(
                                      child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator()),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 50)),
                ])
              ],
            ),
          ),
        ),
      );
    });
  }
}
