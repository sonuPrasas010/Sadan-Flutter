import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class GetRenterOrderController extends GetxController {
  bool isLoading = true;
  List orders = [];

  void getOrders() async {
    try {
      dataFetcher.setUrl("${API_URL}/api/get-orders");
      var response = await dataFetcher.fetchGetData({
        "x-access-token":
            loginController.token??"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ",
      });

      orders = response['data'];
    } catch (e) {
      print(e);
    } finally {}
  }
}
