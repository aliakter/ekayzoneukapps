import 'dart:io';
import 'package:ekayzoneukapps/apps/views/ad_details/component/single_image/controller/show_single_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ShowSingleImage extends GetView<ShowSingleImageController> {
  const ShowSingleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF28282B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        systemOverlayStyle: Platform.isIOS
            ? SystemUiOverlayStyle.dark
            : const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
      ),
      body: SafeArea(
        child: Center(
          child: PhotoView(
            minScale: PhotoViewComputedScale.contained * 1,
            imageProvider: NetworkImage(controller.imageUrl),
          ),
        ),
      ),
    );
  }
}
