import 'package:ekayzoneukapps/apps/views/ads/repository/ads_repository.dart';
import 'package:ekayzoneukapps/apps/views/auth/login/controller/login_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/controller/home_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/models/ad_model.dart';
import 'package:ekayzoneukapps/apps/views/home/models/category_model.dart';
import 'package:ekayzoneukapps/apps/views/main/controller/main_controller.dart';
import 'package:ekayzoneukapps/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';

class AdsController extends GetxController {
  final LoginController loginController;
  final AdRepository adsRepository;
  final HomeController homeController;

  AdsController(this.loginController, this.adsRepository, this.homeController);

  TextEditingController searchController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  String selectedCategory = "";
  RxString selectedCity = "".obs;
  Category? category;

  final scrollController = ScrollController();
  final MainController mainController = MainController();
  RxString selectedSortingValue = "".obs;
  var stateList = ["Dhaka", "Mymensingh"];

  // var categoryValue;
  String token = "";
  String userId = "";

  @override
  void onInit() {
    super.onInit();
    getToken();
    searchController.text = Get.arguments[0] ?? "";
    selectedCategory = Get.arguments[1] ?? "";
    locationController.text = Get.arguments[2] ?? "";
    selectedCity.value = Get.arguments[3] ?? "";

    if (selectedCategory != "") {
      category = homeController.categoryList.value
          .singleWhere((element) => element.name == selectedCategory);
    }

    getAdsListData();
    scrollController.addListener(_init);
  }

  void _init() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMoreFiles();
    }
  }

  getToken() {
    token = sharedPreferences.getString("userToken") ?? "";
    userId = sharedPreferences.getString("userId") ?? "";
  }

  RxBool isLoading = false.obs;
  List<AdsModel> adListMode = [];

  Future<void> getAdsListData() async {
    isLoading.value = true;
    final result = await adsRepository.getAdsListData(
      token,
      searchController.text ?? "",
      locationController.text ?? "",
      selectedCity.value ?? "",
      minPriceController.text ?? "",
      maxPriceController.text ?? "",
      selectedSortingValue.value ?? "",
      selectedCategory ?? "",
      page.value.toString() ?? "",
    );
    result.fold((error) {
      isLoading.value = false;
      print(error.message);
    }, (data) async {
      adListMode = data.adsList;
      isLoading.value = false;
    });
  }

  RxBool isPaging = true.obs;
  RxBool gettingMoreData = false.obs;
  RxInt page = 1.obs;

  loadMoreFiles() {
    if (isPaging.value) {
      page.value++;
      getAllBooksDataPage();
    }
  }

  void getAllBooksDataPage() async {
    gettingMoreData(true);

    final result = await adsRepository.getAdsListData(
      token,
      searchController.text ?? "",
      selectedCity.value ?? "",
      locationController.text ?? "",
      minPriceController.text ?? "",
      maxPriceController.text ?? "",
      selectedSortingValue.value ?? "",
      selectedCategory ?? "",
      page.value.toString() ?? "",
    );
    result.fold((error) {
      gettingMoreData(false);
      print(error.message);
    }, (data) async {
      adListMode.addAll(data.adsList);
      gettingMoreData(false);
    });
  }

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

  void clear() {
    selectedCategory = "";
    category = null;
    selectedCity.value = "";
    selectedSortingValue.value = "";
    locationController.text = "";
    minPriceController.text = "";
    maxPriceController.text = "";
    update();
  }
}
