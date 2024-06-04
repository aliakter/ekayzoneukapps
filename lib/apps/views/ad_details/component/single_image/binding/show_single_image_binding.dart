import 'package:ekayzoneukapps/apps/views/ad_details/component/single_image/controller/show_single_image_controller.dart';
import 'package:get/get.dart';

class ShowSingleImageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ShowSingleImageController());
  }
}