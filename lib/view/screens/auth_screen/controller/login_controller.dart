import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/session_management/session_management.dart';
import '../../../../utils/session_management/session_token_keys.dart';
import '../../../../web_services/auth_service.dart';
import '../../../models/user_model.dart';

class LoginController extends GetxController {
  final GlobalKey<ScaffoldState> screenKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _service = AuthService();
  RxString emailErrorMsg = "".obs, passwordErrorMsg = "".obs;
  RxBool isRememberMe = false.obs, showPassword = false.obs;

  bool validateEmail() {
    if (emailController.text.isEmpty) {
      emailErrorMsg.value = "Please enter email";
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailErrorMsg.value = "Please enter valid email";
    } else {
      emailErrorMsg.value = "";
    }
    return emailErrorMsg.isEmpty;
  }

  bool validatePassword() {
    if (passwordController.text.isEmpty) {
      passwordErrorMsg.value = "Please enter password";
    } else {
      passwordErrorMsg.value = "";
    }
    return passwordErrorMsg.isEmpty;
  }

  void onLoginButton() async {
    if (!(validateEmail() & validatePassword())) return;
    FocusScope.of(screenKey.currentContext!).unfocus();
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    var result = await _service.signInUser(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
    Get.back();
    log("=======>$result");
    if (result is UserModel) {
      if (isRememberMe.value) {
        await SessionManagement().saveSession(
          tokenKey: SessionTokenKeys.kIsRememberMeKey,
          tokenValue: "${isRememberMe.value}",
        );
      }
      Get.offAllNamed(kDashboardScreenRoute);
      return;
    }
    Get.snackbar(
      "Error!",
      result.toString(),
      backgroundColor: kPrimaryColor,
      colorText: kWhiteColor,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
