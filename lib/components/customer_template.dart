import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';

class VerifiableCusomerTemplate extends StatefulWidget {
  List<String> images;
  List<String> texts;
  Function? onVerify;
  Function? onCancel;
  String name;
  String phone;
  String dob;
  String address;
  String gender;
  String idNumber;
  // String bandName;
  // String model;
  // String color;
  // String manufactureYear;
  // String ratePerHour;
  // String RatePerday;
  // String lastServiceDate;

  VerifiableCusomerTemplate({
    required this.images,
    required this.texts,
    this.onVerify,
    this.onCancel,
    required this.address,
    required this.dob,
    required this.gender,
    required this.idNumber,
    required this.name,
    required this.phone,
  });

  @override
  State<VerifiableCusomerTemplate> createState() =>
      _VerifiableCusomerTemplateState();
}

class _VerifiableCusomerTemplateState extends State<VerifiableCusomerTemplate> {
  late bool isVerifiable;

  @override
  void initState() {
    isVerifiable = widget.onVerify != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.images);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var image in widget.images)
          Padding(
            padding: const EdgeInsets.only(right: 10.0, bottom: 30),
            child: Image.network(
              '$API_URL/${image.replaceAll("uploads", "")}',
              // height: 120,
              width: Get.width,
              fit: BoxFit.cover,
            ),
          ),
        Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Name"),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.name),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Phone"),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.phone),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Date of Birth"),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.dob),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Address"),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.address),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("gender"),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.gender),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("idNumber"),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.idNumber),
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (widget.onVerify != null)
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      isVerifiable = false;
                      widget.onVerify!();
                      Get.rawSnackbar(title: "Success", message: "Verified");
                      setState(() {});
                    },
                    child: Text("Verify")),
              ),
            SizedBox(
              width: 10,
            ),
            if (widget.onCancel != null)
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      widget.onCancel!();
                      Get.rawSnackbar(
                        title: "cancelled",
                        message: "cancelled",
                        backgroundColor: Colors.red,
                      );
                    },
                    child: Text("Cancel")),
              ),
          ],
        ),
      ],
    );
  }
}
