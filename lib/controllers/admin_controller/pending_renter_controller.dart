import 'dart:developer';

import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class PendingRenterController extends GetxController {
  List pendingRenterRequest = [];
  bool isLoading = true;

  @override
  void onInit() {
    getPendingRentalRequest();
    super.onInit();
  }

  void getPendingRentalRequest() async {
    isLoading = true;
    update();
    try {
      dataFetcher.setUrl("${API_URL}/api/admin-pending-renter");
      var response = await dataFetcher
          .fetchGetData({"x-access-token": "${loginController.token}"});
      print(response);
      log(response['data'].toString());
      pendingRenterRequest = response['data'];
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }
}
