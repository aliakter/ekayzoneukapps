import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/main_controller.dart';
import '../widgets/my_bottom_navbar.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvoked: (bool) {
            return controller.onBackPressed(context);
          },
          child: Scaffold(
            body: controller.screenList[controller.pageIndex],
            bottomNavigationBar: MyBottomNavigationBar(controller: controller),
          ),
        );
      },
    );
  }
}
