import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';

class VerifiableTemplate extends StatefulWidget {
  List<String> images;
  List<String> texts;
  Function? onVerify;
  String bandName;
  String model;
  String color;
  String manufactureYear;
  String ratePerHour;
  String RatePerday;
  String lastServiceDate;
  int? approval;
  Function? onCancel;

  VerifiableTemplate(
      {required this.images,
      required this.texts,
      this.onVerify,
      required this.RatePerday,
      required this.bandName,
      required this.color,
      required this.lastServiceDate,
      required this.manufactureYear,
      required this.model,
      required this.ratePerHour,
      this.approval,
      this.onCancel});

  @override
  State<VerifiableTemplate> createState() => _VerifiableTemplateState();
}

class _VerifiableTemplateState extends State<VerifiableTemplate> {
  late bool isVerifiable;

  @override
  void initState() {
    isVerifiable = widget.onVerify != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.images);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var image in widget.images)
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                bottom: 30,
              ),
              child: Image.network(
                '$API_URL/${image.replaceAll("uploads", "")}',
                height: 200,
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
                      child: Text("Brand"),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.bandName),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Model"),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.model),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Color"),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.color),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Rate Per Day"),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.RatePerday),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Rate Per Hour"),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.ratePerHour),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("ManuFacture Year"),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.manufactureYear),
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
              if (widget.onCancel != null)
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        isVerifiable = false;
                        widget.onCancel!();
                        Get.rawSnackbar(title: "Success", message: "Verified");
                        setState(() {});
                      },
                      child: Text("Cancel")),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
