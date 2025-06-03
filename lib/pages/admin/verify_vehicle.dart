import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sadan/components/file_not_found_widget.dart';
import 'package:sadan/components/forms/text_divider.dart';
import 'package:sadan/components/verifiable_template.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/controllers/admin_controller/pending_vehicle_controller.dart';
import 'package:sadan/controllers/admin_controller/verified_vehicle_controller.dart';
import 'package:sadan/main.dart';
class VerifyVehicle extends StatefulWidget {
  const VerifyVehicle({super.key});

  @override
  State<VerifyVehicle> createState() => _VerifyVehicleState();
}

class _VerifyVehicleState extends State<VerifyVehicle> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Vehicle/List",
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
            PendingVehicle(),
            VerifiedVehicle(),
          ],
        ),
      ),
    );
  }
}

class VerifiedVehicle extends StatelessWidget {
  VerifiedVehicleController pendingVehicleController =
      Get.put(VerifiedVehicleController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifiedVehicleController>(
        init: pendingVehicleController,
        builder: (controller) {
          if (controller.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (controller.pendingVehicleRequest.isEmpty) {
            return SingleChildScrollView(child: FileNotFoundWidget());
          }
          return RefreshIndicator(
            onRefresh: () async {
              controller.getPendingVechicleRequest();
            },
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Search By',
                    // enabledBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(25.0),
                    //   borderSide: BorderSide(
                    //     color: Colors.green,
                    //     // width: 2.0,
                    //   ),
                    // ),
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_drop_down)),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (_, index) => TextDivider(text: ""),
                      itemCount: controller.pendingVehicleRequest.length,
                      itemBuilder: (context, index) {
                        log(index.toString());
                        List<String> names = [];
                        String brand = "Brand: " +
                            controller.pendingVehicleRequest[index]['brand'];
                        String model = "Model: " +
                            controller.pendingVehicleRequest[index]['model'];
                        String color = "Color: " +
                            controller.pendingVehicleRequest[index]['color'];
                        String manufatureYear = "Manufacture Year: " +
                            controller.pendingVehicleRequest[index]
                                ['manufatureYear'];
                        String ratePerHrs = "Rate Per Hour: " +
                            controller.pendingVehicleRequest[index]
                                ['ratePerHrs'];
                        String ratePerDat = "Rate Per Dat: " +
                            controller.pendingVehicleRequest[index]
                                ['ratePerDay'];
                        String lastServiceDate = "Last Service: " +
                            controller.pendingVehicleRequest[index]
                                ['lastServiceDate'];
                        names.add(brand);
                        names.add(model);
                        names.add(color);
                        names.add(manufatureYear);
                        names.add(ratePerHrs);
                        names.add(ratePerDat);
                        names.add(lastServiceDate);

                        return VerifiableTemplate(
                          images: [
                            controller.pendingVehicleRequest[index]["image"]
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
            ),
          );
        });
  }
}

class PendingVehicle extends StatelessWidget {
  PendingVehicleController pendingVehicleController =
      Get.put(PendingVehicleController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendingVehicleController>(
        init: pendingVehicleController,
        builder: (controller) {
          if (controller.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );

          if (controller.pendingVehicleRequest.isEmpty) {
            return SingleChildScrollView(child: FileNotFoundWidget());
          }
          return RefreshIndicator(
            onRefresh: () async {
              controller.getPendingVechicleRequest();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBYWidget(),
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (_, index) {
                        return TextDivider(text: "");
                      },
                      itemCount: controller.pendingVehicleRequest.length,
                      itemBuilder: (context, index) {
                        List<String> names = [];
                        String brand = "Brand: " +
                            controller.pendingVehicleRequest[index]['brand'];
                        String model = "Model: " +
                            controller.pendingVehicleRequest[index]['model'];
                        String color = "Color: " +
                            controller.pendingVehicleRequest[index]['color'];
                        String manufatureYear = "Manufacture Year: " +
                            controller.pendingVehicleRequest[index]
                                ['manufatureYear'];
                        String ratePerHrs = "Rate Per Hour: " +
                            controller.pendingVehicleRequest[index]
                                ['ratePerHrs'];
                        String ratePerDat = "Rate Per Dat: " +
                            controller.pendingVehicleRequest[index]
                                ['ratePerDay'];
                        String lastServiceDate = "Last Service: " +
                            controller.pendingVehicleRequest[index]
                                ['lastServiceDate'];
                        names.add(brand);
                        names.add(model);
                        names.add(color);
                        names.add(manufatureYear);
                        names.add(ratePerHrs);
                        names.add(ratePerDat);
                        names.add(lastServiceDate);

                        return VerifiableTemplate(
                          images: [
                            controller.pendingVehicleRequest[index]["image"]
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
                                "$API_URL/api/accept-pending-vechile-request/${controller.pendingVehicleRequest[index]['id']}");
                            dataFetcher.fetchPostData(
                                {"x-access-token": loginController.token!}, {});
                            controller.pendingVehicleRequest.removeAt(index);
                            controller.update();
                          },
                          onCancel: () {
                            dataFetcher.setUrl(
                                "$API_URL/api/cancel-pending-vechile-request/${controller.pendingVehicleRequest[index]['id']}");
                            dataFetcher.fetchPostData(
                              {"x-access-token": loginController.token!},
                              {},
                            );
                            controller.pendingVehicleRequest.removeAt(index);
                            controller.update();
                          },
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }
}

class SearchBYWidget extends StatelessWidget {
  const SearchBYWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        hintText: 'Search By',
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(25.0),
        //   borderSide: BorderSide(
        //     color: Colors.green,
        //     // width: 2.0,
        //   ),
        // ),
        suffixIcon:
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_drop_down)),
      ),
    );
  }
}
