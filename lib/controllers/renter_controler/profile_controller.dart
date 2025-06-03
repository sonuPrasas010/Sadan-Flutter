import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class ProfileController extends GetxController {
  bool isLoading = true;
  bool isError = false;
  Map profile = {};
  @override
  void onInit() {
    getMyProfile();
    super.onInit();
  }

  getMyProfile() async {
    isLoading = true;
    update();
    try {
      dataFetcher.setUrl("${API_URL}/api/renter-profile");
      var response = await dataFetcher.fetchGetData({
        "x-access-token": loginController.token ??
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ"
      });
      profile = response['data'];
      // log(profiles.toString());
    } on SocketException catch (_) {
      log(_.toString());
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
