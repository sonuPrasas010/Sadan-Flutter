import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/forms/custom_input.dart';
import '../../../controllers/renter_controler/chats/chat_info_controller.dart';
import '../../../main.dart';

class ChatInfo extends StatelessWidget {
  final int id;
  ChatInfo(this.id) {
    controller = Get.put(ChatInfoController(id));
    log(id.toString());
  }
  late ChatInfoController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatInfoController>(
        init: controller,
        builder: (context) {
          return Scaffold(
            body: ListView.builder(
              itemCount: controller.messages.length,
              itemBuilder: (_, index) {
                print(controller.messages[index]['sender']);
                print(loginController.emailController.text);
                if (controller.messages[index]['receiver']['email'] ==
                    loginController.emailController.text) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: UnconstrainedBox(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 50),
                        padding: EdgeInsets.only(
                            left: 5, right: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            controller.messages[index]['message'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                // if(controller.messages[index]['user']==)
                return Align(
                  alignment: Alignment.topRight,
                  child: UnconstrainedBox(
                    child: Container(
                      transformAlignment: Alignment.topRight,
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(
                          top: 5, bottom: 5, left: 50, right: 10),
                      padding: EdgeInsets.only(
                          left: 20, right: 5, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5)),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          controller.messages[index]['message'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            bottomSheet: Row(
              children: [
                Expanded(
                  child: CustomFormField(
                    name: "Message",
                    controller: controller.messageController,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      controller.sendMessage();
                    },
                    child: Text("send")),
              ],
            ),
          );
        });
  }
}
