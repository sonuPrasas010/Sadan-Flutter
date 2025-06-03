import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sadan/components/vehicles_list_tile.dart';
import 'package:sadan/controllers/user_controller/user_ge_vehiclet_booking_controller.dart';
import 'package:sadan/pages/user/vehicle/pending_order_info.dart';

class UserMyBooking extends StatelessWidget {
  UserGetVehicleBookingController _controlller =
      Get.put(UserGetVehicleBookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Booking"),
        leading: SizedBox.shrink(),
      ),
      body: GetBuilder<UserGetVehicleBookingController>(
        init: _controlller,
        builder: (controller) {
          if (controller.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (controller.myBooking.isEmpty)
            return Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You Havent booked any vehicle yet. Please referesh here after booking vehicle.",
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    onPressed: () {
                      controller.getBooking();
                    },
                    child: Text("Refresh")),
              ],
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
                    Get.to(() => UserPendingOrderInfo(
                        controller.myBooking[index]['id']));
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
