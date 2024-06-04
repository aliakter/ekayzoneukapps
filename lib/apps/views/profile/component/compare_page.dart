import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/views/compare/components/compare_list_container.dart';
import 'package:ekayzoneukapps/apps/views/compare/controller/compare_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/component/shimmer_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComparePage extends GetView<CompareController> {
  const ComparePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Compare Ads"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp, color: iconThemeColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => Future.delayed(const Duration(seconds: 1),
              () => controller.getCompareListData()),
          child: controller.isLoading.value
              ? const ShimmerList()
              : const CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [CompareListContainer()]),
        ),
      ),
    );
  }
}
