import 'dart:convert';
import 'package:ekayzoneukapps/apps/core/utils/k_strings.dart';
import 'package:ekayzoneukapps/apps/core/utils/my_sharedpreferences.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/views/auth/login/model/login_model.dart';
import 'package:ekayzoneukapps/apps/views/splash/languages/model/language_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../error/exception.dart';

abstract class LocalDataSource {
  UserLoginResponseModel getUserResponseModel();

  Future<bool> cacheUserResponse(UserLoginResponseModel userLoginResponseModel);

  Future<bool> clearUserProfile();

  Future<bool> cacheLanguages(List<LanguageModel> languages);

  bool checkLanguage();

  Future<bool> cacheLanguage();

  List<LanguageModel> getCachedLanguages();
}

class LocalDataSourceImpl implements LocalDataSource {
  final _className = 'LocalDataSourceImpl';
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  UserLoginResponseModel getUserResponseModel() {
    final jsonString =
        sharedPreferences.getString(MySharedPreference.cachedUserResponseKey);
    if (jsonString != null) {
      return UserLoginResponseModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  ///
  @override
  Future<bool> cacheUserResponse(
      UserLoginResponseModel userLoginResponseModel) {
    return sharedPreferences.setString(
      MySharedPreference.cachedUserResponseKey,
      userLoginResponseModel.toJson(),
    );
  }

  @override
  Future<bool> clearUserProfile() {
    return sharedPreferences.remove(MySharedPreference.cachedUserResponseKey);
  }

  @override
  bool checkLanguage() {
    final jsonString =
        sharedPreferences.getString(KStrings.isCachedAllLanguage);
    if (jsonString != null) {
      int days = Utils.calculateMaxDays(jsonString, DateTime.now().toString());
      return days > 0 ? false : true;
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheLanguage() {
    return sharedPreferences.setString(
        KStrings.isCachedAllLanguage, DateTime.now().toString());
  }

  @override
  Future<bool> cacheLanguages(List<LanguageModel> languages) async {
    var data = {};
    data["data"] = languages;
    sharedPreferences.setString(KStrings.cachedAllLanguage, json.encode(data));
    for (LanguageModel language in languages) {
      sharedPreferences.setString(
          language.code, json.encode(language.jsonData));
    }
    return true;
  }

  @override
  List<LanguageModel> getCachedLanguages() {
    final jsonString = sharedPreferences.getString(KStrings.cachedAllLanguage);
    if (jsonString != null) {
      var mapData = json.decode(jsonString.toString());
      return List<dynamic>.from(mapData["data"])
          .map((e) => LanguageModel.fromJson(e))
          .toList();
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }
}
