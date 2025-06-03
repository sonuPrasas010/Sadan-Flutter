import 'dart:developer';

import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class VerifiedCustomerController extends GetxController {
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
      dataFetcher.setUrl("${API_URL}/api/admin-user");
      var response = await dataFetcher
          .fetchGetData({"x-access-token": "${loginController.token}"});
      pendingVehicleRequest = response['data'];
      log(response.toString());
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  bool isLoading = true;
}
