import 'dart:developer';

import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class UserGetVehicleBookingController extends GetxController {
  bool isLoading = true;
  List myBooking = [];

  @override
  void onInit() {
    getBooking();
    super.onInit();
  }

  void getBooking() async {
    isLoading = true;
    update();
    dataFetcher.setUrl("${API_URL}/api/my-booking");
    try {
      var response = await dataFetcher
          .fetchGetData({"x-access-token": loginController.token!});
      log(response.toString());
      myBooking = response['data'];
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }
}
