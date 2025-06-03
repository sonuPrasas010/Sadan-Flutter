import 'dart:developer';

import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class ChatCOntrller extends GetxController {
  bool isLoading = true;
  List chats = [];

  @override
  void onInit() {
    getChats();
    super.onInit();
  }

  void getChats() async {
    isLoading = true;
    update();

    try {
      dataFetcher.setUrl("${API_URL}/api/all-chats");
      var response = await dataFetcher.fetchGetData({
        "x-access-token": loginController.token ??
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ"
      });
      log(response.toString());
      chats = response['data'];
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }
}
