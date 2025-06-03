import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class PendingInfoController extends GetxController {
  bool isLoading = true;
  final int id;
  Map info = {};
  PendingInfoController(this.id);
  @override
  void onInit() {
    getInfo();
    super.onInit();
  }

  void confirmOrder() async {
    if (info.isEmpty) return;
    try {
      dataFetcher.setUrl("${API_URL}/api/confirm-orders/$id");
      await dataFetcher
          .fetchGetData({"x-access-token": loginController.token!});
      info['orderConfirm'] = true;
      update();
      Get.rawSnackbar(
        title: "Success",
        message: "Order Confirmed",
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Get.rawSnackbar(
        title: "Error",
        message: "Failed to conform order",
        backgroundColor: Colors.red,
      );
    }
  }

  void getInfo() async {
    isLoading = true;
    update();
    dataFetcher.setUrl("${API_URL}/api/single-booking/$id");
    try {
      var response = await dataFetcher.fetchGetData({
        "x-access-token": loginController.token ??
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ",
      });
      log(response.toString());
      info = response['data'];
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;

      update();
    }
  }
}
