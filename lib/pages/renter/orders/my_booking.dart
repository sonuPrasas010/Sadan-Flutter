import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sadan/components/vehicles_list_tile.dart';
import 'package:sadan/controllers/renter_controler/get_vehiclet_booking_controller.dart';
import 'package:sadan/pages/renter/orders/pending_order_info.dart';
class MyBooking extends StatelessWidget {
  GetVehicleBookingController _controlller =
      Get.put(GetVehicleBookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Booking"),
        leading: SizedBox.shrink(),
      ),
      body: GetBuilder<GetVehicleBookingController>(
        init: _controlller,
        builder: (controller) {
          if (controller.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (controller.myBooking.isEmpty)
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        controller.getBooking();
                      },
                      child: Text("Refresh")),
                  Text("Looks Like you no booking history. ")
                ],
              ),
            );

          return RefreshIndicator(
            onRefresh: () async {
              controller.getBooking();
            },
            child: ListView.builder(
              itemBuilder: (context, index) {
                return VehicleListTile(
                  brand: controller.myBooking[index]['vechicle']['brand'],
                  vehicleId: controller.myBooking[index]['vechicle']['id'],
                  image: controller.myBooking[index]['vechicle']['image'],
                  lastServiceDae: controller.myBooking[index]['vechicle']
                      ['lastServiceDate'],
                  model: controller.myBooking[index]['vechicle']['model'],
                  ratePerDay: controller.myBooking[index]['vechicle']
                      ['ratePerDay'],
                  ratePerHour: controller.myBooking[index]['vechicle']
                      ['ratePerHrs'],
                  onClick: () {
                    Get.to(() =>
                        PendingOrderInfo(controller.myBooking[index]['id']));
                  },
                );
              },
              itemCount: controller.myBooking.length,
            ),
          );
        },
      ),
    );
  }
}
