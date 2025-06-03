import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/controllers/renter_controler/vehicle_info_controller.dart';
import 'package:sadan/main.dart';

class UserReview extends StatelessWidget {
  late VehicleInfoController controller;
  UserReview(this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.rate_review),
          onPressed: () {
            String review = "";
            double rating = 1;
            Get.defaultDialog(
                title: "Review",
                middleText: "Write your review",
                confirm: ElevatedButton(
                    onPressed: () async {
                      // try {
                      dataFetcher
                          .setUrl("$API_URL/api/add-rating/${controller.id}");
                      var response = await dataFetcher.fetchPostData(
                          {"X-access-token": loginController.token!},
                          {"feedback": review, "rating": rating.toString()});
                      controller.reviews
                          .add({"rating": rating, "feedback": review});
                      controller.update();
                      Get.back();
                      // } catch (e) {
                      //   log(e.toString());
                      // }
                    },
                    child: Text("Submit")),
                content: Column(
                  children: [
                    RatingBar.builder(
                        minRating: 1,
                        initialRating: 1,
                        itemBuilder: (context, index) {
                          return Icon(Icons.star);
                        },
                        onRatingUpdate: (_) {
                          rating = _;
                        }),
                    TextFormField(
                      onChanged: (value) => review = value,
                      decoration: InputDecoration(hintText: "Your review"),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "review cannot be empty";
                      },
                    )
                  ],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Back")),
                ]);
          }),
      body: GetBuilder<VehicleInfoController>(builder: (context) {
        if (controller.reviews.isEmpty)
          return Center(child: Text("No reviews yet. Be first to review"));
        return ListView.builder(
          itemCount: controller.reviews.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("images/man.png"),
              ),
              title: Text(
                controller.reviews[index]['feedback'],
              ),
              subtitle: RatingBarIndicator(
                itemBuilder: (_, inxex) => Icon(Icons.star),
                rating: double.parse(
                    controller.reviews[index]['rating'].toString()),
                itemSize: 13,
              ),
            );
          },
        );
      }),
    );
  }
}
