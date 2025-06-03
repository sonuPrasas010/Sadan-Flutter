// aadmin ko home screen ma drawer ko mahuncha 2 wata screen/framework.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/configs/strings.dart';
import 'package:sadan/main.dart';
import 'package:sadan/pages/admin/category.dart';
import 'package:sadan/pages/admin/verify_customer.dart';
import 'package:sadan/pages/auth/login.dart';
import 'package:sadan/services/data_fetcher.dart';

import '../../components/dashboard_widget.dart';
import '../../components/sizedBoxes/box.dart';
import 'verify_renter.dart';
import 'verify_vehicle.dart';

Color? primaryColor = null;

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool isLoading = true;
  Map data = {};

  @override
  void initState() {
    getCounts();
    super.initState();
  }

  void getCounts() async {
    isLoading = true;
    setState(() {});
    DataFetcher dataFetcher = DataFetcher();
    dataFetcher.setUrl("${API_URL}/api/admin-count");
    try {
      log(dataFetcher.url);
      var response = await dataFetcher.fetchGetData(
        {"x-access-token": "${loginController.token}"},
      );
      data = response['data'];
    } catch (e) {
      print(e);
      data.clear();
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: Image.asset(
                  "images/download.jpg",
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            ListTile(
              onTap: () {
                Get.to(() => VerifyRenter());
              },
              title: Text(
                "Renter",
                style: TextStyle(
                  fontSize: 36,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBoxH15,
            SizedBoxH15,
            ListTile(
              title: Text("Vehicle",
                  style: TextStyle(fontSize: 36, color: primaryColor),
                  textAlign: TextAlign.center),
              onTap: () {
                Get.to(() => VerifyVehicle());
              },
            ),
            SizedBoxH15,
            SizedBoxH15,
            ListTile(
              title: Text("User",
                  style: TextStyle(fontSize: 36, color: primaryColor),
                  textAlign: TextAlign.center),
              onTap: () {
                Get.to(() => VerifyCustomer());
              },
            ),
            SizedBoxH15,
            SizedBoxH15,
            ListTile(
              title: Text("Category",
                  style: TextStyle(fontSize: 36, color: primaryColor),
                  textAlign: TextAlign.center),
              onTap: () {
                Get.to(() => Categories(roles[2]));
              },
            ),
            SizedBoxH15,
            SizedBoxH15,
            ListTile(
              title: Text("Log Out",
                  style: TextStyle(fontSize: 36, color: primaryColor),
                  textAlign: TextAlign.center),
              onTap: () {
                Get.offAll(() => LoginScreen());
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Dashboard/Home'),
        centerTitle: true,
        actions: [Icon(Icons.notification_add)],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Welcome anil'),
                        Text('March 3, 2023'),
                      ],
                    ),
                  ),
                  DashboardWidget(
                      'Pending Renter', '${this.data['pendingRenter']}'),
                  DashboardWidget(
                      'Approverd Renter', '${this.data['approvedRenter']}'),
                  DashboardWidget(
                      'Pending Vehicle ', '${this.data['pendingVechicle']}'),
                  DashboardWidget(
                      'Approved Vehicle ', '${this.data['approvedVechicle']}'),
                ],
              ),
            ),
    );
  }
}
