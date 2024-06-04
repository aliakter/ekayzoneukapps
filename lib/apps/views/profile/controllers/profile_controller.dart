import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/routes/routes.dart';
import 'package:ekayzoneukapps/apps/views/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../main.dart';

class ProfileController extends GetxController {
  final scrollController = ScrollController();
  String token = "";
  String userId = "";
  String userFullName = "";
  String username = "";
  String userEmail = "";
  String userPhone = "";
  String userWebsite = "";
  String userImage = "";

  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  getToken() {
    token = sharedPreferences.getString("userToken") ?? "";
    userId = sharedPreferences.getString("userId") ?? "";
    userFullName = sharedPreferences.getString("userFullName") ?? "";
    username = sharedPreferences.getString("userName") ?? "";
    userEmail = sharedPreferences.getString("userEmail") ?? "";
    userPhone = sharedPreferences.getString("userPhone") ?? "";
    userWebsite = sharedPreferences.getString("userWebsite") ?? "";
    userImage = sharedPreferences.getString("userImage") ?? "";
  }

  void toTop() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void showLogoutDialog(context) async {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      curve: Curves.easeInOut,
      alignment: Alignment.center,
      animationType: DialogTransitionType.scale,
      duration: const Duration(milliseconds: 500),
      builder: (context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          title: const Text(
            'Are you sure to logout from this device?',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'No',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                sharedPreferences.clear();
                Get.offAllNamed(Routes.login);
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
