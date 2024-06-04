import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/routes/routes.dart';
import 'package:ekayzoneukapps/apps/views/auth/login/model/setting_model.dart';
import 'package:ekayzoneukapps/apps/views/auth/repository/auth_repository.dart';
import 'package:ekayzoneukapps/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;

  LoginController(this.authRepository);

  final formKey = GlobalKey();
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isGmailLoading = false.obs;
  RxBool isSettingLoading = false.obs;
  RxBool obscureText = true.obs;
  Rxn<SettingModel> settingModel = Rxn<SettingModel>();

  ///google auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  ///facebook auth
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  String token = "";
  String userId = "";

  @override
  void onInit() {
    super.onInit();

    /// set user data if user already login
    // final result = authRepository.getCashedUserInfo();
    // result.fold(
    //   (l) => _user = null,
    //   (r) {
    //     user = r;
    //   },
    // );
    // getSettingData();
  }

  // void getSettingData() async {
  //   isSettingLoading.value = true;
  //   final result = await authRepository.getSettingData();
  //   result.fold((error) {
  //     isSettingLoading.value = false;
  //     print(error.message);
  //   }, (data) async {
  //     settingModel.value = data;
  //     isSettingLoading.value = false;
  //   });
  // }

  void toggle() {
    obscureText.toggle();
    update();
  }

  bool isEmailOkay() {
    if (emailCtr.text.isNotEmpty && GetUtils.isEmail(emailCtr.text)) {
      return true;
    }
    return false;
  }

  bool isPasswordOkay() {
    if (passwordCtl.text.isNotEmpty && passwordCtl.text.length > 2) return true;
    return false;
  }

  void login() async {
    if (isEmailOkay() && isPasswordOkay()) {
      final body = <String, String>{};
      body.addAll({"email": emailCtr.text.trim()});
      body.addAll({"password": passwordCtl.text.trim()});

      isLoading.value = true;
      final result = await authRepository.login(body);
      result.fold((error) {
        isLoading.value = false;
        Utils.toastMsg(error.message);
      }, (data) async {
        sharedPreferences.setString("userToken", data.loginToken);
        sharedPreferences.setString("userId", data.user.id.toString());
        sharedPreferences.setString("userName", data.user.username.toString());
        token = sharedPreferences.getString("userToken") ?? "";
        emailCtr.text = "";
        passwordCtl.text = "";
        isLoading.value = false;
        Get.offAllNamed(Routes.main);
      });
    } else if (!isEmailOkay()) {
      Utils.toastMsg("Please enter your email");
    } else if (!isPasswordOkay()) {
      Utils.toastMsg("Please enter your password");
    }
  }

  Future<void> handleGoogleSignIn() async {
    GoogleSignIn googleSignIn =
        GoogleSignIn(signInOption: SignInOption.standard, scopes: ['email']);

    await googleSignIn.signIn().then((GoogleSignInAccount? acc) async {
      GoogleSignInAuthentication auth = await acc!.authentication;

      ///
      if (auth.accessToken != null) {
        final body = <String, dynamic>{};
        body.addAll({'id': acc.id});
        body.addAll({'name': acc.displayName});
        body.addAll({'username': acc.displayName});
        body.addAll({'email': acc.email});
        body.addAll({'token': auth.accessToken});
        body.addAll({'provider': 'google'});

        isGmailLoading.value = true;
        final result = await authRepository.socialLogin(body);
        result.fold(
          (error) {
            Utils.toastMsg(error.message);
            isGmailLoading.value = false;
          },
          (data) {
            sharedPreferences.setString("userToken", data.loginToken);
            sharedPreferences.setString(
                "userId", data.user.id.toString() ?? "");
            token = sharedPreferences.getString("userToken") ?? "";
            userId = sharedPreferences.getString("userId") ?? "";
            Get.offAndToNamed(Routes.main);
            isGmailLoading.value = false;
          },
        );
      }
    });
  }

  Future<UserCredential?> handleFbSignIn() async {
    try {
      final LoginResult result = await _facebookAuth.login();
      final AuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      return await _fbAuth.signInWithCredential(credential);
    } catch (error) {
      print(error);
      return null;
    }
  }
}
