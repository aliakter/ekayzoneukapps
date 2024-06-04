import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import '../../compare/screens/compare_screen.dart';
import '../../home/home_screen.dart';
import '../../profile/screens/profile_screen.dart';

class MainController extends GetxController {
  int pageIndex = 0;

  // PageController pageController= PageController();

  @override
  void onInit() {
    super.onInit();
    // pageController = PageController(
    //   initialPage: pageIndex,
    // );
    pageIndex = 0;
  }

  @override
  void onClose() {
    // pageController.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  void changePage(int index) {
    pageIndex = index;
    update();
  }

  List<Widget> screenList = [
    const HomeScreen(),
    const CompareScreen(),
    const ProfileScreen(),
  ];

  void onBackPressed(context) async {
    if (pageIndex != 0) {
      changePage(0);
      // pageController.jumpToPage(0);
    } else {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        animationType: DialogTransitionType.scale,
        duration: const Duration(milliseconds: 500),
        builder: (context) => AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          title: const Text(
            'Are you sure you want to close application?',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
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
                SystemNavigator.pop();
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
        ),
      );
    }
  }
}
