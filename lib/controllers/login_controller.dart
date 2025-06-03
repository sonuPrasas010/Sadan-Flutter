import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/configs/strings.dart';
import 'package:sadan/main.dart';
import 'package:sadan/pages/admin/home_screen.dart';
import 'package:sadan/pages/auth/login.dart';
import 'package:sadan/pages/renter/renter_home.dart';
import 'package:sadan/pages/renter/vehicles/add_vehicle.dart';
import 'package:sadan/pages/user/user_home.dart';
import 'package:sadan/services/data_fetcher.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String? token;
  String? email;

  bool isLoggingIn = false;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  String? emailValidator(String? value) {
    if (value != null && value.isNotEmpty && GetUtils.isEmail(value))
      return null;

    return "Please enter valid email";
  }

  String? passWordValidator(String? value) {
    if (value != null && value.isNotEmpty) return null;

    return "Please enter password";
  }

  void login() async {
    if (!formKey.currentState!.validate()) return;
    isLoggingIn = true;
    update();
    try {
      DataFetcher fetcher = DataFetcher();
      fetcher.setUrl("${API_URL}/api/login");
      var response = await fetcher.fetchPostData({}, {
        "email": emailController.text,
        "password": passwordController.text,
      });
      log("$response");
      if (response['message'] == "success") {
        print("$response");
        email = response['newData']['email'];
        token = response['newData']['token'];
        if (response['newData']['role'] == roles[0]) {
          Get.offAll(() => UserHome());
          return;
        }
        if (response['newData']['role'] == roles[1]) {
          Get.offAll(() => RenterHome());
          return;
        }
        if (response['newData']['role'] == roles[2]) {
          Get.offAll(() => AdminHome());
          return;
        }
      } else {
        Get.rawSnackbar(title: "Invalid", message: "Invalid Credentials");
      }

      print("$response");
    } catch (e) {
      print(e);
      Get.rawSnackbar(title: "Invalid", message: "Invalid Credintials");
    } finally {
      isLoggingIn = false;
      update();
    }
  }
}
