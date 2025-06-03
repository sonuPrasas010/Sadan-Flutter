import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class BookVehicleControlller extends GetxController {
  final int id;
  BookVehicleControlller(this.id);
  bool isBooking = false;

  TextEditingController oldPassword = new TextEditingController();
  TextEditingController hrsController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();
  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));

    dateController.text = DateFormat.yMd().format(picked!);
  }

  void bookVehicle() async {
    isBooking = true;
    update();
    try {
      print("booking vehicle");
      dataFetcher.setUrl("$API_URL/api/add-booking/$id");
      var respinse = await dataFetcher.fetchPostData({
        "x-access-token": loginController.token ??
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ",
      }, {
        "hrs": hrsController.text,
        "date": dateController.text,
        "time": timeController.text,
        "note": noteController.text,
      });
      if (respinse['message'] == "Success") {
        Get.rawSnackbar(
          title: "Success",
          message: "Vehicle booked Successfully",
          backgroundColor: Colors.green,
        );
        return;
      }
      Get.rawSnackbar(
          title: "Error",
          message: "Failed to book",
          backgroundColor: Colors.red);
      return;
    } catch (e) {
      Get.rawSnackbar(
          title: "Error",
          message: "Failed to book",
          backgroundColor: Colors.red);

      print(e);
    } finally {
      isBooking = false;
      update();
    }
  }
}
