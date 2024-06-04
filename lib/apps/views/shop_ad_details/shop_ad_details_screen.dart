import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/custom_image.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/data/remote_urls.dart';
import 'package:ekayzoneukapps/apps/routes/routes.dart';
import 'package:ekayzoneukapps/apps/views/ad_details/component/image_slider.dart';
import 'package:ekayzoneukapps/apps/views/home/component/list_product_card.dart';
import 'package:ekayzoneukapps/apps/views/home/component/shimmer_list.dart';
import 'package:ekayzoneukapps/apps/views/home/controller/home_controller.dart';
import 'package:ekayzoneukapps/apps/views/shop_ad_details/controllers/shop_ad_details_controller.dart';
import 'package:ekayzoneukapps/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopAdDetailsScreen extends StatelessWidget {
  const ShopAdDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('#Gotcha');
    ShopAdDetailsController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ad Details"),
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
      body: RefreshIndicator(
        onRefresh: () async {
          return controller.getAdDetails();
        },
        child: Obx(
          () => controller.isLoadings.value
              ? const Center(child: ShimmerList())
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: ImageSlider(
                          gallery: controller
                              .adDetailsModel.value!.adDetails.galleries,
                          isFeatured: controller
                              .adDetailsModel.value!.adDetails.featured),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      sliver: SliverToBoxAdapter(
                        child: InkWell(
                          onTap: () {
                            var userId = sharedPreferences.getString("userId");
                            if (userId == null) {
                              Get.snackbar("Warning", 'Login please',
                                  colorText: Colors.red.shade300,
                                  backgroundColor: Colors.white);
                            } else {
                              if (controller.isMe(controller.adDetailsModel
                                  .value!.adDetails.customer.id)) {
                                Get.snackbar("Can not report",
                                    "You can not report with your ads");
                              } else {
                                showReportDialog(
                                    context,
                                    controller
                                        .adDetailsModel.value!.adDetails.id,
                                    controller);
                              }
                            }
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.report, size: 20),
                              SizedBox(width: 5),
                              Text("Report this Ad")
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///ADS DETAILS AND SHARE OPTIONS
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    offset: const Offset(0, 0),
                                    blurRadius: 3),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                controller.adDetailsModel.value!.adDetails
                                            .price !=
                                        null
                                    ? "£ ${controller.adDetailsModel.value!.adDetails.price.toStringAsFixed(2).toString()}"
                                    : "Negotiable",
                                style: GoogleFonts.lato(
                                    fontSize: 20,
                                    color: redColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  controller
                                      .adDetailsModel.value!.adDetails.title,
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 1),
                                ),
                              ),

                              ///Category
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.category !=
                                    null,
                                child: Row(
                                  children: [
                                    Transform.rotate(
                                      angle: -5,
                                      child: const Icon(
                                        Icons.local_offer_outlined,
                                        size: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Row(
                                      children: [
                                        Text(
                                          "Category: ",
                                          style: GoogleFonts.lato(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "${controller.adDetailsModel.value!.adDetails.category?.name}",
                                          style: GoogleFonts.lato(
                                              fontSize: 14,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              ///Subcategory
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.subcategory !=
                                    null,
                                child: Row(
                                  children: [
                                    Transform.rotate(
                                        angle: 0,
                                        child: const Icon(
                                          Icons.local_movies_outlined,
                                          size: 14,
                                          color: Colors.black54,
                                        )),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: SizedBox(
                                        child: Row(
                                          children: [
                                            Text(
                                              "Sub-Category: ",
                                              style: GoogleFonts.lato(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Container(
                                              width: Get.width/1.7,
                                              child: Text(
                                                "${controller.adDetailsModel.value!.adDetails.subcategory?.name}",
                                                style: GoogleFonts.lato(
                                                    fontSize: 14,
                                                    color: Colors.black54),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ///Location
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.address !=
                                    '',
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(width: 5),
                                    Row(
                                      children: [
                                        Text(
                                          "Location: ",
                                          style: GoogleFonts.lato(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Container(
                                          width: Get.width / 1.5,
                                          child: Text(
                                            controller.adDetailsModel.value!
                                                .adDetails.address,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.post_add,
                                    size: 16,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "Ad Posted: ",
                                        style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        Utils.timeAgo(controller
                                            .adDetailsModel
                                            .value!
                                            .adDetails
                                            .customer
                                            .createdAt),
                                        style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              ///Chat with seller button
                              SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  style: OutlinedButton.styleFrom(
                                    elevation: 5,
                                    shadowColor: Colors.grey.shade300,
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (controller.token != "") {
                                      if (controller.isMe(controller
                                          .adDetailsModel
                                          .value!
                                          .adDetails
                                          .customer
                                          .id)) {
                                        Utils.showSnackBar(context,
                                            "You can not message with yourself");
                                        return;
                                      } else {
                                        Get.toNamed(Routes.chatDetails,
                                            arguments: controller
                                                .adDetailsModel
                                                .value!
                                                .adDetails
                                                .customer
                                                .username);
                                      }
                                    } else {
                                      Get.snackbar("Warning", 'Login please',
                                          colorText: Colors.red.shade300,
                                          backgroundColor: Colors.white);
                                    }
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.message, size: 18),
                                      SizedBox(width: 10),
                                      Text(
                                        "Chat With Seller",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              ///Phone button
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.showPhone &&
                                    controller.adDetailsModel.value!.adDetails
                                        .phone.isNotEmpty,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      height: 48,
                                      child: ElevatedButton(
                                        style: OutlinedButton.styleFrom(
                                          elevation: 5,
                                          shadowColor: Colors.grey.shade300,
                                          backgroundColor: redColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (controller.token != "") {
                                            phoneCall(
                                                controller.adDetailsModel.value!
                                                    .adDetails.phone,
                                                context);
                                          } else {
                                            Get.snackbar(
                                                "Warning", 'Login please',
                                                colorText: Colors.red.shade300,
                                                backgroundColor: Colors.white);
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.phone, size: 18),
                                            const SizedBox(width: 10),
                                            Text(
                                              controller.token != ""
                                                  ? controller.adDetailsModel
                                                      .value!.adDetails.phone
                                                  : "Login to View Phone",
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ///Email button
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                            .adDetails.showEmail ==
                                        1 &&
                                    controller.adDetailsModel.value!.adDetails
                                        .email.isNotEmpty,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      height: 48,
                                      child: ElevatedButton(
                                        style: OutlinedButton.styleFrom(
                                          elevation: 5,
                                          shadowColor: Colors.grey.shade300,
                                          backgroundColor: redColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (controller.token != "") {
                                            sendEmail(
                                                controller.adDetailsModel.value!
                                                    .adDetails.email,
                                                context);
                                          } else {
                                            Get.snackbar(
                                                "Warning", 'Login please',
                                                colorText: Colors.red.shade300,
                                                backgroundColor: Colors.white);
                                          }
                                        },
                                        child: SizedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.phone, size: 18),
                                              const SizedBox(width: 10),
                                              Text(
                                                controller.token != ""
                                                    ? controller.adDetailsModel
                                                        .value!.adDetails.email
                                                    : "Login to View Email",
                                                style: const TextStyle(
                                                    fontSize: 14),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),

                              ///Whatsapp button
                              SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  style: OutlinedButton.styleFrom(
                                    elevation: 5,
                                    shadowColor: Colors.grey.shade300,
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (controller.token != "") {
                                      sendWhatsappMessage(
                                          "https://api.whatsapp.com/send?phone=${controller.adDetailsModel.value!.adDetails.whatsapp}&text=Hello there",
                                          context);
                                    } else {
                                      Get.snackbar("Warning", 'Login please',
                                          colorText: Colors.red.shade300,
                                          backgroundColor: Colors.white);
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/whatsapp.png",
                                          height: 25.h),
                                      const SizedBox(width: 10),
                                      Text(
                                        controller.token != ""
                                            ? "Send Message via whatsapp"
                                            : "Login to Chat with Whatsapp",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                        child: Text(
                                      "Safety tips",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )),
                                    SizedBox(height: 10),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.alarm_off_outlined,
                                              color: redColor),
                                          SizedBox(width: 5),
                                          Icon(Icons.group_outlined,
                                              color: redColor),
                                          SizedBox(width: 5),
                                          Icon(Icons.visibility_outlined,
                                              color: redColor),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.credit_card_off_outlined,
                                            color: redColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text("* Avoid paying inspection fees"),
                                    Text(
                                        "* If possible, go for viewing with friends"),
                                    Text(
                                        "* Check everything carefully to make sure it's what \n   you need"),
                                    Text(
                                        "* Don't pay in advance if it's impossible to move in \n   immediately")
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Share This Ad",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),

                              const SizedBox(height: 10),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Share.share(
                                          '${RemoteUrls.rootUrl}ad/details/${controller.adDetailsModel.value!.adDetails.slug}',
                                          subject:
                                              'Click bellow the link to share EkayzoneUK product');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(17),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/social/facebook.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Share.share(
                                          '${RemoteUrls.rootUrl}ad/details/${controller.adDetailsModel.value!.adDetails.slug}',
                                          subject:
                                              'Click bellow the link to share EkayzoneUK product');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(17),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/social/twitter.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Share.share(
                                          '${RemoteUrls.rootUrl}ad/details/${controller.adDetailsModel.value!.adDetails.slug}',
                                          subject:
                                              'Click bellow the link to share EkayzoneUK product');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(17),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/social/linkedin.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Share.share(
                                          '${RemoteUrls.rootUrl}ad/details/${controller.adDetailsModel.value!.adDetails.slug}',
                                          subject:
                                              'Click bellow the link to share EkayzoneUK product');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(17),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/social/whatsapp.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Share.share(
                                          '${RemoteUrls.rootUrl}ad/details/${controller.adDetailsModel.value!.adDetails.slug}',
                                          subject:
                                              'Click bellow the link to share EkayzoneUK product');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(17),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/social/mail.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Share.share(
                                          '${RemoteUrls.rootUrl}ad/details/${controller.adDetailsModel.value!.adDetails.slug}',
                                          subject:
                                              'Click bellow the link to share EkayzoneUK product');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(17),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/social/pinterest.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///DESCRIPTION SECTION
                    SliverPadding(
                      padding: const EdgeInsets.all(10),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    offset: const Offset(0, 0),
                                    blurRadius: 3),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.authenticity !=
                                    null,
                                child: Text(
                                    "Authenticity: ${controller.adDetailsModel.value!.adDetails.authenticity}"),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.edition !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Edition: ${controller.adDetailsModel.value!.adDetails.edition}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.brand !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Brand: ${controller.adDetailsModel.value!.adDetails.brand != null ? controller.adDetailsModel.value!.adDetails.brand!.name : ''}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.model !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Models: ${controller.adDetailsModel.value!.adDetails.model}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.yearOfManufacture !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Manufacture Year: ${controller.adDetailsModel.value!.adDetails.yearOfManufacture}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.engineCapacity !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Engine Capacity: ${controller.adDetailsModel.value!.adDetails.engineCapacity} Cc"),
                                  ],
                                ),
                              ),
                              // Visibility(
                              //   visible: controller
                              //           .adDetailsModel!.adDetails.fuelType !=
                              //       [],
                              //   child: Column(
                              //     children: [
                              //       const SizedBox(height: 5),
                              //       SizedBox(
                              //         child: Text(
                              //           "Fuel Type: ${controller.adDetailsModel.value!.adDetails.fuelType}",
                              //           maxLines: 1,
                              //           overflow: TextOverflow.ellipsis,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.transmission !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Transmission: ${controller.adDetailsModel.value!.adDetails.transmission}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.bodyType !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Body Type: ${controller.adDetailsModel.value!.adDetails.bodyType}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.condition !=
                                    "",
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Condition: ${controller.adDetailsModel.value!.adDetails.condition}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.registrationYear !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Registration Year: ${controller.adDetailsModel.value!.adDetails.registrationYear}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.designation !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Designation: ${controller.adDetailsModel.value!.adDetails.designation}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.experience !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Experience Year: ${controller.adDetailsModel.value!.adDetails.experience}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.educations !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Employment Type: ${controller.adDetailsModel.value!.adDetails.educations}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.deadline !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    controller.adDetailsModel.value!.adDetails
                                                .deadline !=
                                            null
                                        ? Text(
                                            "Deadline: ${Utils.formatDate("${controller.adDetailsModel.value!.adDetails.deadline}")}")
                                        : Text(
                                            "${controller.adDetailsModel.value!.adDetails.deadline}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.employerName !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Employer Name: ${controller.adDetailsModel.value!.adDetails.employerName}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.propertyType !=
                                    null,
                                child: Row(
                                  children: [
                                    const SizedBox(height: 5),
                                    const Text("Property type: "),
                                    Text(
                                        "${controller.adDetailsModel.value!.adDetails.propertyType}"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.adDetailsModel.value!
                                        .adDetails.sizeType !=
                                    null,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Property Size: ${controller.adDetailsModel.value!.adDetails.size} ${controller.adDetailsModel.value!.adDetails.sizeType}"),
                                  ],
                                ),
                              ),
                              // const SizedBox(height: 5),
                              // Visibility(
                              //   visible: true,
                              //   visible: controller.adDetailsModel.value!.adDetails.website.isNotEmpty,
                              //   child: Row(
                              //     children: [
                              //       const Text("Website: "),
                              //       GestureDetector(
                              //         onTap: () {
                              //           // urlLaunch(state
                              //           //     .adDetailsResponseModel.adDetails.website);
                              //         },
                              //         child: const Text(
                              //           "View Site",
                              //           style: TextStyle(color: Colors.blue),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "Description",
                                  style: GoogleFonts.lato(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Html(
                                  data: controller.adDetailsModel.value!
                                      .adDetails.description),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///SELLER INFORMATION'S SECTION
                    SliverPadding(
                      padding: const EdgeInsets.all(10),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    offset: const Offset(0, 0),
                                    blurRadius: 3),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Seller Information",
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: paragraphColor,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CustomImage(
                                    path: controller.adDetailsModel.value!
                                                .adDetails.customer.image !=
                                            ''
                                        ? '${RemoteUrls.rootUrl}${controller.adDetailsModel.value!.adDetails.customer.image}'
                                        : null,
                                    height: 60.h,
                                    width: 60.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  controller.adDetailsModel.value!.adDetails
                                          .customer.name ??
                                      "",
                                  style: GoogleFonts.lato(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RatingBarIndicator(
                                      rating: double.parse(controller
                                          .adDetailsModel
                                          .value!
                                          .adDetails
                                          .customer
                                          .averageReview),
                                      itemCount: 5,
                                      itemSize: 15.5,
                                      direction: Axis.horizontal,
                                      itemPadding:
                                          const EdgeInsets.only(right: 2),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star_border,
                                        color: Color(0xffF0A732),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      controller.adDetailsModel.value!.adDetails
                                          .customer.totalReview
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(" reviews"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Joined: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(DateFormat.yMMMMd().format(
                                        DateTime.parse(controller
                                            .adDetailsModel
                                            .value!
                                            .adDetails
                                            .customer
                                            .createdAt))),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Total Listed Ads "),
                                    Text(
                                        controller.adDetailsModel.value!
                                            .adDetails.customer.totalAds
                                            .toString(),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 140,
                                child: ElevatedButton(
                                  style: OutlinedButton.styleFrom(
                                    elevation: 5,
                                    shadowColor: Colors.grey.shade300,
                                    backgroundColor: redColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.toNamed(Routes.publicProfile,
                                        arguments: controller
                                            .adDetailsModel
                                            .value!
                                            .adDetails
                                            .customer
                                            .username);
                                  },
                                  child: const SizedBox(
                                    child: Text(
                                      "Member Shop",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///RELATED ADS SECTION
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recommended ads for you",
                              style: GoogleFonts.lato(
                                fontSize: 14.sp,
                                height: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 270,
                              child: controller.adDetailsModel.value!.relatedAds
                                      .isNotEmpty
                                  ? ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(width: 10);
                                      },
                                      itemCount: controller.adDetailsModel
                                          .value!.relatedAds.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.changeSlug(controller
                                                .adDetailsModel
                                                .value!
                                                .relatedAds[index]
                                                .slug);
                                          },
                                          child: ListProductCard(
                                            adsModel: controller.adDetailsModel
                                                .value!.relatedAds[index],
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
                                                    colorText:
                                                        Colors.red.shade300,
                                                    backgroundColor:
                                                        Colors.white);
                                              } else {
                                                if (int.parse(userId) ==
                                                    controller
                                                        .adDetailsModel
                                                        .value!
                                                        .relatedAds[index]
                                                        .userId) {
                                                  Utils.showSnackBar(context,
                                                      "You can not add your ads to your favorite list ");
                                                } else {
                                                  controller
                                                          .adDetailsModel
                                                          .value!
                                                          .relatedAds[index]
                                                          .isWishlist =
                                                      !controller
                                                          .adDetailsModel
                                                          .value!
                                                          .relatedAds[index]
                                                          .isWishlist;
                                                  Get.find<HomeController>()
                                                      .setUnsetWishlist(
                                                          controller
                                                              .adDetailsModel
                                                              .value!
                                                              .relatedAds[index]
                                                              .id
                                                              .toString());
                                                  controller.update();
                                                }
                                              }
                                            },
                                          ),
                                        );
                                      },
                                    )
                                  : const Center(child: Text("No ads found")),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  ],
                ),
        ),
      ),
    );
  }

  phoneCall(phoneNumber, context) async {
    if (phoneNumber.toString().isNotEmpty) {
      final url = Uri.parse('tel:$phoneNumber');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No phone number found')));
    }
  }

  sendEmail(email, context) async {
    if (email.toString().isNotEmpty) {
      final url = Uri.parse('mailto:$email');
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No Email has found')));
    }
  }

  Future<void> sendWhatsappMessage(url, context) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url),
            webViewConfiguration: const WebViewConfiguration(
              enableJavaScript: true,
              enableDomStorage: true,
            ),
            mode: LaunchMode.externalApplication);
      }
    } on Exception {
    } catch (e) {
      print(e.toString());
    }
  }

  ///Launch url
  Future<void> urlLaunch(url) async {
    await launchUrl(Uri.parse(url),
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
        mode: LaunchMode.externalApplication);
  }

  showReportDialog(context, adId, controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: SizedBox(
                  child: Text(
                    "Is there something wrong with this ad?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close))
            ],
          ),
          content: Column(
            children: [
              const Text(
                  "We're constantly working hard to assure that our ads meet high standards and we are very grateful for any kind of feedback from our users."),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text("Reason"),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300)),
                child: DropdownButtonFormField(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  borderRadius: BorderRadius.circular(10),
                  decoration: const InputDecoration(hintText: "Select reason"),
                  items: reasonTypeList.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.reasonType = value!;
                  },
                  validator: (value) {
                    if (value == null) {
                      return null;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text("Email"),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailController,
                textInputAction: TextInputAction.next,
                onChanged: (value) {},
                decoration: const InputDecoration(hintText: "Enter your email"),
                validator: (value) {
                  if (value == "") {
                    return null;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text("Message"),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              TextFormField(
                controller: controller.messageController,
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration:
                    const InputDecoration(hintText: "Enter your message"),
                onChanged: (value) {},
                validator: (value) {
                  if (value == "") {
                    return null;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffdc3545),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Close'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.checkValidationForAdReport(
                              adId: adId.toString());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: redColor,
                          foregroundColor: Colors.white,
                        ),
                        child: Obx(() => controller.isReportLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )
                            : const Text('Submit')),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
