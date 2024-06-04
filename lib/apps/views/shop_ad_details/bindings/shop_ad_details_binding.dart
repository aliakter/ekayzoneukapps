import 'package:ekayzoneukapps/apps/views/ads/repository/ads_repository.dart';
import 'package:ekayzoneukapps/apps/views/home/controller/home_controller.dart';
import 'package:ekayzoneukapps/apps/views/shop_ad_details/controllers/shop_ad_details_controller.dart';
import 'package:get/get.dart';

class ShopAdDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdRepository>(
        () => AdRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => ShopAdDetailsController(Get.find()));
    Get.lazyPut(() => HomeController(Get.find(), Get.find(), Get.find()));
  }
}
