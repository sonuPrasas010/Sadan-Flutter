import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sadan/components/file_not_found_widget.dart';
import 'package:sadan/components/forms/text_divider.dart';
import 'package:sadan/components/verifiable_template.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/controllers/admin_controller/pending_renter_controller.dart';
import 'package:sadan/controllers/admin_controller/verified_renter_controller.dart';
import 'package:sadan/main.dart';
import 'package:sadan/pages/admin/verify_customer.dart';

class VerifyRenter extends StatelessWidget {
  const VerifyRenter({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Renter/List",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Color(0xFF277da8),
            indicatorWeight: 4,
            labelPadding: EdgeInsets.symmetric(horizontal: 15),
            isScrollable: true,
            labelColor: Color(0xFF332d2b),
            tabs: [
              Tab(text: "Pending"),
              Tab(
                text: "Verified",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PendingRenter(),
            VerifiedRenter(),
          ],
        ),
      ),
    );
  }
}

class PendingRenter extends StatelessWidget {
  PendingRenterController pendingVehicleController =
      Get.put(PendingRenterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendingRenterController>(
        init: pendingVehicleController,
        builder: (controller) {
          if (controller.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (controller.pendingRenterRequest.isEmpty) {
            return SingleChildScrollView(child: FileNotFoundWidget());
          }
          return Column(
            children: [
              SearchBYWidget(),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.pendingRenterRequest.length,
                  itemBuilder: (context, index) {
                    log(controller.pendingRenterRequest[index].toString());
                    List<String> names = [];
                    String brand = controller.pendingRenterRequest[index]
                            ['name']
                        .toString();
                    String model = controller.pendingRenterRequest[index]
                            ['phone']
                        .toString();
                    String color = controller.pendingRenterRequest[index]['dob']
                        .toString();
                    String manufatureYear = controller
                        .pendingRenterRequest[index]['address']
                        .toString();
                    String ratePerHrs = controller.pendingRenterRequest[index]
                            ['gender']
                        .toString();
                    String ratePerDat = controller.pendingRenterRequest[index]
                            ['idNumber']
                        .toString();

                    names.add(brand);
                    names.add(model);
                    names.add(color);
                    names.add(manufatureYear);
                    names.add(ratePerHrs);
                    names.add(ratePerDat);

                    return VerifiableTemplate(
                      images: [
                        controller.pendingRenterRequest[index]["image"],
                        controller.pendingRenterRequest[index]["image1"],
                      ],
                      texts: names,
                      RatePerday: ratePerDat,
                      bandName: brand,
                      color: color,
                      lastServiceDate: "2023/1/3",
                      manufactureYear: manufatureYear,
                      model: model,
                      ratePerHour: ratePerHrs,
                      onVerify: () {
                        dataFetcher.setUrl(
                            "${API_URL}/api/accept-pending-renter-request/${controller.pendingRenterRequest[index]['id']}");
                        dataFetcher.fetchPostData(
                            {"x-access-token": loginController.token ?? ""},
                            {});
                        controller.pendingRenterRequest.removeAt(index);
                        controller.update();
                      },
                      onCancel: () {
                        dataFetcher.setUrl(
                            "${API_URL}/api/cancel-pending-renter-request/${controller.pendingRenterRequest[index]['id']}");
                        dataFetcher.fetchPostData(
                            {"x-access-token": loginController.token ?? ""},
                            {});
                        controller.pendingRenterRequest.removeAt(index);
                        controller.update();
                      },
                    );
                  },
                  separatorBuilder: (_, index) => TextDivider(text: "j"),
                ),
              ),
            ],
          );
        });
  }
}

class VerifiedRenter extends StatelessWidget {
  VerifiedRenterController verifiedVEhicleCOntroller =
      Get.put(VerifiedRenterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifiedRenterController>(
        init: verifiedVEhicleCOntroller,
        builder: (controller) {
          if (controller.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (controller.pendingRenterRequest.isEmpty) {
            return SingleChildScrollView(child: FileNotFoundWidget());
          }
          return Column(
            children: [
              SearchBYWidget(),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (_, index) => TextDivider(text: ""),
                    itemCount: controller.pendingRenterRequest.length,
                    itemBuilder: (context, index) {
                      List<String> names = [];
                      String brand =
                          controller.pendingRenterRequest[index]['name'];
                      String model =
                          controller.pendingRenterRequest[index]['phone'];
                      String color =
                          controller.pendingRenterRequest[index]['dob'];
                      String manufatureYear =
                          controller.pendingRenterRequest[index]['address'];
                      String ratePerHrs =
                          controller.pendingRenterRequest[index]['gender'];
                      String ratePerDat =
                          controller.pendingRenterRequest[index]['idNumber'];

                      names.add(brand);
                      names.add(model);
                      names.add(color);
                      names.add(manufatureYear);
                      names.add(ratePerHrs);
                      names.add(ratePerDat);

                      if (controller.pendingRenterRequest[index]['approval'] ==
                          true) {
                        return SizedBox.shrink();
                      }
                      return VerifiableTemplate(
                        images: [
                          controller.pendingRenterRequest[index]["image"],
                          controller.pendingRenterRequest[index]["image1"],
                        ],
                        texts: names,
                        onVerify: null,
                        RatePerday: ratePerDat,
                        bandName: brand,
                        color: color,
                        lastServiceDate: "2023/1/3",
                        manufactureYear: manufatureYear,
                        model: model,
                        ratePerHour: ratePerHrs,
                      );
                    }),
              ),
            ],
          );
        });
  }
}
