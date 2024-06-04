import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/views/ad_details/controllers/ad_details_controller.dart';
import 'package:ekayzoneukapps/apps/views/ads/controller/ads_controller.dart';
import 'package:ekayzoneukapps/apps/views/compare/controller/compare_controller.dart';
import 'package:ekayzoneukapps/apps/views/dashboard/controller/dashboard_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/models/category_model.dart';
import 'package:ekayzoneukapps/apps/views/home/models/designation_model.dart';
import 'package:ekayzoneukapps/apps/views/home/models/home_model.dart';
import 'package:ekayzoneukapps/apps/views/home/repository/home_repository.dart';
import 'package:ekayzoneukapps/apps/views/main/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ekayzoneukapps/apps/views/splash/languages/repository/language_repository.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_webservice/places.dart';
import '../../../../main.dart';
import '../../auth/login/model/setting_model.dart';
import '../../public_profile/controller/public_profile_controller.dart';
import '../../splash/languages/model/language_model.dart';

class HomeController extends GetxController {
  final HomeRepository homeRepository;
  final LanguageRepository languageRepository;
  final CompareController compareController;

  HomeController(
      this.homeRepository, this.languageRepository, this.compareController);

  final scrollController = ScrollController();
  final scrollController2 = ScrollController();
  final searchController = TextEditingController();
  final locationController = TextEditingController();
  CarouselController carouselController = CarouselController();
  RxBool isLoading = false.obs;
  bool isNextTap = false;
  bool isPreviousTap = false;
  HomeModel? homeModel;
  String token = "";
  String userId = "";
  Rx<List<Category>> categoryList = Rx<List<Category>>([]);
  List<DesignationModel> designationsList = <DesignationModel>[];
  Category? category;
  String selectedCategory = '';
  var stateList = ["Dhaka", "Mymensingh"];
  bool isSettingLoading = false;
  SettingModel? settingModel;

  @override
  void onInit() {
    super.onInit();
    getToken();
    getHomeData();
    // getLanguages();
    // getSettingData();
  }


  getToken() {
    token = sharedPreferences.getString("userToken") ?? "";
    userId = sharedPreferences.getString("userId") ?? "";
  }

  void toTop() {
    scrollController2.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
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

  void getSettingData() async {
    isSettingLoading = true;
    final result = await homeRepository.getSettingData();
    result.fold((error) {
      isSettingLoading = false;
      print(error.message);
    }, (data) async {
      settingModel = data;
      isSettingLoading = false;
    });
  }

  Future<void> getHomeData() async {
    isLoading.value = true;
    final result = await homeRepository.getHomeData(token);
    result.fold((error) {
      isLoading.value = false;
      print(error.message);
    }, (data) async {
      homeModel = data;
      categoryList.value = data.categories;
      designationsList = data.designation??[];
      isLoading.value = false;
    });
  }

  List<int> compareAdList = <int>[];

  addToCompareList(int id) async {
    compareAdList.add(id);
    final jsonString = json.encode(compareAdList);
    await sharedPreferences.setString('compareList', jsonString);
    compareController.getCompareListData();
    getHomeData();
    // Get.find<DashboardController>().getDashboardData();
    // Get.find<AdsController>().getAdsListData();
    Get.find<AdsController>().update();
    Get.find<PublicProfileController>().update();
    Get.find<AdDetailsController>().update();
    Get.find<HomeController>().update();
    // checkIfCompareList(id);
    // update();
  }

  void removedFromCompareList(int id) async {
    compareAdList.removeWhere((element) => element == id);
    // Convert the list to a JSON string
    final jsonString = json.encode(compareAdList);
    // Save the JSON string to SharedPreferences
    await sharedPreferences.setString('compareList', jsonString);
    compareController.getCompareListData();
    getHomeData();
    // Get.find<AdsController>().getAdsListData();
    Get.find<AdsController>().update();
    Get.find<PublicProfileController>().update();
    Get.find<AdDetailsController>().update();
    // Get.find<DashboardController>().getDashboardData();
    Get.find<HomeController>().update();
    // checkIfCompareList(id);
    // update();
  }

  bool checkIfCompareList(int id) {
    final jsonString = sharedPreferences.getString('compareList');
    if (jsonString != null) {
      List<dynamic> storedList = json.decode(jsonString);
      final items = List<int>.from(storedList);
      if (items.contains(id)) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  ///wishlist
  bool isWishlist = false;

  setUnsetWishlist(String id) async {
    final result = await homeRepository.setUnsetWishlist(token, id);
    result.fold((error) {
      Get.snackbar("Warning", error.message);
      print(error.message);
    }, (data) async {
      print(" $data");
      //getHomeData();
      Utils.toastMsg(data);
    });
  }

  List<LanguageModel> languages = <LanguageModel>[];

  Future<void> getLanguages() async {
    languageRepository.checkLanguage().fold((l) async {
      final result = await languageRepository.getLanguages();
      result.fold((error) {}, (data) {
        languages = data;
      });
    }, (r) async {
      if (r == false) {
        final result = await languageRepository.getLanguages();
        result.fold((error) {}, (data) {
          languages = data;
        });
      } else {
        final result = languageRepository.getCachedLanguages();
        result.fold((error) {}, (data) {
          languages = data;
        });
      }
    });
  }

  String getCountryName(code) {
    for (LanguageModel language in languages) {
      if (language.code == code) {
        print('asdfjh--------${language.name}');
        return language.name;
      }
    }
    update();
    return "English";
  }

  void toChange(String code) {
    print('aSDJKHAd ${code}');
    Locale(code);
    Get.updateLocale(Locale(code));
  }

  RxString selectedCity = "".obs;

  ///......... Location search ................
  List<Prediction> placesSearchResult = [];
  static const kGoogleApiKey = "AIzaSyCGYnCh2Uusd7iASDhsUCxvbFgkSifkkTM";
  final places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  late PlacesSearchResponse response;

  Future<List<Prediction>> getPlaces(text, countryCode) async {
    await places
        .autocomplete(text,
            types: ['locality'],
            components: [Component(Component.country, countryCode.toString())],
            radius: 1000)
        .then((value) {
      placesSearchResult = value.predictions;
      if (value.predictions.isNotEmpty) {
        placesSearchResult = value.predictions;
      }
    });

    return placesSearchResult;
  }

  void scrollOn() {
    // if(scrollController.position.pixels<0){
    scrollController.animateTo(
      scrollController.offset + 200,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    // }
  }

  void scrollOff() {
    if (scrollController.position.pixels > 0) {
      scrollController.animateTo(
        scrollController.offset - 200,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void clear() {
    searchController.text = "";
    locationController.text = "";
    selectedCity.value = "";
    selectedCategory = "";
    category = null;

    update();
  }
}
