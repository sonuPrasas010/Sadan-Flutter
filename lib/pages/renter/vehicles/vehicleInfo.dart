import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sadan/components/vechicle_info_widget.dart';
import 'package:sadan/configs/api.dart';

import 'package:sadan/controllers/renter_controler/vehicle_info_controller.dart';

class RenterVehichleInfoScren extends StatelessWidget {
  late VehicleInfoController controller;
  RenterVehichleInfoScren(int id) {
    controller = Get.put(VehicleInfoController(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.orange,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GetBuilder<VehicleInfoController>(
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
                      "${API_URL}${controller.info['image'].toString().replaceAll('uploads', '')}"),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${controller.info['brand']}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < 5; i++)
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                          ],
                        ),
                        Divider(),
                        VehicleDetailWidget(
                            Icons.calendar_month,
                            '${controller.info['model']}',
                            '${controller.info['manufatureYear']}'),
                        VehicleDetailWidget(Icons.home_outlined, 'Bike Address',
                            'Itahari-8, sunsari'),
                        VehicleDetailWidget(
                            Icons.work, 'Open Time', '8 AM - 8 PM'),
                        VehicleDetailWidget(Icons.verified, 'Verified Status',
                            '${controller.info['approval']}'),
                        VehicleDetailWidget(
                            Icons.home_repair_service_sharp,
                            'Last Service Date',
                            '${controller.info['lastServiceDate']}'),
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
    );
  }
}
