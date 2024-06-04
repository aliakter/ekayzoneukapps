import 'package:ekayzoneukapps/apps/views/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:ekayzoneukapps/apps/views/auth/repository/auth_repository.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: Get.find(), localDataSource: Get.find()));
    Get.lazyPut(() => ForgotPasswordController(Get.find()));
  }
}