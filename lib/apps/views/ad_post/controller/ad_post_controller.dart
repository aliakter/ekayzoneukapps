import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/global_widget/categories_model.dart';
import 'package:ekayzoneukapps/apps/global_widget/settings_model.dart';
import 'package:ekayzoneukapps/apps/routes/routes.dart';
import 'package:ekayzoneukapps/apps/views/ads/repository/ads_repository.dart';
import 'package:ekayzoneukapps/apps/views/auth/login/controller/login_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/models/brand_model.dart';
import 'package:ekayzoneukapps/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AdPostController extends GetxController {
  final LoginController loginController;

  // final HomeController homeController;
  final AdRepository adsRepository;

  AdPostController(this.loginController, this.adsRepository);

  late List<Widget> pageList;
  final naveListener = StreamController<int>.broadcast();

  // late AnimationController animationController;
  // late Animation<double> animOffset;
  // RxList<Category> categoryList = <Category>[].obs;
  Rxn<Categories> selectedCategory = Rxn<Categories>();
  Rx<List<Branding>> brandList = Rx<List<Branding>>([]);
  Rxn<Branding> brandModel = Rxn<Branding>();

  Rx<List<Categories>> categoryList = Rx<List<Categories>>([]);

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final whatsappController = TextEditingController();
  final webSiteController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isPostAdsLoading = false.obs;
  RxBool isShowPhone = false.obs;
  RxBool isShowEmail = false.obs;
  RxBool isShowWhatsapp = false.obs;
  RxBool isShowFeatured = false.obs;
  RxString selectedCategoryId = ''.obs;
  Rx<String> selectedCondition = "new".obs;
  Rx<String> selectedAuthenticities = "".obs;
  RxInt pageIndex = 0.obs;

  changeCondition(value) {
    selectedCondition.value = value.toString();
    update();
  }

  changeEducation(value) {
    selectedEducation.value = value.toString();
    update();
  }

  changeAuthenticity(value) {
    selectedAuthenticities.value = value.toString();
    update();
  }

  changeCategory(value, controller, id) {
    selectedCategoryId.value = id;
    selectedCategory.value = value;
    if (controller.selectedCategoryId.value == '1' ||
        controller.selectedCategoryId.value == '22') {
      getBrandList(selectedCategory.value!.subcategories[0].id);
    }
    Get.toNamed(Routes.basicNewInfo, arguments: controller);
    update();
  }

  getBrandList(int subCategoryId) {
    brandList.value = [];
    for (int i = 0; i < selectedCategory.value!.brand.length; i++) {
      if (selectedCategory.value!.brand[i].subcategoryId == subCategoryId) {
        brandList.value.add(selectedCategory.value!.brand[i]);
      }
    }
    brandModel.value = brandList.value[0];
    update();
  }

  ///Job
  String selectedDesignation = '';
  String selectedJobType = '';
  Rx<String> selectedEducation = ''.obs;
  RxBool receiveIsEmail = false.obs;
  RxBool receiveIsPhone = false.obs;
  final employerEmailController = TextEditingController();
  final employerPhoneController = TextEditingController();
  final experienceController = TextEditingController();
  final salaryFromController = TextEditingController();
  final salaryToController = TextEditingController();
  final expiryDateController = TextEditingController();
  final employerNameController = TextEditingController();

  //.............Expire Date Choose ...............
  final formatter = DateFormat('yyyy-MM-dd');
  var expiryDate;
  DateTime expirySelectedDate = DateTime.now();

  // ....................Logo Photo Picker ...................
  final ImagePicker logoPicker = ImagePicker();
  XFile? logoImage;
  String? base64ImageLogo;

  Future<String?> pickLogoImage() async {
    String? imagePath;
    XFile? tempImage = await logoPicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    if (tempImage == null) {
      print("Image doesn't choose!");
      return imagePath;
    } else {
      logoImage = tempImage;
      List<int> imageBytes = await logoImage!.readAsBytes();
      base64ImageLogo =
          'data:image/${logoImage!.path.split('.').last};base64,${base64Encode(imageBytes)}';
      return base64ImageLogo;
    }
  }

  ///Fashion
  String selectedSize = '';

  ///Electronic
  String selectedBrand = "";

  ///Mobile
  String selectedAuthenticity = "";
  final editionController = TextEditingController();
  String selectedRam = "";

  ///Vehicles
  String selectedTransmission = "";
  final trimEditionController = TextEditingController();
  final manufactureYearController = TextEditingController();
  final engineCapacityController = TextEditingController();
  final registrationYearController = TextEditingController();
  String selectedBodyType = "";
  List<String> fuelTypes = [];

  ///Property
  String selectedPropertyType = "";
  final sizeController = TextEditingController();
  final bedroomController = TextEditingController();
  final propertyLocationController = TextEditingController();
  final propertyPriceController = TextEditingController();
  String selectedPropertySize = "";
  String selectedPropertyPrice = "";

  Rxn<Plannings> priority = Rxn<Plannings>();
  Rxn<SettingsModel> settingsData = Rxn<SettingsModel>();
  RxString pPrice = ''.obs;
  RxBool isPayment = false.obs;
  RxBool isFeature = false.obs;
  RxBool isPaymentChecked = false.obs;
  final featureFormKey = GlobalKey<FormState>();
  String token = "";
  String userId = "";

  Rx<List<Plannings>> items = Rx<List<Plannings>>([]);

  changePaymentCheck() {
    isPaymentChecked.value = !isPaymentChecked.value;
  }

  @override
  void onInit() {
    super.onInit();
    getToken();
    getCategoriesData();
    getSettingsData();
    // categoryList.value = homeController.categoryList.value;
    // print("Brand list ${brandList.length}");
    // print("Category list ${categoryList.length}");
    // animationController = AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 800));
    // final curve =
    //     CurvedAnimation(curve: Curves.decelerate, parent: animationController);
    // animOffset = Tween<double>(begin: 0.5, end: 1).animate(curve);
    // animationController.forward();
    // pageList = [
    //   NewAdPostCategoryChooser(categoryList),
    // ];
  }

  Future<void> getSettingsData() async {
    final result = await adsRepository.getSettingsData(token);
    result.fold((error) {}, (data) async {
      settingsData.value = data;
    });
  }

  Rx<List<Designations>> designationsList = Rx<List<Designations>>([]);

  Future<void> getCategoriesData() async {
    isLoading.value = true;
    final result = await adsRepository.getCategoriesData(token);
    result.fold((error) {
      isLoading.value = false;
      print(error.message);
    }, (data) async {
      categoryList.value = data.categories;
      designationsList.value = data.designations;
      for (var val in data.plans) {
        items.value.add(val);
      }
      priority.value = items.value[0];
      isLoading.value = false;
    });
  }

  void changeItemValue(val) {
    priority.value = val;
    update();
  }

  getToken() {
    token = sharedPreferences.getString("userToken") ?? "";
    userId = sharedPreferences.getString("userId") ?? "";
  }

  //.............. contacts info ....................
  RxList<String> featureList = [""].obs;
  var contactController = TextEditingController();

  void addContact() {
    featureList.add("");
    update();
  }

  void removeContact(index) {
    featureList.removeAt(index);
    update();
  }

  String getPosition(index) {
    switch (index) {
      case 1:
        return "Enter 1st Feature";
      case 2:
        return "Enter 2nd Feature";
      case 3:
        return "Enter 3rd Feature";
      default:
        return "Enter ${index}th Feature";
    }
  }

  /// ....................Feature Photo Picker ...................
  String? originalImage;
  Rx<String> featureImage = ''.obs;
  String base64featureImage = '';

  pickImage() async {
    await Utils.pickSingleImage().then((value) async {
      if (value != null) {
        originalImage = value;
        File file = File(originalImage!);
        if (file != null) {
          featureImage.value = file.path;
          List<int> imageBytes = await file.readAsBytes();
          base64featureImage =
              'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';
        }
      }
    });
    update();
    return base64featureImage;
  }

  void deleteFeatureImage() {
    originalImage = null;
    featureImage.value = '';
    base64featureImage = '';
    update();
  }

  /// ....................Gallery Photo Picker ...................
  final ImagePicker picker = ImagePicker();
  // Rx<List<XFile>> images = Rx<List<XFile>>([]);
  // List<String> base64Images = [];
  //
  // Future<List<String>?> pickImages() async {
  //   List<String> imagePaths = [];
  //   List<XFile>? tempImages = await picker.pickMultiImage();
  //   if (tempImages == null) {
  //     return imagePaths;
  //   } else {
  //     images.value = tempImages;
  //     base64Images = [];
  //     for (XFile file in images.value) {
  //       List<int> imageBytes = await file.readAsBytes();
  //       base64Images.add(
  //           'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}');
  //       print(file.path.split('.').last);
  //       imagePaths.add(file.path);
  //     }
  //     update();
  //     return base64Images;
  //   }
  // }

  /// Get SubCategory with Category
  RxList<Branding> subcategoryList = <Branding>[].obs;
  Branding? subcategory;
  String selectedSubcategory = '';

  getSubcategory(int value) {
    subcategoryList.value = categoryList.value
        .singleWhere((element) => element.id == value)
        .subcategories
        .toSet()
        .toList();
    if (subcategoryList.isNotEmpty) {
      subcategory = subcategoryList[0];
      selectedSubcategory = subcategoryList[0].id.toString();
      print('has data');
    } else {
      print('has no data');
    }
    update();
  }

  /// Get SubCategory with Category
  RxList<Model> modelList = <Model>[].obs;
  Model? model;
  String selectedModel = '';
  TextEditingController selectedModelElectronics = TextEditingController();
  TextEditingController selectedEditionElectronics = TextEditingController();

  // getModel() {
  //   print('####################');
  //   print(brandList.value.length);
  //   modelList.value = brandList.value
  //       .singleWhere((element) => element.id == int.parse(selectedBrand))
  //       .models
  //       .toSet()
  //       .toList();
  //   if (modelList.isNotEmpty) {
  //     model = modelList[0];
  //     selectedModel = modelList[0].id.toString();
  //     print('has data');
  //   } else {
  //     print('has no data');
  //   }
  // }

  bool isTitleOkay() {
    if (titleController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isPriceOkay(catId) {
    if (priceController.text.isNotEmpty) {
      return true;
    }
    if (catId=="18") {
      return true;
    }
    return false;
  }

  bool isDescriptionOkay() {
    if (descriptionController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  RxString adId = ''.obs;

  Future<void> postAds(controller) async {
    if (base64featureImage.isNotEmpty) {
      final body = <String, dynamic>{};
      body.addAll({"title": titleController.text.trim()});
      body.addAll({"category_id": selectedCategoryId.value});
      body.addAll({"subcategory_id": selectedSubcategory});
      body.addAll({"address": locationController.text.trim()});
      body.addAll({"price": priceController.text.trim()});
      body.addAll({"email": emailController.text.trim()});
      body.addAll({"phone": phoneController.text.trim()});
      if (selectedCategoryId.value == '1' ||
          selectedCategoryId.value == '22' ||
          selectedCategoryId.value == '3') {
        body.addAll({"brand_id": brandModel.value!.id.toString()});
      }
      body.addAll({"show_phone": isShowPhone.value == true ? "1" : "0"});
      body.addAll({"show_email": isShowEmail.value == true ? "1" : "0"});
      body.addAll({"show_whatsapp": isShowWhatsapp.value == true ? "1" : "0"});
      body.addAll({"whatsapp": whatsappController.text.trim()});
      body.addAll({"features": featureList.toString()});
      body.addAll({"thumbnail": base64featureImage}); // feature image
      body.addAll({"images": base64Images.toString()}); //gallery image
      body.addAll({"description": descriptionController.text.trim()});
      body.addAll({"website": webSiteController.text.trim()});
      body.addAll({"condition": selectedCondition.value});
      body.addAll({"authenticity": selectedAuthenticities.value});

      body.addAll({"ads_type": selectedSize});

      body.addAll({"property_type": selectedPropertyType});
      body.addAll({"property_size": sizeController.text.trim()});
      body.addAll({"property_unit": selectedPropertySize});
      body.addAll({"property_price_type": selectedPropertyPrice});

      body.addAll({"designation": selectedDesignation});
      body.addAll({"job_type": selectedJobType});
      body.addAll({"experience": experienceController.text.trim()});
      body.addAll({"required_education": selectedEducation.value});
      body.addAll(
          {"receive_is_email": receiveIsEmail.value == true ? "1" : '0'});
      body.addAll(
          {"receive_is_phone": receiveIsPhone.value == true ? "1" : '0'});
      body.addAll({"salary_from": salaryFromController.text.trim()});
      body.addAll({"salary_to": salaryToController.text.trim()});
      body.addAll({"deadline": expiryDateController.text.trim()});
      body.addAll({"employer_name": employerNameController.text.trim()});
      body.addAll({"employer_email": employerEmailController.text.trim()});
      body.addAll({"employer_phone": employerPhoneController.text.trim()});
      body.addAll({"employer_logo": base64ImageLogo ?? ''});

      body.addAll({"textbook_type": selectedEducation.value});

      body.addAll(
          {"vehicle_manufacture": manufactureYearController.text.trim()});
      body.addAll(
          {"vehicle_engine_capacity": engineCapacityController.text.trim()});
      body.addAll({"vehicle_fule_type": fuelTypes.toString()});
      body.addAll({"vehicle_transmission": selectedTransmission});
      body.addAll({"vehicle_body_type": selectedBodyType});
      body.addAll(
          {"registration_year": registrationYearController.text.trim()});
      body.addAll({"model": selectedModelElectronics.text.trim()}); // need
      body.addAll({"edition": selectedEditionElectronics.text.trim()}); // need
      body.addAll({"education": selectedEducation.value.trim()}); // need

      isPostAdsLoading.value = true;
      final result = await adsRepository.postAds(token, body);

      result.fold((error) {
        isPostAdsLoading.value = false;
        Utils.toastMsg(error.message);
      }, (data) async {
        // clearAll();
        adId.value = data;
        print(adId.value);
        Navigator.pop(Get.context!);
        if (isPaymentChecked.value) {
          Get.toNamed(Routes.featured, arguments: controller);
        } else {
          clearAll();
          Utils.toastMsg('Ads has been created successfully');
        }
        isPostAdsLoading.value = false;
      });
    } else {
      Utils.toastMsg('Featured Image Needed');
    }
  }

  Future<void> paypalPaymentSuccess(tranxId) async {
    final body = <String, dynamic>{};
    body.addAll({'transaction_id': tranxId});
    body.addAll({'payment_provider': 'Paypal'});
    body.addAll({'promotion_id': priority.value!.id.toString()});
    body.addAll({'status': 'paid'});
    body.addAll({'ad_id': adId.value});

    final result = await adsRepository.paypalPaymentSuccess(token, body);
    result.fold((error) {
      print(error.toString());
      isPostAdsLoading.value = false;
      Utils.toastMsg(error.message);
    }, (data) async {
      clearAll();
      print(data.toString());
      // Navigator.pop(Get.context!);
      Utils.toastMsg(data);
      isPostAdsLoading.value = false;
    });
  }

  clearAll() {
    titleController.text = "";
    locationController.text = "";
    priceController.text = "";
    phoneController.text = "";
    whatsappController.text = "";
    descriptionController.text = "";
  }

  chooseDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: expirySelectedDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2050),
        // initialDatePickerMode: DatePickerMode.year,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.grey.shade700,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Color(0xFF000000),
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      expirySelectedDate = newSelectedDate;
      expiryDateController
        ..text = formatter.format(expirySelectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: expiryDateController.text.length,
            affinity: TextAffinity.upstream));
      expiryDate = expiryDateController.text;
    }
  }

  /// ....................Feature Photo Picker ...................
  String? galleryImage;
  String? gallerySingleImage;
  String? base64gallerySingleImage;
  List<String> base64Images = [];
  RxList<File> images = <File>[].obs;

  pickGalleryImageFromGallery() async {
    await Utils.pickSingleImageFromGallery().then((value) async {
      if (value != null) {
        galleryImage = value;
        File file = File(galleryImage!);
        if (file != null) {
          gallerySingleImage = file.path;
          images.add(file);
          List<int> imageBytes = await file.readAsBytes();
          base64gallerySingleImage =
          'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';

          print("feature image is: ${base64gallerySingleImage}");
          // context.read<AdEditProfileCubit>().base64Image = base64Image!;
          base64Images.add(base64gallerySingleImage.toString());
        }
      }
    });
    update();
    return base64gallerySingleImage;
  }

  pickGalleryImageFromCamera() async {
    await Utils.pickSingleImageFromCamera().then((value) async {
      if (value != null) {
        galleryImage = value;
        File file = File(galleryImage!);
        if (file != null) {
          gallerySingleImage = file.path;
          images.add(file);
          List<int> imageBytes = await file.readAsBytes();
          base64gallerySingleImage =
          'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';

          print("feature image is: ${base64gallerySingleImage}");
          // context.read<AdEditProfileCubit>().base64Image = base64Image!;
          base64Images.add(base64gallerySingleImage.toString());
        }
      }
    });
    update();
    return base64gallerySingleImage;
  }

  void removeImages(int index) {
    // if (index > 0 && index <= base64Images.length) {
    //   List<File> temp = [];
    //   List<String> tempBase = [];
    //   for (int i = 0; i < images!.length; i++) {
    //     if (index - 1 != i) {
    //       temp.add(images![i]);
    //       tempBase.add(base64Images[i]);
    //     }
    //   }
    //   base64Images = tempBase;
    //   images = temp;
    //   update();
    // }

    images.removeAt(index - 1);
    update();
  }

}
