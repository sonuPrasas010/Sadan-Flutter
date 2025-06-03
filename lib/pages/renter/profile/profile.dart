import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/controllers/renter_controler/profile_controller.dart';
import 'package:sadan/pages/renter/kyc_screen.dart';

class Profile extends StatelessWidget {
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: profileController,
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              body: profileController.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : profileController.profile.isNotEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                  "${API_URL}${profileController.profile['image']}"),
                              Text(
                                  "Name: ${profileController.profile['name']}"),
                              Text(
                                  "Date OF Birth: ${profileController.profile['deb']}"),
                              Text(
                                  "Phone: ${profileController.profile['phone']}"),
                              Text(
                                  "Address: ${profileController.profile['address']}"),
                              Text(
                                  "gender: ${profileController.profile['gender']}"),
                              Text(
                                  "idNumber: ${profileController.profile['idNumber']}"),
                              Text(
                                  "Is Approved: ${profileController.profile['approval']}"),
                              Text(
                                  "Role: ${profileController.profile['user']['role']}"),
                              Text(
                                  "Email: ${profileController.profile['user']['email']}"),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Get.to(() => KycScreen());
                                },
                                child: Text("Add NEw profile")),
                          ],
                        ),
            ),
          );
        });
  }
}
