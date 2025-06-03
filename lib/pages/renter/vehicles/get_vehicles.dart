// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/components/file_not_found_widget.dart';
import 'package:sadan/controllers/renter_controler/get_vehicle_controller.dart';
import 'package:sadan/pages/renter/vehicles/vehicleInfo.dart';


import '../../../components/vehicles_list_tile.dart';

class GetVehicles extends StatelessWidget {
  GetVehicleController getVehicleController = Get.put(GetVehicleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<GetVehicleController>(
          init: getVehicleController,
          builder: (controller) {
            if (controller.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (controller.vehicles.isEmpty) {
              return Column(
                children: [
                  FileNotFoundWidget(),
                  Text(
                      "Please Fill KYC Form and Add your vehicle to see your vehicles"),
                  ElevatedButton.icon(
                      onPressed: () {
                        controller.getVehicles();
                      },
                      icon: Icon(Icons.refresh),
                      label: Text("Refresh")),
                ],
              );
            }
            return RefreshIndicator(
              onRefresh: () async => controller.getVehicles(),
              child: ListView.builder(
                itemCount: controller.vehicles.length,
                itemBuilder: (_, index) => VehicleListTile(
                  brand: controller.vehicles[index]['brand'],
                  vehicleId: controller.vehicles[index]['id'],
                  image: controller.vehicles[index]['image'],
                  lastServiceDae: controller.vehicles[index]['lastServiceDate'],
                  model: controller.vehicles[index]['model'],
                  ratePerDay: controller.vehicles[index]['ratePerDay'],
                  ratePerHour: controller.vehicles[index]['ratePerHrs'],
                  onClick: () {
                    Get.to(() => RenterVehichleInfoScren(
                          controller.vehicles[index]['id'],
                        ));
                  },
                ),
              ),
            );
          }),
    );
  }
}
