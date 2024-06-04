import 'dart:convert';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/views/compare/model/compare_list_model.dart';
import 'package:ekayzoneukapps/apps/views/compare/repository/compare_repository.dart';
import 'package:ekayzoneukapps/apps/views/home/controller/home_controller.dart';
import 'package:ekayzoneukapps/main.dart';
import 'package:get/get.dart';

class CompareController extends GetxController {
  CompareRepository compareRepository;

  CompareController(this.compareRepository);

  RxBool isLoading = false.obs;
  List adsList = [];
  CompareListModel? compareListModel;

  @override
  void onInit() {
    super.onInit();
    getCompareListData();
  }

  void getCompareListData() async {
    isLoading.value = true;
    final result = await compareRepository.getCompareList();
    result.fold((error) {
      isLoading.value = false;
    }, (data) {
      compareListModel = data;
      isLoading.value = false;
    });
  }

  Future<void> deleteAds(int id) async {
    // final jsonString = sharedPreferences.getString('compareList');
    // if (jsonString != null) {
    //   final items = List<int>.from(json.decode(jsonString));
    //   // items.remove(id);
    //   items.removeWhere((item) => item == id);
    //   final jsonString1 = json.encode(items);
    //   await sharedPreferences.setString('compareList', jsonString1);
    //   Utils.toastMsg("Ad removed from compare list");
    //   getCompareListData();
    //   // Get.find<HomeController>().getHomeData();
    //   Get.find<HomeController>().update();
    // }
    ///
    String storedListString = sharedPreferences.getString('compareList') ?? '[]';
    List<int> myList = List<int>.from(json.decode(storedListString));
    myList.removeWhere((item) => item == id);
    Get.find<HomeController>().compareAdList.removeWhere((element) => element == id);
    sharedPreferences.setString('compareList', json.encode(myList));
    Utils.toastMsg("Ad removed from compare list");
    getCompareListData();
    Get.find<HomeController>().update();
  }
}
