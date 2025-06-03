import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sadan/components/customer_template.dart';
import 'package:sadan/components/file_not_found_widget.dart';
import 'package:sadan/components/forms/text_divider.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/controllers/admin_controller/pending_customer_controller.dart';
import 'package:sadan/controllers/admin_controller/verified_customer_controller.dart';
import 'package:sadan/main.dart';

class VerifyCustomer extends StatefulWidget {
  const VerifyCustomer({super.key});

  @override
  State<VerifyCustomer> createState() => _VerifyCustomerState();
}

class _VerifyCustomerState extends State<VerifyCustomer> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Customer/List",
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
            PendingCustomer(),
            VerifiedCustomer(),
          ],
        ),
      ),
    );
  }
}

class VerifiedCustomer extends StatelessWidget {
  VerifiedCustomerController pendingVehicleController =
      Get.put(VerifiedCustomerController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifiedCustomerController>(
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
                        List<String> names = [];
                        String name =
                            controller.pendingVehicleRequest[index]['name'];
                        String phone =
                            controller.pendingVehicleRequest[index]['phone'];
                        String dob =
                            controller.pendingVehicleRequest[index]['dob'];
                        String manufacture =
                            controller.pendingVehicleRequest[index]['address'];
                        String gender =
                            controller.pendingVehicleRequest[index]['gender'];
                        String identificationNumber =
                            controller.pendingVehicleRequest[index]['idNumber'];
                        String address =
                            controller.pendingVehicleRequest[index]['address'];

                        return VerifiableCusomerTemplate(
                          images: [
                            controller.pendingVehicleRequest[index]["image"],
                            controller.pendingVehicleRequest[index]["image1"],
                          ],
                          texts: names,
                          onVerify: null,
                          address: address,
                          dob: dob,
                          gender: gender,
                          idNumber: identificationNumber,
                          name: name,
                          phone: phone,
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }
}

class PendingCustomer extends StatelessWidget {
  PendingCustomController pendingVehicleController =
      Get.put(PendingCustomController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendingCustomController>(
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
                      separatorBuilder: (_, index) => TextDivider(text: ""),
                      itemCount: controller.pendingVehicleRequest.length,
                      itemBuilder: (context, index) {
                        List<String> names = [];
                        String name =
                            controller.pendingVehicleRequest[index]['name'];
                        String phone =
                            controller.pendingVehicleRequest[index]['phone'];
                        String dob =
                            controller.pendingVehicleRequest[index]['dob'];
                        String manufacture =
                            controller.pendingVehicleRequest[index]['address'];
                        String gender =
                            controller.pendingVehicleRequest[index]['gender'];
                        String identificationNumber =
                            controller.pendingVehicleRequest[index]['idNumber'];
                        String address =
                            controller.pendingVehicleRequest[index]['address'];

                        return VerifiableCusomerTemplate(
                          images: [
                            controller.pendingVehicleRequest[index]["image"],
                            controller.pendingVehicleRequest[index]["image1"],
                          ],
                          texts: names,
                          address: address,
                          dob: dob,
                          gender: gender,
                          idNumber: identificationNumber,
                          name: name,
                          phone: phone,
                          onCancel: () {
                            dataFetcher.setUrl(
                                "${API_URL}/api/cancel-pending-customer-request/${controller.pendingVehicleRequest[index]['id']}");
                            dataFetcher.fetchPostData(
                                {"x-access-token": loginController.token ?? ""},
                                {});
                            controller.pendingVehicleRequest.removeAt(index);
                            controller.update();
                          },
                          onVerify: () {
                            try {
                              dataFetcher.setUrl(
                                  "${API_URL}/api/accept-pending-customer-request/${controller.pendingVehicleRequest[index]['id']}");
                              dataFetcher.fetchPostData({
                                "x-access-token": loginController.token ?? ""
                              }, {});
                              Get.rawSnackbar(
                                  title: "Success",
                                  message: "Verified customer succesfully",
                                  backgroundColor: Colors.green);
                              controller.pendingVehicleRequest.removeAt(index);
                              controller.update();
                            } catch (e) {}
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
