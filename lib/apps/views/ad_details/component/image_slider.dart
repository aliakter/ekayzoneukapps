import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekayzoneukapps/apps/core/utils/custom_image.dart';
import 'package:ekayzoneukapps/apps/data/remote_urls.dart';
import 'package:ekayzoneukapps/apps/routes/routes.dart';
import 'package:ekayzoneukapps/apps/views/ad_details/model/ad_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key, required this.gallery, required this.isFeatured})
      : super(key: key);

  final List<Gallery> gallery;
  final int isFeatured;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final int initialPage = 0;
  int currentIndex = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
      height: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width * 0.8,
              viewportFraction: 1,
              initialPage: initialPage,
              enableInfiniteScroll: widget.gallery.length > 1,
              reverse: false,
              autoPlay: widget.gallery.length > 1,
              // autoPlay: false,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
            items: widget.gallery.isNotEmpty
                ? widget.gallery
                    .map(
                      (i) => GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.showImage, arguments: i.imageUrl);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: CustomImage(
                            path: i.image != ''
                                ? "${RemoteUrls.rootUrl}${i.image}"
                                : null,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList()
                : [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const CustomImage(
                        path: "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
          ),
          Visibility(
            visible: widget.isFeatured == 1,
            child: Positioned(
              top: 12.h,
              left: -3,
              child: Transform.rotate(
                angle: -math.pi / 4.1,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                      color: const Color(0xFF2DBE6C),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    'Featured',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 5,
            child: GestureDetector(
                onTap: () {
                  carouselController.nextPage();
                },
                child: const Icon(Icons.arrow_forward_ios, color: Colors.blue)),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 5,
            child: GestureDetector(
                onTap: () {
                  carouselController.previousPage();
                },
                child: const Icon(Icons.arrow_back_ios, color: Colors.blue)),
          )
        ],
      ),
    );
  }

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      currentIndex = index;
    });
  }
}
