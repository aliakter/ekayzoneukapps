import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/views/wishlist/component/wish_list_produtc_container.dart';
import 'package:ekayzoneukapps/apps/views/wishlist/controller/wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteListScreen extends GetView<WishlistController> {
  const FavouriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Ads"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp, color: iconThemeColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () => Future.delayed(
            const Duration(seconds: 1),
            () => controller.getWishlistData(),
          ),
          child: controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(scrollDirection: Axis.vertical, slivers: [
                  FavouriteListProductContainer(controller: controller)
                ]),
        );
      }),
    );
  }
}
