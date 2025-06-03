import 'dart:developer';

import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class VerifiedVehicleController extends GetxController {
  List pendingVehicleRequest = [];

  @override
  void onInit() {
    getPendingVechicleRequest();
    super.onInit();
  }

  getPendingVechicleRequest() async {
    isLoading = true;
    update();
    try {
      dataFetcher.setUrl("${API_URL}/api/admin-vehicle");
      var response = await dataFetcher
          .fetchGetData({"x-access-token": "${loginController.token}"});
      pendingVehicleRequest = response['data'];
      log(response);
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  bool isLoading = true;
}
