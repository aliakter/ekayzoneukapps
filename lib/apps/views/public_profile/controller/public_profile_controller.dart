import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/views/ad_details/controllers/ad_details_controller.dart';
import 'package:ekayzoneukapps/apps/views/auth/login/controller/login_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/models/ad_model.dart';
import 'package:ekayzoneukapps/apps/views/public_profile/model/public_profile_model.dart';
import 'package:ekayzoneukapps/apps/views/public_profile/repository/public_profile_repository.dart';
import 'package:ekayzoneukapps/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profile_update/controller/profile_update_controller.dart';

class PublicProfileController extends GetxController {
  final LoginController loginController;
  final PublicProfileRepository publicProfileRepository;
  final ProfileUpdateController profileUpdateController;

  // final AdDetailsController adDetailsController;

  PublicProfileController(this.loginController, this.publicProfileRepository,
      this.profileUpdateController);

  RxBool shopSelect = true.obs;
  RxBool sellerReviewSelect = false.obs;
  RxBool writeReviewSelect = false.obs;
  final reviewController = TextEditingController();
  String? selectedValue;
  RxDouble ratingValue = 0.0.obs;
  String? userName;
  String token = "";
  String userId = "";
  String loginUserName = "";
  RxBool isLoading = false.obs;
  RxBool isMoreLoading = false.obs;
  RxBool isSetReview = false.obs;
  PublicProfileModel? publicProfileModel;
  RxList<AdsModel> recentAds = <AdsModel>[].obs;
  final scrollController = ScrollController();

  int page = 1;

  RxBool isNoMoreData = false.obs;

  @override
  void onInit() {
    super.onInit();
    userName = Get.arguments;
    getToken();
    getPublicProfile();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (recentAds.length != publicProfileModel!.totalActiveAd) {
          getPublicProfileMore();
        } else {
          isNoMoreData(true);
        }
      }
    });
  }

  getToken() {
    token = sharedPreferences.getString("userToken") ?? "";
    userId = sharedPreferences.getString("userId") ?? "";
    loginUserName = sharedPreferences.getString("userName") ?? "";
  }

  changeBtnOne() {
    shopSelect.value = true;
    sellerReviewSelect.value = false;
    writeReviewSelect.value = false;
  }

  changeBtnTwo() {
    shopSelect.value = false;
    sellerReviewSelect.value = true;
    writeReviewSelect.value = false;
  }

  changeBtnThree() {
    shopSelect.value = false;
    sellerReviewSelect.value = false;
    writeReviewSelect.value = true;
  }

  isMe(int id) {
    if (profileUpdateController.userProfileModel.value?.id == id) {
      return true;
    } else {
      return false;
    }
  }

  ratingChange(rating) {
    ratingValue.value = rating;
    update();
  }

  Future<void> getPublicProfile() async {
    page = 1;
    isLoading(true);
    final result = await publicProfileRepository.getPublicShop(
        token, userName ?? loginUserName, page.toString());
    result.fold((error) {
      isLoading(false);
      print(error.message);
    }, (data) async {
      publicProfileModel = data;
      recentAds.value = publicProfileModel!.recentAds;
      // if(publicProfileModel?.reviews.length!=0){
      //   ratingValue.value =
      //       double.parse("${publicProfileModel?.reviews.where((element) => element.userId == int.parse("${sharedPreferences.getString("userId")}")).toList().first.stars}");
      //   reviewController.text = publicProfileModel?.reviews.where((element) => element.userId == int.parse("${sharedPreferences.getString("userId")}")).toList().first.comment??"";
      // }
      isLoading(false);
    });
  }

  Future<void> getPublicProfileMore() async {
    page++;
    isMoreLoading(true);
    final result = await publicProfileRepository.getPublicShop(
        token, userName ?? loginUserName, page.toString());
    result.fold((error) {
      isMoreLoading(false);
      print(error.message);
    }, (data) async {
      isMoreLoading(false);
      publicProfileModel = data;
      if (publicProfileModel!.recentAds.isNotEmpty) {
        recentAds.addAll(publicProfileModel!.recentAds);
      }
      if (publicProfileModel!.reviews.isNotEmpty) {
        ratingValue.value = double.parse(
            "${publicProfileModel?.reviews.where((element) => element.userId == int.parse("${sharedPreferences.getString("userId")}")).toList().first.stars}");
        reviewController.text = publicProfileModel?.reviews
                .where((element) =>
                    element.userId ==
                    int.parse("${sharedPreferences.getString("userId")}"))
                .toList()
                .first
                .comment ??
            "";
      }
    });
  }

  bool isRatingOkay() {
    return ratingValue.value > 0;
  }

  bool isReviewTextOkay() {
    if (reviewController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> setReview() async {
    if (isRatingOkay() && isReviewTextOkay()) {
      final body = {
        "stars": ratingValue.value.toString(),
        "comment": reviewController.text.trim(),
      };

      isSetReview.value = true;
      final result = await publicProfileRepository.setReview(
          token, userName ?? loginUserName, body);
      result.fold(
        (error) {
          print(error.message);
          isSetReview.value = false;
          Utils.toastMsg(error.message);
        },
        (data) async {
          Utils.toastMsg(data);
          reviewController.clear();
          ratingValue.value = 0;
          getPublicProfile();
          // adDetailsController.getAdDetails();
          isSetReview.value = false;
        },
      );
    } else if (!isRatingOkay()) {
      Utils.toastMsg("Please select your rating");
      isSetReview.value = false;
    } else if (!isReviewTextOkay()) {
      Utils.toastMsg("Please enter your review");
      isSetReview.value = false;
    }
  }
}
