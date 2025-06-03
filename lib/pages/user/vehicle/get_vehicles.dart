// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/components/file_not_found_widget.dart';
import 'package:sadan/components/vehicles_list_tile.dart';
import 'package:sadan/controllers/user_controller/get_vehicle_controller.dart';


class UserGetVehicles extends StatelessWidget {
  late UserGetVehicleController getVehicleController;
  UserGetVehicles(int id) {
    getVehicleController = Get.put(UserGetVehicleController(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicles"),
      ),
      body: GetBuilder<UserGetVehicleController>(
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
                ],
              );
            }
            return ListView.builder(
              itemCount: controller.vehicles.length,
              itemBuilder: (_, index) => VehicleListTile(
                  brand: controller.vehicles[index]['brand'],
                  vehicleId: controller.vehicles[index]['id'],
                  image: controller.vehicles[index]['image'],
                  lastServiceDae: controller.vehicles[index]['lastServiceDate'],
                  model: controller.vehicles[index]['model'],
                  ratePerDay: controller.vehicles[index]['ratePerDay'],
                  ratePerHour: controller.vehicles[index]['ratePerHrs']),
            );
          }),
    );
  }
}
