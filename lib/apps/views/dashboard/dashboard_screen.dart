import 'package:ekayzoneukapps/apps/views/dashboard/component/dashboard_grid_card_layout.dart';
import 'package:ekayzoneukapps/apps/views/dashboard/component/dashboard_topbar.dart';
import 'package:ekayzoneukapps/apps/views/dashboard/component/recent_add_list.dart';
import 'package:ekayzoneukapps/apps/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Dashboard"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: RefreshIndicator(
                  onRefresh: () => Future.delayed(const Duration(seconds: 1),
                      () => controller.getDashboardData()),
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        sliver: SliverToBoxAdapter(
                            child: DashboardTopBar(controller: controller)),
                      ),
                      const SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          sliver: DashboardGridCardLayout()),
                      SliverToBoxAdapter(
                        child: HorizontalProductContainer(
                          adsModel:
                              controller.dashboardModel?.data.recentAdd.data ??
                                  [],
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 30)),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
