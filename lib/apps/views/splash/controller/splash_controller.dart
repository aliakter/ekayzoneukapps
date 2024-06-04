import 'dart:async';
import 'package:ekayzoneukapps/apps/views/auth/login/controller/login_controller.dart';
import 'package:ekayzoneukapps/apps/views/splash/languages/model/language_model.dart';
import 'package:ekayzoneukapps/apps/views/splash/languages/repository/language_repository.dart';
import 'package:ekayzoneukapps/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/constants.dart';
import '../../../routes/routes.dart';

class SplashController extends GetxController {
  final LanguageRepository languageRepository;
  final LoginController loginController;

  SplashController(this.loginController, this.languageRepository);

  late AnimationController animationController;
  late Animation<double> animation;
  final formatter = DateFormat("yyyy-MM-dd hh:mm");
  RxBool isLoading = false.obs;
  String token = "";
  String userId = "";

  @override
  void onInit() {
    super.onInit();
    getToken();
    getLanguages().then((value) => startTime());
  }

  getToken() {
    token = sharedPreferences.getString("userToken") ?? "";
    userId = sharedPreferences.getString("userId") ?? "";
  }

  startTime() async {
    isLoading.value = false;
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (token != "") {
        return Timer(splashKDuration, navigateToMainPage);
      } else {
        return Timer(splashKDuration, navigateToMainPage);
      }
    } else {
      return Timer(splashKDuration, noInternetPage);
    }
  }

  void navigateToMainPage() {
    Get.offAllNamed(Routes.main);
  }

  void noInternetPage() {
    Get.offAllNamed(Routes.noInternet);
  }

  void navigateToLoginPage() {
    Get.offAllNamed(Routes.login);
  }

  void toEnglish() => Locale('en');

  void toChinese() => Locale('zh');

  void toFrance() => Locale('fr');

  void toBislama() => Locale('bi');

  void toChange(String code) => Locale(code);

  RxList<LanguageModel> languages = <LanguageModel>[].obs;

  Future<void> getLanguages() async {
    languageRepository.checkLanguage().fold((l) async {
      final result = await languageRepository.getLanguages();
      result.fold((error) {
        print('${error.statusCode}');
        print("Ali debuggin");
        print("Languageee eror is : $error");
      }, (data) {
        languages.value = data;
      });
    }, (r) async {
      if (r == false) {
        final result = await languageRepository.getLanguages();
        result.fold((error) {
          print("Languageee error is : $error");
        }, (data) {
          languages.value = data;
        });
      } else {
        final result = languageRepository.getCachedLanguages();
        result.fold((error) {
          print("Languageee erro is : $error");
        }, (data) {
          languages.value = data;
        });
      }
    });
  }

  String getCountryName(code) {
    for (LanguageModel language in languages) {
      if (language.code == code) {
        return language.name;
      }
    }
    return "English";
  }
}
