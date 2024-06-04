import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/views/auth/login/controller/login_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/controller/home_controller.dart';
import 'package:ekayzoneukapps/apps/views/my_ads/model/user_ads_model.dart';
import 'package:ekayzoneukapps/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/my_ads_repository.dart';

class MyAdsController
    extends GetxController /* with GetSingleTickerProviderStateMixin */ {
  final LoginController loginController;
  final MyAdsRepository myAdsRepository;

  MyAdsController(this.loginController, this.myAdsRepository);

  RxBool isLoading = false.obs;
  RxBool isDeleteLoading = false.obs;
  String token = "";
  String userId = "";
  UserAdModel? userAdModel;
  Rx<List<Datums>> adList = Rx<List<Datums>>([]);

  RxInt page = 1.obs;
  RxBool isPaging = true.obs;
  RxBool gettingMoreData = false.obs;

  void scroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMoreFiles();
    }
  }

  changePage() {
    page.value = 1;
    adList.value = [];
    getAdsData();
  }

  loadMoreFiles() {
    if (isPaging.value) {
      page.value++;
      getMoreAdsData();
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(scroll);
    getToken();
    getAdsData();
  }

  getToken() {
    token = sharedPreferences.getString("userToken") ?? "";
    userId = sharedPreferences.getString("userId") ?? "";
  }

  final ScrollController scrollController = ScrollController();

  String capitalize(String input) {
    if (input == null || input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  Future<void> getAdsData() async {
    isLoading.value = true;
    final result = await myAdsRepository.getUserAdsData(token, page.value);
    result.fold((error) {
      isLoading.value = false;
      print(error.message);
    }, (data) async {
      userAdModel = data;
      adList.value = userAdModel!.data.data;
      isPaging(true);
      isLoading.value = false;
    });
  }

  Future<void> getMoreAdsData() async {
    gettingMoreData(true);
    final result = await myAdsRepository.getUserAdsData(token, page.value);
    result.fold((error) {
      gettingMoreData(false);
      print(error.message);
    }, (data) async {
      if (data.data.data == []) {
        isPaging(false);
        gettingMoreData(false);
      } else {
        for (var val in data.data.data) {
          adList.value.add(val);
        }
        gettingMoreData(false);
      }
    });
  }

  deleteAds(String id) async {
    isDeleteLoading.value = true;
    final result = await myAdsRepository.deleteAds(token, id);
    result.fold((error) {
      Utils.toastMsg(error.message);
      isDeleteLoading.value = false;
    }, (data) async {
      Utils.toastMsg(data);
      getAdsData();
      Navigator.pop(Get.context!);
      isDeleteLoading.value = false;
    });
  }
}
