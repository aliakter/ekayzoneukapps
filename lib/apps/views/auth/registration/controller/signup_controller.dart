import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/routes/routes.dart';
import 'package:ekayzoneukapps/main.dart';
import 'package:ekayzoneukapps/apps/views/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpController extends GetxController {
  final AuthRepository authRepository;

  SignUpController(this.authRepository);

  final TextEditingController nameCtl = TextEditingController();
  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();
  final TextEditingController confPasswordCtl = TextEditingController();
  RxBool obscureText = true.obs;
  RxBool obscureConfirmText = true.obs;
  RxBool isLoading = false.obs;
  RxBool isGmailLoading = false.obs;
  String token = "";
  String userId = "";
  RxInt agree = 0.obs;

  void checkBox() {
    agree.value = (agree.value == 1) ? 0 : 1;
    update();
  }

  void toggle() {
    obscureText.toggle();
    update();
  }

  void toggleConfirm() {
    obscureConfirmText.toggle();
    update();
  }

  bool isNameOkay() {
    if (nameCtl.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isEmailOkay() {
    if (emailCtl.text.isNotEmpty && GetUtils.isEmail(emailCtl.text)) {
      return true;
    }
    return false;
  }

  bool isPasswordOkay() {
    if (passwordCtl.text.isNotEmpty && passwordCtl.text.length > 2) return true;
    return false;
  }

  bool isConfirmPasswordOkay() {
    if (confPasswordCtl.text.isNotEmpty && confPasswordCtl.text.length > 2) {
      return true;
    }
    return false;
  }

  Future<void> userRegistration() async {
    if (isNameOkay() &&
        isEmailOkay() &&
        isPasswordOkay() &&
        isConfirmPasswordOkay()) {
      if (passwordCtl.text == confPasswordCtl.text) {
        if (agree.value == 1) {
          final body = <String, String>{};
          body.addAll({"name": nameCtl.text.trim()});
          body.addAll({"email": emailCtl.text.trim()});
          body.addAll({"password": passwordCtl.text.trim()});
          body.addAll({"password_confirmation": confPasswordCtl.text.trim()});

          isLoading.value = true;
          final result = await authRepository.userRegister(body);

          result.fold((error) {
            isLoading.value = false;
            Utils.toastMsg(error.message);
          }, (data) async {
            sharedPreferences.setString("userToken", data.loginToken);
            sharedPreferences.setString("userId", data.user.id.toString());
            sharedPreferences.setString("userName", data.user.username.toString());
            token = sharedPreferences.getString("userToken") ?? "";
            nameCtl.text = "";
            emailCtl.text = "";
            passwordCtl.text = "";
            confPasswordCtl.text = "";
            isLoading.value = false;
            Get.offAllNamed(Routes.main);
          });
        } else {
          Utils.toastMsg(
              "Please agree with terms & conditions and privacy policy");
        }
      } else {
        Utils.toastMsg("Confirm password not matched");
      }
    } else if (!isNameOkay()) {
      Utils.toastMsg("Please enter your name");
    } else if (!isEmailOkay()) {
      Utils.toastMsg("Please enter your email");
    } else if (!isPasswordOkay()) {
      Utils.toastMsg("Please enter your password");
    } else if (!isConfirmPasswordOkay()) {
      Utils.toastMsg("Please enter your confirm password");
    }
  }

  Future<void> handleGoogleSignIn() async {
    GoogleSignIn googleSignIn =
        GoogleSignIn(signInOption: SignInOption.standard, scopes: ['email']);

    await googleSignIn.signIn().then((GoogleSignInAccount? acc) async {
      GoogleSignInAuthentication auth = await acc!.authentication;

      ///
      if (auth.accessToken != null) {
        final body = <String, dynamic>{};
        body.addAll({'id': acc.id});
        body.addAll({'name': acc.displayName});
        body.addAll({'username': acc.displayName});
        body.addAll({'email': acc.email});
        body.addAll({'token': auth.accessToken});
        body.addAll({'provider': 'google'});

        isGmailLoading.value = true;
        final result = await authRepository.socialLogin(body);
        result.fold(
          (error) {
            Utils.toastMsg(error.message);
            isGmailLoading.value = false;
          },
          (data) {
            sharedPreferences.setString("userToken", data.loginToken);
            sharedPreferences.setString(
                "userId", data.user.id.toString() ?? "");
            token = sharedPreferences.getString("userToken") ?? "";
            userId = sharedPreferences.getString("userId") ?? "";
            Get.offAndToNamed(Routes.main);
            isGmailLoading.value = false;
          },
        );
      }
    });
  }
}
