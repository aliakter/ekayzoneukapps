import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/views/auth/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository authRepository;

  ForgotPasswordController(this.authRepository);

  final emailController = TextEditingController();
  RxBool isLoading = false.obs;

  bool isEmailOkay() {
    if (emailController.text.isNotEmpty && GetUtils.isEmail(emailController.text)) {
      return true;
    }
    return false;
  }

  Future<void> forgotPassWord() async {
    if (isEmailOkay()) {
      // Validate email format
      // if (!emailController.text.trim().endsWith('.com')) {
      //   Get.snackbar("Warning", "Please enter your valid email");
      //   return;
      // }

      final body = <String, String>{};
      body.addAll({"email": emailController.text.trim()});

      isLoading.value = true;
      final result = await authRepository.forgotPassWord(body);

      result.fold((error) {
        Utils.toastMsg(error.message);
        isLoading.value = false;
      }, (data) async {
        if (data == 1) {
          emailController.text = "";
          Get.back();
        }
        Utils.toastMsg(data == 1
            ? "We have emailed your password reset code"
            : "Email address not found");
        isLoading.value = false;
      });
    } else {
      Utils.toastMsg("Please enter your email");
    }
  }
}
