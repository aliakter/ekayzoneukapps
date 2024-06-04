import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/custom_image.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/data/remote_urls.dart';
import 'package:ekayzoneukapps/apps/routes/routes.dart';
import 'package:ekayzoneukapps/apps/views/wishlist/controller/wish_list_controller.dart';
import 'package:ekayzoneukapps/apps/views/wishlist/model/wish_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class FavouriteListProductCard extends StatelessWidget {
  final Datum adModel;

  const FavouriteListProductCard({super.key, required this.adModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.adDetailsScreen, arguments: adModel.ad!.slug);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildImage()),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: ashColor)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            child: CustomImage(
                path: "${RemoteUrls.rootUrl}${adModel.ad!.thumbnail}",
                fit: BoxFit.cover),
          ),
          Visibility(
            visible: adModel.ad!.featured == 1,
            child: Positioned(
              top: 13,
              left: -4,
              child: Transform.rotate(
                angle: -math.pi / 4.1,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                      color: const Color(0xFF2DBE6C),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Featured',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: () {
                Get.find<WishlistController>()
                    .unselectWishlist(adModel.ad!.id.toString());
              },
              icon: const Icon(Icons.favorite, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.layers_outlined,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  adModel.ad == null ? "" : adModel.ad!.category?.name ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      height: 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  adModel.ad == null ? "" : adModel.ad!.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                    color: paragraphColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                adModel.ad == null
                    ? "Negotiable"
                    : adModel.ad!.price != "0.00"
                        ? "\£ ${adModel.ad!.price}"
                        : "Negotiable",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(
                child: Text(
                  Utils.formatDate(adModel.createdAt),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                      height: 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
