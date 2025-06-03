import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';
class ChatInfoController extends GetxController {
  List messages = [];
  bool isLoading = true;
  TextEditingController messageController = new TextEditingController();
  final int receiverId;

  ChatInfoController(this.receiverId);
  @override
  void onInit() {
    getMessages();
    super.onInit();
  }

  void getMessages() async {
    isLoading = true;
    update();
    try {
      dataFetcher.setUrl("${API_URL}/api/get-message/$receiverId");
      log(dataFetcher.url);
      var response = await dataFetcher.fetchGetData({
        "x-access-token": loginController.token ??
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ"
      });

      messages = response['data']['chat'];
      log(messages.toString());
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  void sendMessage() async {
    dataFetcher.setUrl("$API_URL/api/post-message/$receiverId");
    // controller.messages[index]

    messages.add({
      "message": messageController.text,
      "receiver": {"email": ""}
    });
    var msg = messageController.text;
    messageController.text = "";
    update();
    log("msg");

    var response = await dataFetcher.fetchPostData({
      "x-access-token": loginController.token ??
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ",
    }, {
      "message": msg,
    });
    print(response);
  }
}
