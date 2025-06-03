import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart' as DioForm;
import 'package:dio/src/multipart_file.dart' as DioMultipart;
import 'package:intl/intl.dart';

import 'package:http_parser/http_parser.dart' as http;
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

// import 'package:sadan/services/data_fetcher.dart';
// import 'package:http/http.dart' as http;

class AddVehicleController extends getx.GetxController {
  late TextEditingController brandController;
  late TextEditingController modelController;
  late TextEditingController colorController;
  late TextEditingController manufactureyear;
  late TextEditingController ratePerHourController;
  late TextEditingController ratePerDayController;
  late TextEditingController lastServiceDateController;
  bool isLoadingCategories = true;
  List categories = [];
  List<String> categoriesName = [];
  int? SelectedCategoryid;
  String? selectedCategoryName;
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
    GetCategories();
    super.onInit();
  }

  String? validateEmptyField(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return "cannot leave empty";
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));

    lastServiceDateController.text = DateFormat.yMd().format(picked!);
  }

  void GetCategories() async {
    isLoadingCategories = true;
    update();
    try {
      dataFetcher.setUrl("$API_URL/api/all-category");
      var response = await dataFetcher
          .fetchGetData({"x-access-token": loginController.token!});
      categories = response['data'];
      for (var data in categories) {
        categoriesName.add(data['name']);
      }
      selectedCategoryName = categories.first['name'];
      SelectedCategoryid = categories.first['id'] as int;
    } catch (e) {
    } finally {
      isLoadingCategories = false;
      update();
    }
  }

  void addVehicle() async {
    log(vehicleImage?.path ?? "hello no");
    log(loginController.token ?? "hello no");
    if (!formKey.currentState!.validate()) return;
    // DataFetcher _dataFetcher = DataFetcher();
    // _dataFetcher.setUrl("${API_URL}/api/add-renter-vehicle");

    Dio dio = new Dio();
    dio.options.headers["x-access-token"] = loginController.token ??
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ";

    Map<String, dynamic> data = {
      'image': await DioMultipart.MultipartFile.fromFile(
        vehicleImage!.path,
        filename: vehicleImage!.path.split('/').last,
        contentType: http.MediaType("image", "jpg"),
      ),
      'brand': brandController.text,
      "model": modelController.text,
      "color": colorController.text,
      "manufatureYear": manufactureyear.text,
      "ratePerHrs": ratePerHourController.text,
      "ratePerDay": ratePerDayController.text,
      "lastServiceDate": lastServiceDateController.text,
      "categoryId": SelectedCategoryid
      // "type": "image/jpg",
    };
    FormData formData = FormData.fromMap(data);
    try {
      Response response =
          await dio.post('${API_URL}/api/add-renter-vehicle', data: formData);
      print(response);
      if (response.data['message'] == "Success") {
        getx.Get.rawSnackbar(
            message: "success", title: "SUccessfully added vehicle");
        return;
      }
      getx.Get.rawSnackbar(
          title: "Error",
          message: "Failed to add Vechice. Make sure to add KYC profile first");
    } catch (e) {
      print(e);
      getx.Get.rawSnackbar(
          title: "Error",
          message: "Failed to add Vechice. Make sure to add KYC profile first");
    } finally {}

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
