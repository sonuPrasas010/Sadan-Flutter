import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';


import '../../../components/vechicle_info_widget.dart';
import '../../configs/api.dart';
import '../../controllers/renter_controler/vehicle_info_controller.dart';
import '../renter/chat/chat_info.dart';
import 'vehicle/book_vehicle.dart';

class SingleVehicleBokingInfo extends StatelessWidget {
  late VehicleInfoController controller;
  SingleVehicleBokingInfo(int id) {
    controller = Get.put(VehicleInfoController(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                            Center(
                              child: RatingBar.builder(
                                itemBuilder: (_, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (index) {},
                                initialRating: 5,
                                itemSize: 15,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                print(
                                    controller.info['renterProfile']['userId']);
                                Get.to(() => ChatInfo(controller
                                    .info['renterProfile']['userId']));
                              },
                              icon: Icon(
                                Icons.message,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        VehicleDetailWidget(
                            Icons.calendar_month,
                            '${controller.info['model']}',
                            '${controller.info['manufatureYear']}'),
                        VehicleDetailWidget(Icons.home_outlined, 'Address',
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
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          onPressed: () {
            Get.to(() => BookVehicle(controller.id));
            return;
            // showAboutDialog(context: context)
            Get.dialog(
              AlertDialog(
                content: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Booking Request Confirmation',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('Are you sure you want to book ?'),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Time',
                          icon: Icon(Icons.lock_clock_rounded),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Message',
                          icon: Icon(Icons.message),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {}, child: Text('Submit')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          child: Text(
            'Send Request',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
