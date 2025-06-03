import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/configs/strings.dart';
import 'package:sadan/main.dart';
import 'package:sadan/pages/auth/login.dart';
import 'package:sadan/services/data_fetcher.dart';

class RegisterController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController nameController;

  String role = roles[0];
  String error = "";

  bool isRegistering = false;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.onInit();
  }

  String? nameValidator(String? value) {
    if (value != null && value.isNotEmpty) return null;

    return "Please enter name";
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

  String? confirmPasswordValidator(String? value) {
    if (value != null && passwordController.text == value) return null;

    return "Please your password and confirm password does not match";
  }

  void changeRole(String? role) {
    this.role = role!;
    update();
  }

  void register() async {
    if (!formKey.currentState!.validate()) return;
    isRegistering = true;
    update();
    try {
      DataFetcher fetcher = DataFetcher();

      fetcher.setUrl("${API_URL}/api/register");
      var response = await fetcher.fetchPostData({}, {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "role": role
      });
      log(response.toString());
      if (response['message'] == "success") {
        Get.rawSnackbar(
            title: "Success",
            message: "Successfully Registered",
            isDismissible: true);

        loginController.emailController.text = emailController.text;
        passwordController.text = passwordController.text;
        Get.to(() => LoginScreen());
        return;
      }
      Get.rawSnackbar(
          title: "Failed", message: "Failed to Register", isDismissible: true);
    } catch (e) {
      print(e);
      Get.rawSnackbar(
          title: "Failed", message: "Failed to Register", isDismissible: true);
    } finally {
      isRegistering = false;
      update();
    }
  }
}
