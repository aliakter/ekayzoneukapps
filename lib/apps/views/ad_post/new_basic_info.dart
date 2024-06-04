import 'dart:io';
import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/global_widget/categories_model.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/component/category_wise/education.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/component/category_wise/electronic.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/component/category_wise/fashion.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/component/category_wise/jobs.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/component/category_wise/mobile.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/component/category_wise/property.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/component/category_wise/vehicles.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/controller/ad_post_controller.dart';
import 'package:ekayzoneukapps/apps/views/splash/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewBasicInfoView extends StatelessWidget {
  const NewBasicInfoView({super.key, required this.controller});

  final AdPostController controller;

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
        body: CustomScrollView(slivers: [
          SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverToBoxAdapter(
                  child: Form(
                      key: controller.featureFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text.rich(
                                  TextSpan(text: 'Post an ad for ', children: [
                                TextSpan(
                                    text:
                                        '(${controller.selectedCategory.value == null ? '' : controller.selectedCategory.value!.name})',
                                    style: const TextStyle(
                                        color: Colors.lightBlueAccent))
                              ]))),
                          const SizedBox(height: 6),

                          ///title
                          Row(
                            children: [
                              Text('Title'),
                              const Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: controller.titleController,
                            textInputAction: TextInputAction.next,
                            decoration:
                                const InputDecoration(hintText: "Title"),
                          ),
                          const SizedBox(height: 16),

                          ///sub-category
                          Text(AppLocalizations.of(context)
                              .translate('subcategory')!),
                          const SizedBox(height: 6),
                          Obx(
                            () => DropdownButtonFormField<Branding>(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                  hintText: "Sub Category"),
                              value: controller.subcategory,
                              items: controller.subcategoryList
                                  .map<DropdownMenuItem<Branding>>((e) {
                                return DropdownMenuItem<Branding>(
                                  value: e,
                                  child: Text(e.name),
                                );
                              }).toList(),
                              onChanged: (Branding? value) {
                                controller.selectedSubcategory =
                                    value!.id.toString();
                                if (controller.selectedCategoryId.value ==
                                        '1' ||
                                    controller.selectedCategoryId.value ==
                                        '22') {
                                  controller.getBrandList(value.id);
                                }
                              },
                            ),
                          ),

                          ///Address
                          const SizedBox(height: 16),
                          Text(AppLocalizations.of(context)
                              .translate('location')!),
                          const SizedBox(height: 6),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: controller.locationController,
                            textInputAction: TextInputAction.next,
                            decoration:
                                const InputDecoration(hintText: "Location"),
                          ),

                          ///Country
                          // const Text(
                          //   "Country",
                          //   style: TextStyle(fontSize: 16),
                          // ),
                          // const SizedBox(height: 7),
                          // DropdownButtonFormField(
                          //   validator: (value) {
                          //     if (value == null) {
                          //       return null;
                          //     }
                          //     return null;
                          //   },
                          //   isExpanded: true,
                          //   decoration: const InputDecoration(
                          //     hintText: "Select Country",
                          //   ),
                          //   items:
                          //   postAdBloc.countryList.map<DropdownMenuItem<TopCountry>>((e) {
                          //     return DropdownMenuItem(
                          //       value: e,
                          //       child: Text(e.name),
                          //     );
                          //   }).toList(),
                          //   onChanged: (value) {
                          //     Future.delayed(const Duration(milliseconds: 300))
                          //         .then((value2) {
                          //       postAdBloc
                          //           .add(NewPostAdEventProductCountryId(value!.id.toString()));
                          //     });
                          //   },
                          // ),
                          // const SizedBox(height: 16,),
                          //
                          // ///States
                          // const Text(
                          //   "States",
                          //   style: TextStyle(fontSize: 16),
                          // ),
                          // const SizedBox(height: 7),
                          // DropdownButtonFormField(
                          //   value: postAdBloc.stateModel,
                          //   validator: (value) {
                          //     if (value == null) {
                          //       return null;
                          //     }
                          //     return null;
                          //   },
                          //   isExpanded: true,
                          //   decoration: const InputDecoration(
                          //     hintText: "Select State",
                          //   ),
                          //   items: postAdBloc.stateList.map<DropdownMenuItem<StateModel>>((e) {
                          //     return DropdownMenuItem(
                          //       value: e,
                          //       child: Text(e.name),
                          //     );
                          //   }).toList(),
                          //   onChanged: (value) {
                          //     postAdBloc.add(NewPostAdEventProductStateId(value!.id.toString(),value));
                          //   },
                          // ),
                          // const SizedBox(height: 16),
                          //
                          // ///City
                          // const Text(
                          //   "City",
                          //   style: TextStyle(fontSize: 16),
                          // ),
                          // const SizedBox(height: 7),
                          // DropdownButtonFormField(
                          //   value: postAdBloc.cityModel,
                          //   validator: (value) {
                          //     if (value == null) {
                          //       return null;
                          //     }
                          //     return null;
                          //   },
                          //   isExpanded: true,
                          //   decoration: const InputDecoration(
                          //     hintText: "Select City",
                          //   ),
                          //   items: postAdBloc.cityList.map<DropdownMenuItem<City>>((e) {
                          //     return DropdownMenuItem(
                          //       value: e,
                          //       child: Text(e.name),
                          //     );
                          //   }).toList(),
                          //   onChanged: (value) {
                          //     postAdBloc.add(NewPostAdEventProductCityId(value!.id.toString(),value));
                          //   },
                          // ),

                          ///Price
                          Obx(() => Visibility(
                                visible: controller.selectedCategoryId.value !=
                                        '10' &&
                                    controller.selectedCategoryId.value !=
                                        '18' &&
                                    controller.selectedCategoryId.value !=
                                        '2' &&
                                    controller.selectedCategoryId.value != '9',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16),
                                    const Text('Price'),
                                    const SizedBox(height: 6),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: controller.priceController,
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return null;
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Price"),
                                    )
                                  ],
                                ),
                              )),

                          Obx(() => Visibility(
                                visible: controller.selectedCategoryId.value ==
                                        "33" ||
                                    controller.selectedCategoryId.value ==
                                        "22" ||
                                    controller.selectedCategoryId.value ==
                                        "15" ||
                                    controller.selectedCategoryId.value ==
                                        "13" ||
                                    controller.selectedCategoryId.value ==
                                        "8" ||
                                    controller.selectedCategoryId.value ==
                                        "7" ||
                                    controller.selectedCategoryId.value ==
                                        "6" ||
                                    controller.selectedCategoryId.value ==
                                        "5" ||
                                    controller.selectedCategoryId.value ==
                                        "4" ||
                                    controller.selectedCategoryId.value ==
                                        "3" ||
                                    controller.selectedCategoryId.value == "1",
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Condition',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 6),
                                    Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.changeCondition("new");
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Obx(() => Radio(
                                                    activeColor: redColor,
                                                    value: "new",
                                                    groupValue: controller
                                                        .selectedCondition
                                                        .value,
                                                    onChanged: (value) {
                                                      controller
                                                          .changeCondition(
                                                              "new");
                                                    },
                                                  )),
                                              const Text("New"),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.changeCondition("used");
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Obx(() => Radio(
                                                    activeColor: redColor,
                                                    value: "used",
                                                    groupValue: controller
                                                        .selectedCondition
                                                        .value,
                                                    onChanged: (value) {
                                                      controller
                                                          .changeCondition(
                                                              "used");
                                                    },
                                                  )),
                                              const Text("Used"),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: controller.selectedCategoryId
                                                      .value ==
                                                  '1' ||
                                              controller.selectedCategoryId
                                                      .value ==
                                                  '22',
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.changeCondition(
                                                  "Reconditioned");
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Obx(() => Radio(
                                                      activeColor: redColor,
                                                      value: "Reconditioned",
                                                      groupValue: controller
                                                          .selectedCondition
                                                          .value,
                                                      onChanged: (value) {
                                                        controller
                                                            .changeCondition(
                                                                "Reconditioned");
                                                      },
                                                    )),
                                                const Text("Reconditioned"),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),

                          ///Category wise design start from here
                          Visibility(
                              visible: controller.selectedCategoryId.value ==
                                      '10' ||
                                  controller.selectedCategoryId.value == '18',
                              child: JobsField(controller: controller)),
                          Visibility(
                              visible:
                                  controller.selectedCategoryId.value == '13',
                              child: Education(controller: controller)),
                          Visibility(
                              visible: controller.selectedCategoryId.value ==
                                      '5' ||
                                  controller.selectedCategoryId.value == '21',
                              child: FashionField(controller: controller)),
                          Visibility(
                              visible:
                                  controller.selectedCategoryId.value == '7',
                              child: ElectronicField(controller: controller)),
                          Visibility(
                              visible:
                                  controller.selectedCategoryId.value == '3',
                              child: MobileField(controller: controller)),
                          Visibility(
                              visible:
                                  controller.selectedCategoryId.value == '9',
                              child: PropertyField(controller: controller)),
                          Visibility(
                              visible: controller.selectedCategoryId.value ==
                                      '1' ||
                                  controller.selectedCategoryId.value == '22',
                              child: VehiclesField(controller: controller)),

                          const SizedBox(height: 16),

                          ///Feature section
                          Visibility(
                            visible: controller.selectedCategoryId.value !=
                                    '9' &&
                                controller.selectedCategoryId.value != '12' &&
                                controller.selectedCategoryId.value != '13' &&
                                controller.selectedCategoryId.value != '17' &&
                                controller.selectedCategoryId.value != '18' &&
                                controller.selectedCategoryId.value != '19' &&
                                controller.selectedCategoryId.value != '20' &&
                                controller.selectedCategoryId.value != '21' &&
                                controller.selectedCategoryId.value != '22' &&
                                controller.selectedCategoryId.value != '25',
                            child: Obx(() => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Features"),
                                    const SizedBox(height: 8),
                                    ...List.generate(
                                        controller.featureList.length, (index) {
                                      final reversedIndex =
                                          controller.featureList.length -
                                              1 -
                                              index;
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ashColor)),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: SizedBox(
                                                      child: TextFormField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        maxLines: 1,
                                                        onChanged: (value) {
                                                          controller.featureList[
                                                                  index] =
                                                              value
                                                                  .toString()
                                                                  .trim();
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors
                                                              .transparent,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      0),
                                                          hintText:
                                                              reversedIndex == 0
                                                                  ? "Features"
                                                                  : "Another Feature",
                                                          hintStyle:
                                                              const TextStyle(
                                                            color: ashTextColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                          ),
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          errorBorder:
                                                              InputBorder.none,
                                                          border:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Material(
                                                    color: index ==
                                                            controller
                                                                    .featureList
                                                                    .length -
                                                                1
                                                        ? const Color(
                                                            0xFF157347)
                                                        : const Color(
                                                            0xFFBB2D3B),
                                                    shape: const CircleBorder(),
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (index ==
                                                            controller
                                                                    .featureList
                                                                    .length -
                                                                1) {
                                                          controller
                                                              .addContact();
                                                        } else {
                                                          controller
                                                              .removeContact(
                                                                  index);
                                                        }
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: index ==
                                                                controller
                                                                        .featureList
                                                                        .length -
                                                                    1
                                                            ? const Icon(
                                                                Icons.add,
                                                                size: 20,
                                                                color: Colors
                                                                    .white)
                                                            : const Icon(
                                                                Icons.close,
                                                                size: 20,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).reversed.toList(),
                                  ],
                                )),
                          ),

                          ///Description
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              Text('Description'),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            maxLines: 3,
                            // initialValue: state.description,
                            controller: controller.descriptionController,
                            textInputAction: TextInputAction.done,
                            decoration:
                                const InputDecoration(hintText: "Description"),
                          ),
                          const SizedBox(height: 16),

                          const Text('Featured Image'),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.pickImage().then((value) {});
                                },
                                child: Container(
                                  width: 150,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blueGrey.shade100,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text("Choose File"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Obx(() => controller.featureImage.value != ''
                                  ? Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          child: Container(
                                            padding: const EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                                color: ashTextColor
                                                    .withOpacity(0.4),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Image.file(
                                                File(controller
                                                    .featureImage.value),
                                                fit: BoxFit.cover,
                                                height: 70,
                                                width: 70),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                  onTap: () {
                                                    controller
                                                        .deleteFeatureImage();
                                                  },
                                                  child: const Icon(Icons.close,
                                                      color: Colors.red))),
                                        ),
                                      ],
                                    )
                                  : Container()),
                            ],
                          ),
                          const SizedBox(height: 16),

                          ///Images
                          const Row(
                            children: [
                              Text('Gallery Image'),
                              Text(" (Can add up to 5 only photos)")
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Obx(() =>
                          //     GridView.builder(
                          //       physics: const NeverScrollableScrollPhysics(),
                          //       shrinkWrap: true,
                          //       gridDelegate:
                          //           const SliverGridDelegateWithFixedCrossAxisCount(
                          //         crossAxisCount: 3,
                          //         crossAxisSpacing: 10,
                          //         mainAxisSpacing: 10,
                          //       ),
                          //       itemCount: controller.images.value.length + 1,
                          //       itemBuilder: (_, index) {
                          //         if (index == 0) {
                          //           return Material(
                          //             color: Colors.white,
                          //             borderRadius: BorderRadius.circular(3),
                          //             child: InkWell(
                          //               borderRadius: BorderRadius.circular(3),
                          //               onTap: () {
                          //                 controller
                          //                     .pickImages()
                          //                     .then((value) {});
                          //               },
                          //               child: Container(
                          //                 padding: const EdgeInsets.all(8),
                          //                 decoration: BoxDecoration(
                          //                   borderRadius:
                          //                       BorderRadius.circular(3),
                          //                   border: Border.all(color: ashColor),
                          //                 ),
                          //                 child: const Center(
                          //                   child: Icon(
                          //                     Icons.add_circle_outlined,
                          //                     color: redColor,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         }
                          //         return Obx(() => Stack(
                          //               children: [
                          //                 ClipRRect(
                          //                   borderRadius:
                          //                       BorderRadius.circular(3),
                          //                   child: Container(
                          //                     padding: const EdgeInsets.all(0),
                          //                     decoration: BoxDecoration(
                          //                         color: ashTextColor
                          //                             .withOpacity(0.4),
                          //                         borderRadius:
                          //                             BorderRadius.circular(3)),
                          //                     child: Image(
                          //                       image: FileImage(File(controller
                          //                           .images
                          //                           .value[index - 1]
                          //                           .path)),
                          //                       fit: BoxFit.cover,
                          //                       height: 118,
                          //                       width: 135,
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 Align(
                          //                   alignment: Alignment.topRight,
                          //                   child: InkWell(
                          //                     onTap: () {
                          //                       controller.deleteImage(index);
                          //                     },
                          //                     child: const Icon(Icons.close,
                          //                         color: Colors.red),
                          //                   ),
                          //                 )
                          //               ],
                          //             ));
                          //       },
                          //     )),

                          Obx(() =>  GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (_, index) {
                              if (index == 0) {
                                return Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(3),
                                    onTap: controller.images.length<6?() {
                                      Utils.showCustomDialog(context,child: Wrap(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text("Select Image Source",style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                                const SizedBox(height: 30,),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          controller.pickGalleryImageFromCamera().then((value) {
                                                            Navigator.of(context).pop();
                                                          });
                                                        },
                                                        child: Container(
                                                            alignment: Alignment.center,
                                                            color: const Color(0xFFDAD9D9),
                                                            height: MediaQuery.of(context).size.height * 0.1,
                                                            width: MediaQuery.of(context).size.width * 0.5,
                                                            child: const Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [Icon(Icons.camera_alt), Text('Camera')],
                                                            )),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 2,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 5,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          controller.pickGalleryImageFromGallery().then((value) {
                                                            Navigator.of(context).pop();
                                                          });
                                                        },
                                                        child: Container(
                                                            alignment: Alignment.center,
                                                            color: const Color(0xFFDAD9D9),
                                                            height: MediaQuery.of(context).size.height * 0.1,
                                                            width: MediaQuery.of(context).size.width * 0.5,
                                                            child: const Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [Icon(Icons.photo), Text('Gallery')],
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 20,),
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    style: TextButton.styleFrom(
                                                        backgroundColor: Colors.red,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5)
                                                        ),
                                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 1)
                                                    ),
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ));
                                    }:() {
                                      Utils.errorSnackBar(context,
                                          "You can't add more then 6 images");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(color: ashColor),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.add_circle_outlined,
                                              color: redColor,
                                            ),
                                            const SizedBox(height: 5),
                                            Text("${controller.images!.length}/6")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              else{
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    fit: StackFit.expand,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                            color: ashTextColor.withOpacity(0.4),
                                            borderRadius: BorderRadius.circular(3)),
                                        child: Image(
                                          image: FileImage(File(controller.images![index - 1].path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          child: GestureDetector(
                                              onTap: () {
                                                controller.removeImages(index);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                size: 18,
                                                color: Colors.red.shade900,
                                              )))
                                    ],
                                  ),
                                );
                              }
                            },
                            itemCount: controller.images!.length + 1,
                          )),


                          ///Contact info phone email
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              const Text(
                                'Contact Information',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),

                              ///Phone
                              Row(
                                children: [
                                  SizedBox(
                                      width: 30,
                                      height: 24,
                                      child: Obx(
                                        () => Checkbox(
                                          value: controller.isShowPhone.value,
                                          onChanged: (value) {
                                            controller.isShowPhone.value =
                                                !controller.isShowPhone.value;
                                          },
                                          activeColor: const Color(0xFF0b5ed7),
                                        ),
                                      )),
                                  const SizedBox(width: 0),
                                  const Text(
                                    'Show Phone To Public',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Phone',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    // initialValue: state.phone,
                                    controller: controller.phoneController,
                                    textInputAction: TextInputAction.next,
                                    // validator: (value) {
                                    //   if (value == null && state.isShowPhone) {
                                    //     return "Phone field is required";
                                    //   }
                                    //   return null;
                                    // },
                                    // onChanged: (value) => postAdBloc.add(NewPostAdEventPhone(value)),
                                    decoration: const InputDecoration(
                                        hintText: "Phone"),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),

                              ///Email
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    height: 24,
                                    child: Obx(() => Checkbox(
                                          value: controller.isShowEmail.value,
                                          onChanged: (value) {
                                            controller.isShowEmail.value =
                                                !controller.isShowEmail.value;
                                          },
                                          activeColor: const Color(0xFF0b5ed7),
                                        )),
                                  ),
                                  const SizedBox(width: 0),
                                  const Text(
                                    'Show Email To Public',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Email',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: controller.emailController,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                        hintText: 'Email'),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),

                              ///Whatsapp
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    height: 24,
                                    child: Obx(() => Checkbox(
                                          value:
                                              controller.isShowWhatsapp.value,
                                          onChanged: (value) {
                                            controller.isShowWhatsapp.value =
                                                !controller
                                                    .isShowWhatsapp.value;
                                          },
                                          activeColor: const Color(0xFF0b5ed7),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 0,
                                  ),
                                  Text(
                                    'Show Whatsapp To Public',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Whatsapp',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 7),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: controller.whatsappController,
                                    textInputAction: TextInputAction.done,
                                    decoration: const InputDecoration(
                                        hintText: 'Whatsapp'),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Website',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 7),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: controller.webSiteController,
                                    textInputAction: TextInputAction.done,
                                    decoration: const InputDecoration(
                                        hintText: 'Website'),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Obx(
                              //       () => Checkbox(
                              //         value: controller.isShowFeatured.value,
                              //         activeColor: const Color(0xFF0b5ed7),
                              //         onChanged: (value) {
                              //           controller.isShowFeatured.value =
                              //               !controller.isShowFeatured.value;
                              //         },
                              //       ),
                              //     ),
                              //     Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         Text.rich(TextSpan(
                              //             text: 'Mark as Featured ',
                              //             style: TextStyle(fontSize: 14),
                              //             children: [
                              //               TextSpan(
                              //                   text: 'R 177.00',
                              //                   style: TextStyle(
                              //                       fontWeight:
                              //                           FontWeight.w600))
                              //             ])),
                              //         SizedBox(
                              //           width: Get.width / 1.3,
                              //           child: Text(
                              //             "Make your listing unique on home and search page!",
                              //             style: TextStyle(color: Colors.grey),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),

                          ///Payment for feature ads
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.shade300),
                            child: Row(
                              children: [
                                Obx(() => Checkbox(
                                      value: controller.isPaymentChecked.value,
                                      onChanged: (value) {
                                        controller.changePaymentCheck();
                                      },
                                      activeColor: const Color(0xFF0b5ed7),
                                    )),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(() => Text(
                                              "Mark as featured £ ${controller.priority.value!.price.toStringAsFixed(2)}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        const SizedBox(
                                            child: Text(
                                          "Make your listing unique on home and search page!",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        )),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: Obx(() {
                                            List<Plannings> items =
                                                controller.items.value;
                                            return DropdownButton(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              value: controller
                                                          .priority.value ==
                                                      ""
                                                  ? null
                                                  : controller.priority.value,
                                              isExpanded: true,
                                              focusColor: Colors.red,
                                              iconEnabledColor: Colors.black,
                                              underline: const SizedBox(),
                                              icon: Container(),
                                              items:
                                                  items.map((Plannings items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items.title,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14)),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                controller
                                                    .changeItemValue(newValue!);
                                              },
                                            );
                                          }),
                                        ),
                                        // Drop
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(1, 1),
                              )
                            ]),
                            child: Row(
                              children: [
                                Expanded(
                                    child: SizedBox(
                                  height: 45,
                                  child: Obx(
                                    () => ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                      onPressed: () {
                                        Utils.closeKeyBoard(context);
                                        if (controller
                                            .featureFormKey.currentState!
                                            .validate()) {
                                          if (controller.isTitleOkay() &&
                                              controller.isPriceOkay(controller.selectedCategoryId.value) &&
                                              controller.isDescriptionOkay()) {
                                            controller.postAds(controller);
                                          } else if (!controller
                                              .isTitleOkay()) {
                                            Utils.toastMsg(
                                                'Please enter your title');
                                          } else if (!controller.isPriceOkay(controller.selectedCategoryId.value)) {
                                            Utils.toastMsg(
                                                'Please enter your product price');
                                          } else if (!controller
                                              .isDescriptionOkay()) {
                                            Utils.toastMsg(
                                                'Please enter your description');
                                          }
                                        }
                                      },
                                      child: controller.isPostAdsLoading.value
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                  color: Colors.white))
                                          : const Text(
                                              'Post Ad',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          )
                        ],
                      ))))
        ]));
  }
}
