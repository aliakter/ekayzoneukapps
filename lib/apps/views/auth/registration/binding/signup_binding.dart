import 'package:ekayzoneukapps/apps/views/auth/registration/controller/signup_controller.dart';
import 'package:get/get.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(Get.find()));
  }
}
