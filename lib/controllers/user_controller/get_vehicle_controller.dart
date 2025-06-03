import 'dart:developer';

import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class UserGetVehicleController extends GetxController {
  List vehicles = [];
  bool isLoading = false;
  late final int categoryId;
  UserGetVehicleController(this.categoryId);

  @override
  void onReady() {
    getVehicles();
    super.onReady();
  }

  void getVehicles() async {
    log("Getting vehicles");
    isLoading = true;
    update();
    try {
      dataFetcher.setUrl("${API_URL}/api/user-vehicle/$categoryId");
      log(dataFetcher.url);
      var response = await dataFetcher.fetchGetData(
        {
          "x-access-token": loginController.token ??
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ"
        },
      );
      log("got data from fetcher");

      vehicles = response['data'];
    } catch (e) {
      print(e);
    } finally {
      log("finally Getting vehicles");

      isLoading = false;
      update();
    }
  }
}
