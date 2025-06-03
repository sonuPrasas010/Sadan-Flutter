import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../components/forms/custom_input.dart';
import '../../../components/sizedBoxes/box.dart';
import '../../../controllers/user_controller/book_vehicle_controller.dart';

class BookVehicle extends StatelessWidget {
  late BookVehicleControlller bookVehicleControlller;
  BookVehicle(int id) {
    bookVehicleControlller = Get.put(BookVehicleControlller(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Vehicle"),
      ),
      body: GetBuilder<BookVehicleControlller>(
          init: bookVehicleControlller,
          builder: (controller) {
            return Column(
              children: [
                CustomFormField(
                    name: "Hours",
                    controller: bookVehicleControlller.hrsController),
                SizedBoxH15,
                CustomFormField(
                  onTap: () => bookVehicleControlller.selectDate(context),
                  name: "Date",
                  controller: bookVehicleControlller.dateController,
                ),
                SizedBoxH15,
                CustomFormField(
                    name: "Time",
                    controller: bookVehicleControlller.timeController),
                SizedBoxH15,
                CustomFormField(
                    name: "Address",
                    controller: bookVehicleControlller.noteController),
                SizedBoxH15,
                ElevatedButton(
                    onPressed: bookVehicleControlller.isBooking
                        ? null
                        : () {
                            bookVehicleControlller.bookVehicle();
                          },
                    child: bookVehicleControlller.isBooking
                        ? Text("Booking vehicle")
                        : Text("Book"))
              ],
            );
          }),
    );
  }
}
