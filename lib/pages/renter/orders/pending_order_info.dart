import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/controllers/renter_controler/pending_info_controller.dart';
import 'package:sadan/pages/renter/chat/chat_info.dart';
import 'package:sadan/pages/user/vehicle/book_vehicle.dart';

import '../../../components/vechicle_info_widget.dart';

class PendingOrderInfo extends StatelessWidget {
  late PendingInfoController controller;
  PendingOrderInfo(int id) {
    controller = Get.put(PendingInfoController(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: GetBuilder<PendingInfoController>(
          init: controller,
          builder: (controller) {
            if (controller.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (controller.info.isEmpty)
              return Center(
                child: ElevatedButton(onPressed: () {}, child: Text("Reload")),
              );
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                      "${API_URL}${controller.info['vechicle']['image'].toString().replaceAll('uploads', '')}"),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey[50],
                    ),
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     Text(
                        //       '${controller.info['brand']}',
                        //       maxLines: 1,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.w500, fontSize: 15),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Center(
                        //       child: RatingBar.builder(
                        //         itemBuilder: (_, index) => Icon(
                        //           Icons.star,
                        //           color: Colors.amber,
                        //         ),
                        //         onRatingUpdate: (index) {},
                        //         initialRating: 5,
                        //         itemSize: 15,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Divider(),
                        VehicleDetailWidget(
                            Icons.calendar_month,
                            '${controller.info['vechicle']['model']}',
                            '${controller.info['vechicle']['manufatureYear']}'),
                        VehicleDetailWidget(Icons.home_outlined, 'Address',
                            'Itahari-8, sunsari'),
                        VehicleDetailWidget(
                            Icons.work, 'Open Time', '8 AM - 8 PM'),
                        VehicleDetailWidget(Icons.verified, 'Verified Status',
                            '${controller.info['vechicle']['approval']}'),
                        VehicleDetailWidget(
                            Icons.home_repair_service_sharp,
                            'Last Service Date',
                            '${controller.info['vechicle']['lastServiceDate']}'),
                      ],
                    ),
                  ),
                ],
              ),
            );

            return Column(
              children: [
                Image.network(
                  "${API_URL}${controller.info['image'].toString().replaceAll('uploads', '')}",
                  height: 200,
                  width: double.infinity,
                ),
                Text("Brand: ${controller.info['brand']}"),
                Text("Model ${controller.info['model']}"),
                Text("Color: ${controller.info['color']}"),
                Text("Manufacture Year: ${controller.info['manufatureYear']}"),
                Text("Rate per Hour ${controller.info['ratePerHrs']}"),
                Text("Rate per Day : ${controller.info['ratePerDay']}"),
                Text(
                    "Last Service Date : ${controller.info['lastServiceDate']}"),
                Text("Is Verified : ${controller.info['approval']}"),
                TextButton(
                    onPressed: () {
                      Get.to(
                        () => ChatInfo(
                          controller.info['renterProfileId'],
                        ),
                      );
                    },
                    child: Text("Message")),
                TextButton(
                    onPressed: () {
                      Get.to(
                        () => BookVehicle(
                          controller.info['id'],
                        ),
                      );
                    },
                    child: Text("Book")),
              ],
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.edit,
      //   ),
      //   onPressed: () {
      //     Get.to(() => VehichleInfoScren(controller.info['id']));
      //   },
      // ),
      bottomNavigationBar: GetBuilder<PendingInfoController>(
          init: controller,
          builder: (controller) {
            return Container(
              margin: EdgeInsets.all(10),
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.info['orderConfirm'] == true
                        ? Colors.green
                        : Colors.orange),
                onPressed: controller.info['orderConfirm'] == true
                    ? () {}
                    : () {
                        print(controller.info['orderConfirm']);
                        controller.confirmOrder();
                        return;
                        // showAboutDialog(context: context)
                      },
                child: Text(
                  controller.info['orderConfirm'] == true
                      ? "Order Confirmed"
                      : 'Confirm Request',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
    );
  }
}
