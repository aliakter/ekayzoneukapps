import 'package:get/get.dart';

class ShowSingleImageController extends GetxController{

  dynamic imageUrl;

  @override
  void onInit() {
    super.onInit();
    imageUrl = Get.arguments;
    print('rrrrrrrrrrrrrrrrrrrrrrrrrrrr');
    print(imageUrl);
    print('rrrrrrrrrrrrrrrrrrrrrrrrrrrr');
  }
}