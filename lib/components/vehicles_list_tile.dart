import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sadan/components/sizedBoxes/box.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/pages/user/vehicle/vehicle_info.dart';

class VehicleListTile extends StatelessWidget {
  final int vehicleId;
  final String image;
  final String brand;
  final String model;
  final String ratePerHour;
  final String ratePerDay;
  final String lastServiceDae;
  final Function? onClick;

  VehicleListTile(
      {required this.brand,
      required this.vehicleId,
      required this.image,
      required this.lastServiceDae,
      required this.model,
      required this.ratePerDay,
      required this.ratePerHour,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onClick != null) {
          onClick!();
          return;
        }
        Get.to(() => userVehichleInfoScren(vehicleId));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "${API_URL}${image.toString().replaceAll("uploads", "")}",
              height: 150,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                brand,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              SizedBoxH5,
              Text(
                model,
                style: TextStyle(fontSize: 15),
              ),
              SizedBoxH5,
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 15,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBoxH15,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(
                      label: Text(
                    ratePerHour.toString() + "/hr",
                  )),
                  Chip(
                      label: Text(
                    ratePerDay + "/day",
                  )),
                  Chip(label: Text(lastServiceDae)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
