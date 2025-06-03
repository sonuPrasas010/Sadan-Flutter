import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPassword = new TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isLoggingIn = false;

  final formKey = GlobalKey<FormState>();

  String? oldPassordValidator(String? value) {
    if (value != null && value.isNotEmpty) return null;

    return "Please Enter old Password";
  }

  String? passWordValidator(String? value) {
    if (value != null && value.isNotEmpty) return null;

    return "Please enter password";
  }

  String? confirmPasswordValidator(String? value) {
    if (value != null && passwordController.text == value) return null;

    return "Please your password and confirm password does not match";
  }

  void changePassword() async {
    if (!formKey.currentState!.validate()) return;
    isLoggingIn = true;
    update();
    try {
      dataFetcher.setUrl("${API_URL}/api/change-password");
      var response = await dataFetcher.fetchPostData({
        "x-access-token": loginController.token ??
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ",
      }, {
        "oldPassword": oldPassword.text,
        "password": passwordController.text,
      });
      if (response['message'] == "success") {
        Get.rawSnackbar(
            title: "success", message: "Password changed successfully");
      } else {
        Get.rawSnackbar(title: "Invalid", message: "Invalid Credintials");
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
