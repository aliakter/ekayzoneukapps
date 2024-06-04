import 'package:carousel_slider/carousel_controller.dart';
import 'package:ekayzoneukapps/apps/views/auth/login/controller/login_controller.dart';
import 'package:ekayzoneukapps/apps/views/dashboard/model/dashboard_model.dart';
import 'package:ekayzoneukapps/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/dashboard_repository.dart';

class DashboardController extends GetxController {
  final LoginController loginController;
  final DashboardRepository dashboardRepository;

  DashboardController(this.loginController, this.dashboardRepository);

  RxBool isLoading = false.obs;
  String token = "";
  String userId = "";
  DashboardModel? dashboardModel;
  CarouselController carouselController = CarouselController();
  bool isNextTap = false;
  bool isPreviousTap = false;

  @override
  void onInit() {
    getToken();
    getDashboardData();
    super.onInit();
  }

  void onTapNextDown(TapDownDetails details) {
    isNextTap = true;
  }

  void onTapNextUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      isNextTap = false;
    });
  }

  void onTapPreviousDown(TapDownDetails details) {
    isPreviousTap = true;
  }

  void onTapPreviousUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      isPreviousTap = false;
    });
  }


  getToken(){
    token = sharedPreferences.getString("userToken")??"";
    userId = sharedPreferences.getString("userId")??"";
  }

  getDashboardData() async {
    isLoading.value = true;
    final result = await dashboardRepository
        .getDashboardData(token);
    result.fold((error) {
      isLoading.value = false;
      print(error.message);
    }, (data) async {
      dashboardModel = data;
      isLoading.value = false;
    });
  }
}
