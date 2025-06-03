import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart' as http;
import 'package:sadan/configs/api.dart';
import 'package:sadan/configs/strings.dart';
import 'package:sadan/main.dart';

class KYCController extends getx.GetxController {
  String selectedGender = genders[0];
  String selectedDocType = docType[0];

  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController dOBController;
  late TextEditingController addressController;
  late TextEditingController identificationNumberController;
  late TextEditingController liscnceNumberController;
  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();
  final ImagePicker _picker1 = ImagePicker();
  List<XFile?> citizenshipFront = [];
  XFile? citizenshipBack;
  XFile? liscensePhoto;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    dOBController = TextEditingController();
    addressController = TextEditingController();
    identificationNumberController = TextEditingController();
    liscnceNumberController = TextEditingController();
    super.onInit();
  }

  String? validateEmptyField(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return "cannot leave empty";
  }

  void onGanderChanged(String? gender) {
    selectedGender = gender!;
    update();
  }

  void onDocChanged(String? doc) {
    selectedGender = doc!;
    update();
  }

  void pickCitizenship() async {
    citizenshipFront = await _picker.pickMultiImage();
    update();
  }

  // void pickCitizenshipBack() async {
  //   citizenshipBack = await _picker1.pickImage(source: ImageSource.gallery);
  //   update();
  // }

  // void pickLicense() async {
  //   liscensePhoto = await _picker.pickImage(source: ImageSource.gallery);
  //   update();
  // }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));

    dOBController.text = DateFormat.yMd().format(picked!);
  }

  void submitKYC() async {
    if (!formKey.currentState!.validate()) return;
    if (citizenshipFront.length < 2) {
      getx.Get.rawSnackbar(
          title: "Document Missing",
          message: "Please Pick Both Front and Back of citizenship");
      return;
    }
    isLoading = true;
    update();
    Dio dio = new Dio();
    dio.options.headers["x-access-token"] = loginController.token ??
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ";
    dio.options.headers['Content-Type'] = "multipart/form-data";
    Map<String, dynamic> data = {
      "citizenship": [
        await MultipartFile.fromFile(
          citizenshipFront[0]!.path,
          filename: citizenshipFront[0]!.path.split('/').last,
          contentType: http.MediaType("image", "jpg"),
        ),
        await MultipartFile.fromFile(
          citizenshipFront[1]!.path,
          filename: citizenshipFront[1]!.path.split('/').last,
          contentType: http.MediaType("image", "jpg"),
        ),
      ],
      "type": "image/jpg",
      "name": nameController.text,
      "document": "document",
      "phone": phoneNumberController.text,
      "dob": dOBController.text,
      "address": addressController.text,
      "gender": selectedGender,
      "idNumber": identificationNumberController.text,
    };
    FormData formData = new FormData.fromMap(
      data,
    );
    try {
      Response response = await dio.post(
        '${API_URL}/api/renter-add-profile',
        data: formData,
      );
      getx.Get.rawSnackbar(
        title: "Success",
        message: "Successfully submited kyc",
        backgroundColor: Colors.green,
      );

      // getx.Get.back();
    } on DioError catch (_) {
      getx.Get.rawSnackbar(
        title: "Error",
        message: "Fauled to  submited kyc",
        backgroundColor: Colors.red,
      );

      print(_.message);
    } finally {
      isLoading = false;
      update();
    }
  }
}
