import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sadan/controllers/renter_controler/chats/chat_controller.dart';

import '../../../components/conversations_list_widger.dart';
import '../../../main.dart';
import 'chat_info.dart';

class Chats extends StatelessWidget {
  ChatCOntrller chatCOntrller = Get.put(ChatCOntrller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox.shrink(),
          title: Text(
            'Conversations',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<ChatCOntrller>(
            init: chatCOntrller,
            builder: (controller) {
              if (controller.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (controller.chats.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            chatCOntrller.getChats();
                          },
                          child: Text("Refresh")),
                      Text("Your Conversation List is empty"),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                  onRefresh: () async {
                    controller.getChats();
                  },
                  child: ListView.builder(
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        if (controller.chats[index]['receiver']['email'] ==
                            loginController.emailController.text) {
                          Get.to(() => ChatInfo(
                              controller.chats[index]['sender']['id']));
                          return;
                        }
                        Get.to(() => ChatInfo(
                            controller.chats[index]['receiver']['id']));
                      },
                      child: ConversationListWidget(
                        'images/profile.png',
                        '${controller.chats[index]['receiver']['name']}',
                        '${controller.chats[index]['message']}',
                        "${DateFormat.yMMMMd().format(DateTime.parse(controller.chats[index]['createdAt']))}",
                      ),
                    ),
                    itemCount: controller.chats.length,
                  ));
            }),
      ),
    );
  }
}
