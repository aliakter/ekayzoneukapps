import 'dart:io';
import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/custom_image.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/data/remote_urls.dart';
import 'package:ekayzoneukapps/apps/global_widget/categories_model.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/category_wise/edit_education.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/category_wise/edit_electronic.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/category_wise/edit_fashion.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/category_wise/edit_jobs.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/category_wise/edit_mobile.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/category_wise/edit_property.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/category_wise/edit_vehicles.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/controller/ad_edit_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/controller/home_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/models/sub_category_model.dart';
import 'package:ekayzoneukapps/apps/views/splash/localization/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdsEditScreen extends StatelessWidget {
  const AdsEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdEditController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Ad Update"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: iconThemeColor,
            ),
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      sliver: SliverToBoxAdapter(
                        child: Form(
                          key: controller.featureFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text.rich(TextSpan(
                                      text: 'Post an ad for ',
                                      children: [
                                        TextSpan(
                                            text:
                                                '(${controller.category == null ? '' : controller.category.value?.name})',
                                            style: const TextStyle(
                                                color: Colors.lightBlueAccent))
                                      ]))),
                              const SizedBox(height: 6),

                              ///title
                              const Row(
                                children: [
                                  Text("Title"),
                                  Text(
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    Utils.toastMsg('Enter title');
                                    return 'Enter title';
                                  }
                                  return null;
                                },
                                decoration:
                                    const InputDecoration(hintText: "Title"),
                              ),
                              const SizedBox(height: 16),

                              ///sub-category
                              Text("Sub Category"),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<Branding>(
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  hintText: "Sub Category",
                                ),
                                value: controller.subcategory,
                                items: controller.subcategoryList
                                    .map<DropdownMenuItem<Branding>>((e) {
                                  return DropdownMenuItem<Branding>(
                                    value: e,
                                    child: Text(e.name),
                                  );
                                }).toList(),
                                onChanged: (Branding? value) {
                                  controller.selectedSubcategory.value =
                                      value!.id.toString();
                                },
                              ),

                              ///Address
                              const SizedBox(height: 16),
                              const Text("Location"),
                              const SizedBox(height: 6),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: controller.locationController,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    const InputDecoration(hintText: "Location"),
                              ),

                              ///Price
                              Visibility(
                                visible: controller.selectedCategory.value !=
                                        '10' &&
                                    controller.selectedCategory.value != '2' &&
                                    controller.selectedCategory.value != '9' &&
                                    controller.selectedCategory.value != '18',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16),
                                    const Text("Price"),
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
                              ),

                              ///Condition
                              Visibility(
                                visible: controller.selectedCategory.value ==
                                        "33" ||
                                    controller.selectedCategory.value == "22" ||
                                    controller.selectedCategory.value == "15" ||
                                    controller.selectedCategory.value == "13" ||
                                    controller.selectedCategory.value == "8" ||
                                    controller.selectedCategory.value == "7" ||
                                    controller.selectedCategory.value == "6" ||
                                    controller.selectedCategory.value == "5" ||
                                    controller.selectedCategory.value == "4" ||
                                    controller.selectedCategory.value == "3" ||
                                    controller.selectedCategory.value == "1",
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16),
                                    Text(
                                      'Condition',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 7),
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
                                                    .selectedCondition.value,
                                                onChanged: (value) {
                                                  controller
                                                      .changeCondition("new");
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
                                                    .selectedCondition.value,
                                                onChanged: (value) {
                                                  controller
                                                      .changeCondition("used");
                                                },
                                              )),
                                              const Text("Used"),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: controller
                                                      .selectedCategory.value ==
                                                  '1' ||
                                              controller
                                                      .selectedCategory.value ==
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
                                                      .selectedCondition.value,
                                                  onChanged: (value) {
                                                    controller.changeCondition(
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
                              ),

                              ///Category wise design start from here
                              // LayoutBuilder(
                              //   builder: (context, constraints) {
                              //     if (controller.selectedCategory == '10') {
                              //       return JobsField(controller: controller);
                              //     } else if (controller.selectedCategory ==
                              //         '5') {
                              //       return FashionField(controller: controller);
                              //     } else if (controller.selectedCategory ==
                              //         '4') {
                              //       return ElectronicField(
                              //           controller: controller);
                              //     } else if (controller.selectedCategory ==
                              //         '3') {
                              //       return MobileField(controller: controller);
                              //     } else if (controller.selectedCategory ==
                              //         '2') {
                              //       return PropertyField(
                              //           controller: controller);
                              //     } else if (controller.selectedCategory ==
                              //         '1') {
                              //       return VehiclesField(
                              //           controller: controller);
                              //     }
                              //     return const SizedBox();
                              //   },
                              // ),

                              Visibility(
                                  visible: controller.selectedCategory.value ==
                                          '10' ||
                                      controller.selectedCategory.value == '18',
                                  child: EditJobsField(controller: controller)),
                              Visibility(
                                  visible:
                                      controller.selectedCategory.value == '13',
                                  child: EditEducation(controller: controller)),
                              Visibility(
                                  visible: controller.selectedCategory.value ==
                                          '5' ||
                                      controller.selectedCategory.value == '21',
                                  child:
                                      EditFashionField(controller: controller)),
                              Visibility(
                                  visible:
                                      controller.selectedCategory.value == '7',
                                  child: EditElectronicField(
                                      controller: controller)),
                              Visibility(
                                  visible:
                                      controller.selectedCategory.value == '3',
                                  child:
                                      EditMobileField(controller: controller)),
                              Visibility(
                                  visible:
                                      controller.selectedCategory.value == '9',
                                  child: EditPropertyField(
                                      controller: controller)),
                              Visibility(
                                  visible: controller.selectedCategory.value ==
                                          '1' ||
                                      controller.selectedCategory.value == '22',
                                  child: EditVehiclesField(
                                      controller: controller)),

                              const SizedBox(height: 16),

                              ///Feature section
                              Visibility(
                                visible: controller.selectedCategory.value !=
                                        '9' &&
                                    controller.selectedCategory.value != '12' &&
                                    controller.selectedCategory.value != '13' &&
                                    controller.selectedCategory.value != '17' &&
                                    controller.selectedCategory.value != '18' &&
                                    controller.selectedCategory.value != '19' &&
                                    controller.selectedCategory.value != '20' &&
                                    controller.selectedCategory.value != '21' &&
                                    controller.selectedCategory.value != '22' &&
                                    controller.selectedCategory.value != '25',
                                child: Obx(() => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Features"),
                                        const SizedBox(height: 8),
                                        ...List.generate(
                                            controller.featureList.value.length,
                                            (index) {
                                          final reversedIndex = controller
                                                  .featureList.value.length -
                                              1 -
                                              index;
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: ashColor)),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: SizedBox(
                                                          child: TextFormField(
                                                            initialValue:
                                                                controller
                                                                    .featureList
                                                                    .value[reversedIndex],
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            maxLines: 1,
                                                            onChanged: (value) {
                                                              controller.featureList
                                                                          .value[
                                                              reversedIndex] =
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
                                                              hintText: reversedIndex ==
                                                                      0
                                                                  ? "Features"
                                                                  : "Another Feature",
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    ashTextColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14,
                                                              ),
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              errorBorder:
                                                                  InputBorder
                                                                      .none,
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Material(
                                                        color: index ==
                                                                controller
                                                                        .featureList
                                                                        .value
                                                                        .length -
                                                                    1
                                                            ? const Color(
                                                                0xFF157347)
                                                            : const Color(
                                                                0xFFBB2D3B),
                                                        shape:
                                                            const CircleBorder(),
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (index ==
                                                                controller
                                                                        .featureList
                                                                        .value
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
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child: index ==
                                                                    controller
                                                                            .featureList
                                                                            .value
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
                              const SizedBox(height: 16),
                              const Row(
                                children: [
                                  Text("Description"),
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
                                controller: controller.descriptionController,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    Utils.toastMsg('Enter Description');
                                    return 'Enter Description';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Description"),
                              ),
                              const SizedBox(height: 16),

                              const Text("Featured Image"),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.pickThumbImage();
                                    },
                                    child: Container(
                                      width: 150,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blueGrey.shade100,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text("Choose File"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  controller.featureImage.value != ""
                                      ? ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(3),
                                        child: Container(
                                          padding: const EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                              color: ashTextColor
                                                  .withOpacity(0.4),
                                              borderRadius:
                                              BorderRadius.circular(3)),
                                          child: Center(
                                            child: SizedBox(
                                              height: 70,
                                              width: 70,
                                              child: Image(
                                                image: FileImage(File("${controller.featureImage}")),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      : ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(3),
                                    child: Container(
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                          color: ashTextColor
                                              .withOpacity(0.4),
                                          borderRadius:
                                          BorderRadius.circular(3)),
                                      child: CustomImage(path: "${RemoteUrls.rootUrl}${controller.adEditModel?.thumbnail}",fit: BoxFit.cover,
                                          height: 70,
                                          width: 70),
                                    ),
                                  ),
                                  // Expanded(
                                  //     child: SizedBox(
                                  //   child: Text(
                                  //     controller.thumbImage != null
                                  //         ? controller.base64ImageThumb.value
                                  //         : controller.adEditModel?.thumbnail ??
                                  //             "",
                                  //     overflow: TextOverflow.ellipsis,
                                  //   ),
                                  // ))
                                ],
                              ),
                              const SizedBox(height: 16),

                              /// ............. I M A G E ...............
                              const Text(
                                  "Gallery Images  (Can add up to 6 only photos)"),
                              // const SizedBox(height: 6),

                              ///.............. Old Images ..............
                              Visibility(
                                visible: controller.imageGallery.isNotEmpty,
                                child: GridView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: controller.imageGallery.length,
                                  itemBuilder: (_, index) {
                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                                color: ashTextColor
                                                    .withOpacity(0.4),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: CustomImage(
                                              path:
                                                  "${RemoteUrls.rootUrl}${controller.imageGallery[index].image}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Material(
                                          color:
                                              Colors.black87.withOpacity(0.6),
                                          shape: const CircleBorder(),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            onTap: () {
                                              controller.deleteImages(index);
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.delete,
                                                  size: 24,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              // GridView.builder(
                              //   physics: const NeverScrollableScrollPhysics(),
                              //   shrinkWrap: true,
                              //   gridDelegate:
                              //       const SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount: 3,
                              //     crossAxisSpacing: 10,
                              //     mainAxisSpacing: 10,
                              //   ),
                              //   itemCount: controller.images!.length + 1,
                              //   itemBuilder: (_, index) {
                              //     if (index == 0) {
                              //       return Material(
                              //         color: Colors.white,
                              //         borderRadius: BorderRadius.circular(3),
                              //         child: InkWell(
                              //           borderRadius: BorderRadius.circular(3),
                              //           onTap: () {
                              //             controller.pickImages().then((value) {
                              //               controller.imageList = value ?? [];
                              //             });
                              //           },
                              //           child: Container(
                              //             padding: const EdgeInsets.all(8),
                              //             decoration: BoxDecoration(
                              //               borderRadius:
                              //                   BorderRadius.circular(3),
                              //               border: Border.all(color: ashColor),
                              //             ),
                              //             child: const Center(
                              //               child: Icon(
                              //                 Icons.add_circle_outlined,
                              //                 color: redColor,
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     }
                              //     return ClipRRect(
                              //       borderRadius: BorderRadius.circular(3),
                              //       child: Container(
                              //         padding: const EdgeInsets.all(0),
                              //         decoration: BoxDecoration(
                              //             color: ashTextColor.withOpacity(0.4),
                              //             borderRadius:
                              //                 BorderRadius.circular(3)),
                              //         child: Image(
                              //           image: FileImage(File(controller
                              //               .images![index - 1].path)),
                              //           fit: BoxFit.cover,
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),

                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.images!.length + 1,
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
                                        onTap: controller.images!.length+controller.imageGallery.length<6?() {
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
                                                Text("${controller.images!.length+controller.imageGallery.length}/6")
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
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
                                            // image: FileImage(File(controller.images2![index].path))
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
                                                ),),)
                                      ],
                                    ),
                                  );
                                },
                              ),


                              ///Contact info phone email
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Contact Information",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16),

                                  ///Phone
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            height: 24,
                                            child: Obx(() => Checkbox(
                                                  value: controller
                                                      .receiveIsPhone.value,
                                                  onChanged: (value) {
                                                    controller.receiveIsPhone
                                                        .value = value!;
                                                  },
                                                  activeColor:
                                                      const Color(0xFF0b5ed7),
                                                )),
                                          ),
                                          const SizedBox(width: 0),
                                          const Text(
                                            "Show phone to public",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "Phone",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(height: 7),
                                          TextFormField(
                                            controller:
                                                controller.phoneController,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: const InputDecoration(
                                                hintText: "Phone"),
                                          ),
                                          const SizedBox(height: 16),
                                        ],
                                      ),
                                    ],
                                  ),

                                  ///Email
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            height: 24,
                                            child: Obx(() => Checkbox(
                                                  value: controller
                                                      .receiveIsEmail.value,
                                                  onChanged: (value) {
                                                    controller.receiveIsEmail
                                                        .value = value!;
                                                  },
                                                  activeColor:
                                                      const Color(0xFF0b5ed7),
                                                )),
                                          ),
                                          const SizedBox(width: 0),
                                          const Text(
                                            "Show email to public",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "Email",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(height: 7),
                                          TextFormField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller:
                                                controller.emailController,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: const InputDecoration(
                                                hintText: "Email"),
                                          ),
                                          const SizedBox(height: 16),
                                        ],
                                      ),
                                    ],
                                  ),

                                  ///Whatsapp
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            height: 24,
                                            child: Obx(() => Checkbox(
                                                  value: controller
                                                      .receiveIsWhatsApp.value,
                                                  onChanged: (value) {
                                                    controller.receiveIsWhatsApp
                                                        .value = value!;
                                                  },
                                                  activeColor:
                                                      const Color(0xFF0b5ed7),
                                                )),
                                          ),
                                          const SizedBox(width: 0),
                                          const Text(
                                            "Show whatsapp to public",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "Whatsapp",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(height: 7),
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                controller.whatsappController,
                                            textInputAction:
                                                TextInputAction.next,
                                            // onChanged: (value) => postAdBloc.add(NewPostAdEventWhatsapp(value)),
                                            decoration: const InputDecoration(
                                                hintText: "Whatsapp"),
                                          ),
                                          const SizedBox(height: 16),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              ///Website
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Website"),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: controller.webSiteController,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                        hintText: "Website"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              ///Website
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Status"),
                                  const SizedBox(height: 6),
                                  DropdownButtonFormField(
                                    value: controller.statusEditType,
                                    decoration: const InputDecoration(
                                      hintText: "Select One",
                                    ),
                                    items: controller.statusTypeEditList
                                        .map<DropdownMenuItem<String>>((e) {
                                      return DropdownMenuItem(
                                        value: e['value'],
                                        child: Text("${e['title']}"),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.statusEditType = value!;
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 42,
                                child: Obx(
                                  () => ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6))),
                                    onPressed: () {
                                      Utils.closeKeyBoard(context);
                                      if (controller
                                          .featureFormKey.currentState!
                                          .validate()) {
                                        controller.updateAds();
                                      }
                                    },
                                    child: controller.isUpdateAdsLoading.value
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.white))
                                        : const Text(
                                            'Update',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      );
    });
  }
}
