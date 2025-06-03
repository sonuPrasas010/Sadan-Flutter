import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart' as DioForm;
import 'package:dio/src/multipart_file.dart' as DioMultipart;
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

// import 'package:sadan/services/data_fetcher.dart';
// import 'package:http/http.dart' as http;

class EditVehicleController extends getx.GetxController {
  late TextEditingController brandController;
  late TextEditingController modelController;
  late TextEditingController colorController;
  late TextEditingController manufactureyear;
  late TextEditingController ratePerHourController;
  late TextEditingController ratePerDayController;
  late TextEditingController lastServiceDateController;

  final formKey = GlobalKey<FormState>();

  XFile? vehicleImage;

  @override
  void onInit() {
    brandController = TextEditingController();
    modelController = TextEditingController();
    colorController = TextEditingController();
    manufactureyear = TextEditingController();
    ratePerDayController = TextEditingController();
    ratePerHourController = TextEditingController();
    lastServiceDateController = TextEditingController();
    super.onInit();
  }

  String? validateEmptyField(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return "cannot leave empty";
  }

  void addVehicle() async {
    log(vehicleImage?.path ?? "hello no");
    log(loginController.token ?? "hello no");
    if (!formKey.currentState!.validate()) return;
    // DataFetcher _dataFetcher = DataFetcher();
    // _dataFetcher.setUrl("${API_URL}/api/add-renter-vehicle");

    Dio dio = new Dio();
    dio.options.headers["x-access-token"] = "${loginController.token}";
    DioForm.FormData formData = new DioForm.FormData.fromMap({
      'image': await DioMultipart.MultipartFile.fromFile(
        vehicleImage!.path,
      ),
    });
    Response response = await dio
        .post('${API_URL}/api/update-renter-vehicle', data: formData)
        .then((value) async {
      return value;
    });
    print(response);
    print(response);

    /*

    var postUri = Uri.parse("${API_URL}/api/add-renter-vehicle");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['brand'] = brandController.text;
    request.fields['model'] = modelController.text;
    request.fields['color'] = colorController.text;
    request.fields['manufatureYear'] = manufactureyear.text;
    request.fields['ratePerHrs'] = ratePerHourController.text;
    request.fields['ratePerDay'] = ratePerDayController.text;
    request.fields['lastServiceDate'] = lastServiceDateController.text;
    request.files.add(new http.MultipartFile.fromBytes(
      'image',
      await File.fromUri(Uri.parse(vehicleImage!.path.toString()))
          .readAsBytes(),
    ));

    request.send().then((response) {
      print(response.statusCode);

      if (response.statusCode == 200) print("Uploaded!");
    });*/
  }
}
