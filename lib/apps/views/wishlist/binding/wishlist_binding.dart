import 'package:ekayzoneukapps/apps/views/home/controller/home_controller.dart';
import 'package:ekayzoneukapps/apps/views/wishlist/controller/wish_list_controller.dart';
import 'package:ekayzoneukapps/apps/views/wishlist/reposotory/wishlist_repository.dart';
import 'package:get/get.dart';

class FavouritelistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishlistRepository>(() => WishlistRepositoryImpl(Get.find()));
    Get.lazyPut<WishlistController>(
        () => WishlistController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => HomeController(Get.find(), Get.find(), Get.find()));
  }
}
