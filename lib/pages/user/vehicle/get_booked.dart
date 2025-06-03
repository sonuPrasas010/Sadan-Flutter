import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class GetUserBookedVehicle extends StatefulWidget {
  const GetUserBookedVehicle({super.key});

  @override
  State<GetUserBookedVehicle> createState() => _GetUserBookedVehicleState();
}

class _GetUserBookedVehicleState extends State<GetUserBookedVehicle> {
  bool isLoadng = true;
  List bookedVehicles = [];
  @override
  void initState() {
    getBookedVehicle();
    super.initState();
  }

  void getBookedVehicle() async {
    isLoadng = true;
    setState(() {});
    try {
      dataFetcher.setUrl("${API_URL}/api/my-booking");
      var resonse = await dataFetcher.fetchGetData({
        "x-access-token": loginController.token ??
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ"
      });
      print(resonse);
      bookedVehicles = resonse['data'];
    } catch (e) {
      print(e);
    } finally {
      isLoadng = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadng
          ? Center(
              child: CircularProgressIndicator(),
            )
          : bookedVehicles.isEmpty
              ? Center(
                  child: ElevatedButton(
                    child: Text("Resresh"),
                    onPressed: () {
                      getBookedVehicle();
                    },
                  ),
                )
              : ListView.builder(
                  itemCount: bookedVehicles.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Text("id: ${bookedVehicles[index]['id']}"),
                        Text("Date: ${bookedVehicles[index]['date']}"),
                        Text("time: ${bookedVehicles[index]['time']}"),
                        Text("note: ${bookedVehicles[index]['note']}"),
                        Text(
                            "orderConfirm: ${bookedVehicles[index]['orderConfirm']}"),
                        Text(
                            "Date: ${bookedVehicles[index]['vechicle']['model']}"),
                        Text(
                            "Date: ${bookedVehicles[index]['vechicle']['manufatureYear']}"),
                      ],
                    );
                  }),
    );
  }
}
