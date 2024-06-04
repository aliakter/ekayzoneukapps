import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ekayzoneukapps/apps/data/error/exception.dart';
import 'package:ekayzoneukapps/apps/data/remote_urls.dart';
import 'package:ekayzoneukapps/apps/global_widget/categories_model.dart';
import 'package:ekayzoneukapps/apps/global_widget/settings_model.dart';
import 'package:ekayzoneukapps/apps/views/ad_details/model/ad_details_model.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/model/ad_post_response_model.dart';
import 'package:ekayzoneukapps/apps/views/ads/model/adlist_response_model.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/model/ad_edit_model.dart';
import 'package:ekayzoneukapps/apps/views/auth/login/model/login_model.dart';
import 'package:ekayzoneukapps/apps/views/home/models/home_model.dart';
import 'package:ekayzoneukapps/apps/views/my_ads/model/user_ads_model.dart';
import 'package:ekayzoneukapps/apps/views/public_profile/model/public_profile_model.dart';
import 'package:ekayzoneukapps/apps/views/splash/languages/model/language_model.dart';
import 'package:ekayzoneukapps/apps/views/transection/model/transaction_model.dart';
import 'package:ekayzoneukapps/main.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../views/auth/login/model/setting_model.dart';
import '../../views/chat/model/chat_list_model.dart';
import '../../views/chat_details/model/chat_details_model.dart';
import '../../views/compare/model/compare_list_model.dart';
import '../../views/dashboard/model/dashboard_model.dart';
import '../../views/price_planing/model/price_planing_model.dart';
import '../../views/profile_update/models/user_profile_models.dart';
import '../../views/user_plan/model/user_plan_model.dart';
import '../../views/wishlist/model/wish_list_model.dart';

abstract class RemoteDataSource {
  Future<UserLoginResponseModel> signIn(Map<String, dynamic> body);

  Future<UserLoginResponseModel> socialLogin(Map<String, dynamic> userInfo);

  Future<int> forgotPassWord(Map<String, dynamic> body);

  Future<UserLoginResponseModel> userRegister(Map<String, dynamic> body);

  Future<HomeModel> getHomeData(String token);

  Future<UserProfileModel> getUserProfile(String token);

  Future<AdDetailsModel> getAdDetails(String token, String slug);

  Future<AdListResponseModel> getAdsListData(
      String token,
      String searchText,
      String location,
      String selectedCity,
      String minPrice,
      String maxPrice,
      String sortingValue,
      String categoryValue,
      String page);

  Future<String> updateProfile(String token, Map<String, dynamic> body);

  Future<PublicProfileModel> getPublicShop(
      String token, String userName, String page);

  Future<List<TransactionModel>> getTransaction(String token);

  Future<String> changePassword(String token, dynamic data);

  Future<String> deleteAccount(String token, String delete);

  Future<WishlistModel> getWishlistData(String token);

  Future<String> setUnsetWishlist(String token, String id);

  Future<UserAdModel> getUserAdsListData(String token, int index);

  Future<String> deleteAds(String token, String id);

  Future<DashboardModel> getDashboardData(String token);

  Future<SettingModel> getSettingData();

  Future<String> postAds(String token, Map<String, dynamic> body);

  Future<String> paypalPaymentSuccess(String token, Map<String, dynamic> body);

  Future<String> postReport(String token, Map<String, dynamic> body);

  Future<String> updateAds(String token, Map<String, dynamic> body, String id);

  Future<CompareListModel> getCompareListData();

  Future<AdEditModel> getAdEditData(String token, String id);

  Future<CategoriesModel> getCategoriesData(String token);

  Future<SettingsModel> getSettingsData(String token);

  Future<ChatListModel> getChatList(String token);

  Future<ChatDetailsModel> getChatDetails(String token, String user);

  Future<String> sendMessage(
      String token, String user, Map<String, dynamic> body);

  Future<List<LanguageModel>> getLanguages();

  Future<String> setReview(
      String token, String userName, Map<String, dynamic> data);

  Future<UserPlanModel> getUserPlan(String token);

  Future<List<PricePlaningModel>> getPlanData(String token);
}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;
  final _className = 'RemoteDataSourceImpl';

  RemoteDataSourceImpl({required this.client});

  Future<dynamic> callClientWithCatchException(
      CallClientMethod callClientMethod) async {
    try {
      final response = await callClientMethod();
      if (kDebugMode) {
        print("status code : ${response.statusCode}");
        print(response.body);
      }
      return _responseParser(response);
    } on SocketException {
      log('SocketException', name: _className);
      throw const NetworkException(
          'Please check your \nInternet Connection', 10061);
    } on FormatException {
      log('FormatException', name: _className);
      throw const DataFormatException('Data format exception', 422);
    } on TimeoutException {
      log('TimeoutException', name: _className);
      throw const NetworkException('Request timeout', 408);
    }
  }

  ///User Registration
  @override
  Future<UserLoginResponseModel> userRegister(Map<String, dynamic> body) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userRegistration);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"].toString();
      throw UnauthorisedException(errorMsg, 401);
    }
    if (responseJsonBody["success"] == true && responseJsonBody["code"]==201) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    }
    else {
      // Map<String, dynamic> data = responseJsonBody["data"];
      return UserLoginResponseModel.fromMap(responseJsonBody["data"]);
    }
  }

  ///User Login
  @override
  Future<UserLoginResponseModel> signIn(Map<String, dynamic> body) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userLogin);
    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    }
    {
      return UserLoginResponseModel.fromMap(responseJsonBody["data"]);
    }
  }

  ///Social login
  @override
  Future<UserLoginResponseModel> socialLogin(
      Map<String, dynamic> userInfo) async {
    final uri = Uri.parse(RemoteUrls.socialLogin);

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: userInfo,
    );
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody['data'].toString();
      throw UnauthorisedException(errorMsg, 401);
    }
    {
      return UserLoginResponseModel.fromMap(responseJsonBody["data"]);
    }
  }

  ///User Forgot PassWord
  @override
  Future<int> forgotPassWord(Map<String, dynamic> body) async {
    final headers = {'Accept': 'application/json'};

    final uri = Uri.parse(RemoteUrls.forgotPassWord);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["status"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["status"];
    }
  }

  ///User Profile
  @override
  Future<UserProfileModel> getUserProfile(String token) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final uri = Uri.parse(RemoteUrls.userProfile);

    final clientMethod = client.post(uri, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return UserProfileModel.fromJson(responseJsonBody["data"]);
    }
  }

  /// Get Home Data
  @override
  Future<HomeModel> getHomeData(String token) async {
    final url = Uri.parse(RemoteUrls.home);
    print("Home url: ${url}");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return HomeModel.fromMap(responseJsonBody["data"]);
    }
  }

  /// Get AdList Data
  @override
  Future<AdListResponseModel> getAdsListData(
      String token,
      String searchText,
      String location,
      String selectedCity,
      String minPrice,
      String maxPrice,
      String sortingValue,
      String categoryValue,
      String page) async {
    final url = Uri.parse(RemoteUrls.adsList(searchText, selectedCity, location,
        minPrice, maxPrice, sortingValue, categoryValue, page));

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return AdListResponseModel.fromMap(responseJsonBody["data"]);
    }
  }

  /// Get Ad Details Data
  @override
  Future<AdDetailsModel> getAdDetails(String token, String slug) async {
    final url = Uri.parse(RemoteUrls.adDetails(slug));
    print("Ad Details: $url");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return AdDetailsModel.fromMap(responseJsonBody["data"]);
    }
  }

  ///UPDATE PROFILE
  @override
  Future<String> updateProfile(String token, Map<String, dynamic> body) async {
    final url = Uri.parse(RemoteUrls.editProfile);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers, body: body);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody['message'];
    }
  }

  ///password change
  @override
  Future<String> changePassword(String token, dynamic data) async {
    final url = Uri.parse(RemoteUrls.changePassword);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers, body: data);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody['message'];
    }
  }

  ///delete account
  @override
  Future<String> deleteAccount(String token, String delete) async {
    final url = Uri.parse(RemoteUrls.deleteAccountApi(delete));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.delete(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody['message'];
    }
  }

  ///user plan
  @override
  Future<UserPlanModel> getUserPlan(String token) async {
    final url = Uri.parse(RemoteUrls.userPlan);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return UserPlanModel.fromJson(responseJsonBody);
    }
  }

  ///price planing
  @override
  Future<List<PricePlaningModel>> getPlanData(String token) async {
    final url = Uri.parse(RemoteUrls.pricePlaning);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    return List<dynamic>.from(responseJsonBody)
        .map((e) => PricePlaningModel.fromJson(e))
        .toList();
    // return PricePlaningModel.fromJson(responseJsonBody);
    // if (responseJsonBody["success"] == false) {
    //   final errorMsg = responseJsonBody["data"];
    //   throw UnauthorisedException(errorMsg, 401);
    // } else {
    //   return PricePlaningModel.fromJson(responseJsonBody);
    // }
  }

  ///Wish list
  @override
  Future<WishlistModel> getWishlistData(String token) async {
    final url = Uri.parse(RemoteUrls.wishlist);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return WishlistModel.fromJson(responseJsonBody);
    }
  }

  ///unset Wishlist
  @override
  Future<String> setUnsetWishlist(String token, String id) async {
    final url = Uri.parse(RemoteUrls.setUnSetWishlist(id));
    print("Fav : $url");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody['message'];
    }
  }

  ///user ad list
  @override
  Future<UserAdModel> getUserAdsListData(String token, int index) async {
    final url = Uri.parse(RemoteUrls.userAdsList(index));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return UserAdModel.fromJson(responseJsonBody);
    }
  }

  ///compare list
  @override
  Future<CompareListModel> getCompareListData() async {
    final url = Uri.parse(RemoteUrls.compare);
    var items;
    final jsonString = sharedPreferences.getString('compareList');
    if (jsonString != null) {
      List<dynamic> storedList = json.decode(jsonString);
      items = List<int>.from(storedList);
      print("compare : $items");
    }

    print("Compare List url is $url");
    print("Body data is: ${items} and type ${items.runtimeType}");
    var data = jsonEncode({"compare_id": items});
    print("Body data is: ${data}");

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final clientMethod = client.post(url, headers: headers, body: data);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return CompareListModel.fromJson(responseJsonBody);
    }
  }

  @override
  Future<String> deleteAds(String token, String id) async {
    final url = Uri.parse(RemoteUrls.adDelete(id));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.delete(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["message"];
    }
  }

  ///user public profile
  @override
  Future<PublicProfileModel> getPublicShop(
      String token, String userName, String page) async {
    final url = Uri.parse(RemoteUrls.publicProfile(userName, page));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return PublicProfileModel.fromMap(responseJsonBody['data']);
    }
  }

  ///user public profile
  @override
  Future<List<TransactionModel>> getTransaction(String token) async {
    final url = Uri.parse(RemoteUrls.userTransaction);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return List<dynamic>.from(responseJsonBody["data"]["data"])
          .map((e) => TransactionModel.fromJson(e))
          .toList();
    }
  }

  ///set user rating
  @override
  Future<String> setReview(
      String token, String userName, Map<String, dynamic> data) async {
    final url = Uri.parse(RemoteUrls.sellerRating(userName));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers, body: data);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody['message'];
    }
  }

  ///dashboard
  @override
  Future<DashboardModel> getDashboardData(String token) async {
    final url = Uri.parse(RemoteUrls.dashboard);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return DashboardModel.fromJson(responseJsonBody);
    }
  }

  ///setting
  @override
  Future<SettingModel> getSettingData() async {
    final url = Uri.parse(RemoteUrls.settingApi);
    final headers = {'Accept': 'application/json'};

    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return SettingModel.fromJson(responseJsonBody);
    }
  }

  /// Post Ads
  @override
  Future<String> postAds(String token, Map<String, dynamic> body) async {
    final url = Uri.parse(RemoteUrls.postAds);
    // final url = Uri.parse('http://192.168.203.60:8000/api/ads');
    print("add post url: $url");
    String t =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4yMDMuNjA6ODAwMC9hcGkvYXV0aC9sb2dpbiIsImlhdCI6MTcwOTYyNTQyOCwiZXhwIjoxNzEyMjE3NDI4LCJuYmYiOjE3MDk2MjU0MjgsImp0aSI6InNLeE1YQ0xySFRiYUJENFAiLCJzdWIiOiIxIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.Jq92PLSecUUEJAjLrtWHO648yE88-ZsqDOgR3TO5bD8';
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers, body: body);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false ||
        responseJsonBody['status'] == 0) {
      final errorMsg = responseJsonBody["description"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      AdPostResponseModel model =
          AdPostResponseModel.fromJson(responseJsonBody['data']);
      return model.id.toString();
    }
  }

  @override
  Future<String> paypalPaymentSuccess(
      String token, Map<String, dynamic> body) async {
    final url = Uri.parse(RemoteUrls.paypalPaymentSuccess);
    print("add post url: $url");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers, body: body);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["message"];
    }
  }

  /// Post Report
  @override
  Future<String> postReport(String token, Map<String, dynamic> body) async {
    final url = Uri.parse(RemoteUrls.postReport);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final clientMethod = client.post(url, headers: headers, body: body);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["data"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["message"];
    }
  }

  /// Post Ads
  @override
  Future<String> updateAds(
      String token, Map<String, dynamic> body, String id) async {
    final url = Uri.parse(RemoteUrls.updateAds(id));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers, body: body);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["message"];
    }
  }

  ///chat list
  @override
  Future<ChatListModel> getChatList(String token) async {
    final url = Uri.parse(RemoteUrls.chatList);
    print("chat url $url");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return ChatListModel.fromJson(responseJsonBody);
    }
  }

  ///chat details
  @override
  Future<ChatDetailsModel> getChatDetails(String token, String user) async {
    final url = Uri.parse(RemoteUrls.chatDetails(user));
    print('chat details: $url');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return ChatDetailsModel.fromJson(responseJsonBody);
    }
  }

  ///send message
  @override
  Future<String> sendMessage(
      String token, String user, Map<String, dynamic> body) async {
    final url = Uri.parse(RemoteUrls.chatDetails(user));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers, body: body);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody['message'];
    }
  }

  /// Get Ad Details Data
  @override
  Future<AdEditModel> getAdEditData(String token, String id) async {
    final url = Uri.parse(RemoteUrls.adEdit(id));
    print("Ad edit url: $url");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return AdEditModel.fromJson(responseJsonBody["data"]);
  }

  @override
  Future<CategoriesModel> getCategoriesData(String token) async {
    final url = Uri.parse(RemoteUrls.getCategoriesData);
    print("Ad edit url: $url");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return CategoriesModel.fromJson(responseJsonBody["data"]);
  }

  @override
  Future<SettingsModel> getSettingsData(String token) async {
    final url = Uri.parse(RemoteUrls.getSettingsData);
    print("Ad edit url: $url");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    return SettingsModel.fromJson(responseJsonBody["data"]);
  }

  @override
  Future<List<LanguageModel>> getLanguages() async {
    final uri = Uri.parse(RemoteUrls.getLanguages);
    final clientMethod =
        client.get(uri, headers: {'Content-Type': 'application/json'});
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody['message'].toString();
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return List<dynamic>.from(responseJsonBody["data"])
          .map((e) => LanguageModel.fromMap(e))
          .toList();
    }
  }

  dynamic _responseParser(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        final errorMsg = parsingDoseNotExist(response.body);
        throw BadRequestException(errorMsg, 400);
      case 401:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 401);
      case 402:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 402);
      case 403:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 403);
      case 404:
        throw const UnauthorisedException('Request not found', 404);
      case 405:
        throw const UnauthorisedException('Method not allowed', 405);
      case 408:

        ///408 Request Timeout
        throw const NetworkException('Request timeout', 408);
      case 415:

        /// 415 Unsupported Media Type
        throw const DataFormatException('Data format exception');

      case 422:

        ///Unprocessable Entity
        final errorMsg = parsingError(response.body);
        throw InvalidInputException(errorMsg, 422);
      case 500:

        ///500 Internal Server Error
        throw const InternalServerException('Internal server error', 500);

      default:
        throw FetchDataException(
            'Error occurred while communication with Server',
            response.statusCode);
    }
  }

  String parsingError(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['errors'] != null) {
        final errors = errorsMap['errors'] as Map;
        final firstErrorMsg = errors.values.first;
        if (firstErrorMsg is List) return firstErrorMsg.first;
        return firstErrorMsg.toString();
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }

    return 'Unknown error';
  }

  String parsingDoseNotExist(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['notification'] != null) {
        return errorsMap['notification'];
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }
    return 'Credentials does not match';
  }
}
