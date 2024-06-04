import 'dart:convert';
import 'dart:io';
import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/global_widget/categories_model.dart';
import 'package:ekayzoneukapps/apps/views/ad_details/model/ad_details_model.dart';

import 'package:ekayzoneukapps/apps/views/ads/repository/ads_repository.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/model/ad_edit_model.dart';
import 'package:ekayzoneukapps/apps/views/auth/login/controller/login_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/models/brand_model.dart';
import 'package:ekayzoneukapps/apps/views/my_ads/controller/my_ads_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../main.dart';

class AdEditController extends GetxController {
  final LoginController loginController;
  final MyAdsController myAdsController;

  // final HomeController homeController;
  final AdRepository adRepository;

  AdEditController(
      this.loginController, this.adRepository, this.myAdsController);

  final featureFormKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final whatsappController = TextEditingController();
  final webSiteController = TextEditingController();

  // RxList<Category> categoryList = <Category>[].obs;
  // RxList<DesignationModel> designationsList = <DesignationModel>[].obs;
  Designations? designationsModel;

  /// ....................Feature Photo Picker ...................

  int isFeatured = 0;

  String capitalize(String input) {
    if (input == null || input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  /// .................... Photo Picker ...................
  final ImagePicker picker = ImagePicker();
  // List<XFile>? images = [];
  // List<String> base64Images = [];
  List<String> deletedImages = [];
  //
  // Future<List<String>?> pickImages() async {
  //   List<String> imagePaths = [];
  //   List<XFile>? tempImages = await picker.pickMultiImage();
  //   if (tempImages == null) {
  //     return imagePaths;
  //   } else {
  //     images = tempImages;
  //     base64Images = [];
  //     for (XFile file in images!) {
  //       List<int> imageBytes = await file.readAsBytes();
  //       base64Images.add(
  //           'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}');
  //       imagePaths.add(file.path);
  //     }
  //     update();
  //     return base64Images;
  //   }
  // }

  List<String> imageList = [];
  List<Gallery> imageGallery = [];
  List<Branding> subcategoryList = [];
  Branding? subcategory;
  Rx<String> selectedSubcategory = ''.obs;
  Rx<String> selectedCategory = ''.obs;
  RxList<Branding> brandList = <Branding>[].obs;
  Rxn<Branding> brandModel = Rxn<Branding>();
  String selectedBrand = "";
  String? statusEditType;

  final statusTypeEditList = [
    {"title": "Deactive", "value": "pending"},
    {"title": "Sold", "value": "sold"},
  ];

  ///Job
  String jobType = jobTypeList[0];
  String selectedDesignation = '';
  String selectedJobType = '';
  String education = educationList[0];
  Rx<String> selectedEducation = ''.obs;
  RxBool receiveIsEmail = false.obs;
  RxBool receiveIsPhone = false.obs;
  RxBool receiveIsWhatsApp = false.obs;

  final employerEmailController = TextEditingController();
  final employerPhoneController = TextEditingController();
  final experienceController = TextEditingController();
  final salaryFromController = TextEditingController();
  final salaryToController = TextEditingController();
  final expiryDateController = TextEditingController();
  final employerNameController = TextEditingController();

  ///Fashion
  String selectedSize = '';

  ///mobile
  Rx<String> selectedAuthenticity = "".obs;
  final editionController = TextEditingController();
  String selectedRam = "";

  ///electronic
  final selectedModelElectronics = TextEditingController();
  final selectedEditionElectronics = TextEditingController();

  ///Property
  Rx<String> selectedPropertyType = "".obs;
  final sizeController = TextEditingController();
  final bedroomController = TextEditingController();
  final propertyLocationController = TextEditingController();
  final propertyPriceController = TextEditingController();
  Rx<String> selectedPropertySize = "".obs;
  Rx<String> selectedPropertyPrice = "".obs;

  changeSelectedProperty(value) {
    selectedPropertyType.value = value;
    update();
  }

  changePropertySize(value) {
    selectedPropertySize.value = value;
    update();
  }

  changePropertyPrice(value) {
    selectedPropertyPrice.value = value;
    update();
  }

  ///Vehicles
  String selectedTransmission = "";
  final trimEditionController = TextEditingController();
  final manufactureYearController = TextEditingController();
  final engineCapacityController = TextEditingController();
  final registrationYearController = TextEditingController();
  String selectedBodyType = "";
  List<String> fuelTypes = [];

  RxBool isLoading = false.obs;
  RxBool isUpdateAdsLoading = false.obs;
  AdEditModel? adEditModel;
  String id = '';
  String token = "";
  String userId = "";

  changeEducation(value) {
    selectedEducation.value = value.toString();
    update();
  }

  // changeAuthenticity(value) {
  //   selectedAuthenticities = value.toString();
  //   update();
  // }

  @override
  void onInit() {
    super.onInit();
    getToken();
    id = Get.arguments;
    // categoryList = homeController.categoryList.value;
    // designationsList.value = homeController.designationsList;
    getCategoriesData();
  }

  Rx<List<Categories>> categoryList = Rx<List<Categories>>([]);
  Rx<List<Designations>> designationsList = Rx<List<Designations>>([]);
  Rxn<Plannings> priority = Rxn<Plannings>();
  Rx<List<Plannings>> items = Rx<List<Plannings>>([]);

  Future<void> getCategoriesData() async {
    isLoading.value = true;
    final result = await adRepository.getCategoriesData(token);
    result.fold((error) {
      isLoading.value = false;
    }, (data) async {
      categoryList.value = data.categories;
      designationsList.value = data.designations;
      for (var val in data.plans) {
        items.value.add(val);
      }
      priority.value = items.value[0];
      getAdEditData().then((value) {
        isLoading.value = false;
      });
    });
  }

  getToken() {
    token = sharedPreferences.getString("userToken") ?? "";
    userId = sharedPreferences.getString("userId") ?? "";
  }

  Rx<List<String>> featureList = Rx<List<String>>([]);

  void addContact() {
    featureList.value.add("");
    update();
  }

  void removeContact(index) {
    featureList.value.removeAt(index);
    update();
  }

  /// Get SubCategory with Category
  RxList<Model> modelList = <Model>[].obs;
  Model? model;
  String selectedModel = '';

  // getModel() {
  //   modelList.value = brandList
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

  Future<void> getAdEditData() async {
    isLoading(true);
    final result = await adRepository.getAdEditData(token, id);
    result.fold((error) {
      isLoading(false);
      print(error.message);
    }, (data) async {
      adEditModel = data;

      getOldData(data).then((value) {
        isLoading(false);
      });
      // getHomeData().then((value) => getOldData(data));
    });
  }

  // Future<void> getHomeData() async {
  //   isLoading.value = true;
  //   final result = await homeController.homeRepository.getHomeData(token);
  //   result.fold((error) {
  //     isLoading.value = false;
  //     print(error.message);
  //   }, (data) async {
  //     categoryList.value = data.categories;
  //     isLoading.value = false;
  //   });
  // }

  RxString selectedCondition = "".obs;

  changeCondition(value) {
    selectedCondition.value = value.toString();
    update();
  }

  // ....................Logo Photo Picker ...................
  final ImagePicker logoPicker = ImagePicker();
  XFile? logoImage;
  String base64ImageLogo = '';

  Future<String?> pickLogoImage() async {
    String? imagePath;
    XFile? tempImage = await logoPicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    if (tempImage == null) {
      return imagePath;
    } else {
      logoImage = tempImage;
      List<int> imageBytes = await logoImage!.readAsBytes();
      base64ImageLogo =
          'data:image/${logoImage!.path.split('.').last};base64,${base64Encode(imageBytes)}';
      return base64ImageLogo;
    }
  }

  // ....................Logo Photo Picker ...................
  final ImagePicker thumbPicker = ImagePicker();

  String? originalImage;
  RxString featureImage = "".obs;
  RxString base64ImageThumb = ''.obs;

  pickThumbImage() async {
    await Utils.pickSingleImage().then((value) async {
      if (value != null) {
        originalImage = value;
        File file = File(originalImage!);
        if (file != null) {
          featureImage.value = file.path;
          List<int> imageBytes = await file.readAsBytes();
          base64ImageThumb.value =
          'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';

          print("feature image is: ${base64ImageThumb.value}");
          // context.read<AdEditProfileCubit>().base64Image = base64Image!;
        }
      }
    });
    update();
    return base64ImageThumb.value;
  }

  //.............Expire Date Choose ...............
  final formatter = DateFormat('yyyy-MM-dd');
  var expiryDate;
  DateTime expirySelectedDate = DateTime.now();

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

  Rxn<Categories> category = Rxn<Categories>();

  Future<void> getOldData(AdEditModel adEditModel) async {
    if (adEditModel.categoryId != 0) {
      for (var val in categoryList.value) {
        if (val.id == adEditModel.categoryId) {
          category.value = val;
          break;
        }
      }

      if (category.value != null) {
        subcategoryList = category.value!.subcategories.toSet().toList();
        if (subcategoryList.isNotEmpty) {
          for (var val in subcategoryList) {
            if (val.id == adEditModel.subcategoryId) {
              subcategory = val;
              print(val.id.toString());
              selectedSubcategory.value = val.id.toString();
            }
          }

          // Branding brand = subcategoryList.singleWhere(
          //     (element) => element.id == adEditModel.subcategoryId);
          // subcategory = brand;
          // selectedSubcategory = subcategory!.id.toString();
        } else {
          subcategory = null;
        }
      }
      update();
    }

    selectedCategory.value = adEditModel.categoryId.toString();
    titleController.text = adEditModel.title ?? "";
    priceController.text =
        adEditModel.price != null ? adEditModel.price.toString() : "";
    locationController.text = adEditModel.address ?? "";
    descriptionController.text = adEditModel.description ?? "";
    phoneController.text = adEditModel.phone ?? "";
    receiveIsPhone.value = adEditModel.receiveIsPhone == 1 ? true : false;
    receiveIsEmail.value = adEditModel.receiveIsEmail == 1 ? true : false;
    receiveIsWhatsApp.value = adEditModel.showWhatsapp == 1 ? true : false;
    selectedEducation.value =
        adEditModel.requiredEducation ?? adEditModel.textbookType ?? '';

    selectedPropertyType.value = adEditModel.propertyType ?? '';
    sizeController.text = adEditModel.propertySize ?? '';
    selectedPropertySize.value = adEditModel.propertyUnit ?? '';
    propertyPriceController.text = adEditModel.price.toString();
    selectedPropertyPrice.value = adEditModel.propertyPriceType ?? '';

    if (selectedCategory.value == '1' ||
        selectedCategory.value == '22' ||
        selectedCategory.value == '3') {
      for (var val in category.value!.brand) {
        if (val.id == adEditModel.brandId) {
          brandModel.value = val;
        }
      }
    }

    for (var val in adEditModel.adFeatures!) {
      print(val.name);
      print('##############');
      featureList.value.add(val.name);
    }
    employerEmailController.text = adEditModel.employerEmail ?? "";
    employerPhoneController.text = adEditModel.employerPhone ?? "";
    experienceController.text = adEditModel.experience.toString() ?? "";
    salaryFromController.text = adEditModel.salaryFrom.toString() ?? "";
    salaryToController.text = adEditModel.salaryTo.toString() ?? "";
    isFeatured = adEditModel.featured ?? 0;
    expiryDateController.text = adEditModel.deadline == null
        ? ""
        : Utils.formatDate(adEditModel.deadline);
    employerNameController.text = adEditModel.employerName ?? "";

    emailController.text = adEditModel.email ?? "";
    whatsappController.text = adEditModel.whatsapp ?? "";
    webSiteController.text = adEditModel.website ?? "";
    selectedCondition.value = adEditModel.condition ?? "";

    selectedSize = adEditModel.adsType ?? "";

    jobType = adEditModel.jobType == null
        ? jobTypeList[0]
        : jobTypeList.singleWhere(
            (element) => adEditModel.jobType.contains(element),
            orElse: () => jobTypeList[0]);

    designationsModel = adEditModel.designation == null
        ? null
        : designationsList.value.singleWhere((element) =>
            adEditModel.designation.toString().trim() ==
            element.title.toString());

    education = adEditModel.requiredEducation == null
        ? educationList[0]
        : educationList.singleWhere(
            (element) => adEditModel.requiredEducation.contains(element),
            orElse: () => educationList[0]);

    selectedModelElectronics.text = adEditModel.model ?? "";
    selectedEditionElectronics.text = adEditModel.edition ?? "";
    selectedAuthenticity.value = adEditModel.authenticity ?? "";
    imageGallery = adEditModel.galleries?.isEmpty ?? [].isEmpty
        ? []
        : adEditModel.galleries ?? [];
    isLoading(false);
  }

  deleteImages(index) {
    deletedImages.add(imageGallery[index].id.toString());
    imageGallery.removeAt(index);
    update();
  }

  Future<void> updateAds() async {
    final body = <String, dynamic>{};
    body.addAll({"title": titleController.text.trim()});
    body.addAll({"category_id": selectedCategory.value});
    body.addAll({"subcategory_id": selectedSubcategory.value});
    body.addAll({"address": locationController.text.trim()});
    body.addAll({"price": priceController.text.trim()});
    body.addAll({"email": emailController.text.trim()});
    body.addAll({"phone": phoneController.text.trim()});
    body.addAll({"show_phone": receiveIsPhone.value.toString()});
    body.addAll({"show_email": receiveIsEmail.value == true ? "1" : "0"});
    body.addAll({"whatsapp": whatsappController.text.trim()});
    body.addAll({"images": base64Images.toString()});
    body.addAll({"description": descriptionController.text.trim()});
    body.addAll({"condition": selectedCondition.value});
    body.addAll({"show_whatsapp": receiveIsWhatsApp.value == true ? "1" : "0"});
    body.addAll({'thumbnail': base64ImageThumb.trim()});
    body.addAll({'website': webSiteController.text.trim()});
    body.addAll({"delete_image": deletedImages.toString()});

    body.addAll({"ads_type": selectedSize});

    if (selectedCategory.value == '1' ||
        selectedCategory.value == '22' ||
        selectedCategory.value == '3') {
      body.addAll({"brand_id": brandModel.value!.id.toString()});
    }
    // body.addAll({"show_phone": isShowPhone.value == true ? "1" : "0"});
    body.addAll({"features": featureList.toString()});
    body.addAll({"thumbnail": base64ImageThumb.value}); // feature image
    body.addAll({"website": webSiteController.text.trim()});
    body.addAll({"authenticity": selectedAuthenticity.value});

    body.addAll({"property_type": selectedPropertyType.value});
    body.addAll({"property_size": sizeController.text.trim()});
    body.addAll({"property_unit": selectedPropertySize.value});
    body.addAll({"property_price_type": selectedPropertyPrice.value});

    body.addAll({"designation": selectedDesignation});
    body.addAll({"job_type": selectedJobType});
    body.addAll({"experience": experienceController.text.trim()});
    body.addAll({"required_education": selectedEducation.value});
    body.addAll({"receive_is_email": receiveIsEmail.value?"1":"0"});
    body.addAll({"receive_is_phone": receiveIsPhone.value?"1":"0"});
    body.addAll({"salary_from": salaryFromController.text.trim()});
    body.addAll({"salary_to": salaryToController.text.trim()});
    body.addAll({"deadline": expiryDateController.text.trim()});
    body.addAll({"employer_name": employerNameController.text.trim()});
    body.addAll({"employer_logo": base64ImageLogo});

    body.addAll({"textbook_type": selectedEducation.value});

    body.addAll({"vehicle_manufacture": manufactureYearController.text.trim()});
    body.addAll(
        {"vehicle_engine_capacity": engineCapacityController.text.trim()});
    body.addAll({"vehicle_fule_type": fuelTypes.toString()});
    body.addAll({"vehicle_transmission": selectedTransmission});
    body.addAll({"vehicle_body_type": selectedBodyType});
    body.addAll({"registration_year": registrationYearController.text.trim()});
    body.addAll({"model": selectedModelElectronics.text.trim()}); // need
    body.addAll({"edition": selectedEditionElectronics.text.trim()}); // need
    body.addAll({"education": selectedEducation.value.trim()});

    isUpdateAdsLoading.value = true;
    final result = await adRepository.updateAds(token, body, id.toString());

    result.fold((error) {
      isUpdateAdsLoading.value = false;
      print(error.message);
      Utils.toastMsg(error.message);
    }, (data) async {
      Utils.toastMsg(data);
      myAdsController.getAdsData().then((value) {
        Navigator.pop(Get.context!);
        isUpdateAdsLoading.value = false;
      });
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

  // List<XFile>? images = [];
  // List<String> base64Images = [];


  String? galleryImage;
  String? gallerySingleImage;
  String? base64gallerySingleImage;
  List<String> base64Images = [];
  List<File>? images = [];

  pickGalleryImageFromCamera() async {
    await Utils.pickSingleImageFromCamera().then((value) async {
      if (value != null) {
        galleryImage = value;
        File file = File(galleryImage!);
        if (file != null) {
          gallerySingleImage = file.path;
          images?.add(file);
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
    // setState(() {});
    return base64gallerySingleImage;
  }

  pickGalleryImageFromGallery() async {
    await Utils.pickSingleImageFromGallery().then((value) async {
      if (value != null) {
        galleryImage = value;
        File file = File(galleryImage!);
        if (file != null) {
          gallerySingleImage = file.path;
          images?.add(file);
          List<int> imageBytes = await file.readAsBytes();
          base64gallerySingleImage =
          'data:image/${file.path.split('.').last};base64,${base64Encode(imageBytes)}';

          print("feature image is: ${base64gallerySingleImage}");
          // context.read<AdEditProfileCubit>().base64Image = base64Image!;
          base64Images.add(base64gallerySingleImage.toString());
        }
      }
    });
    // setState(() {});
    update();
    return base64gallerySingleImage;
  }

  removeImages(index){
    images!.removeAt(index - 1);
    update();
  }
}
