import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';

import 'package:http_parser/http_parser.dart' as http;
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class CategoryCOntroller extends getx.GetxController {
  bool isAdding = false;
  bool isLoading = true;
  TextEditingController nameController = TextEditingController();
  XFile? image;
  ImagePicker imagePicker = new ImagePicker();
  List categories = [];

  void pickImage() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    update();
  }

  @override
  void onInit() {
    GetCategories();
    super.onInit();
  }

  void GetCategories() async {
    isLoading = true;
    update();
    try {
      dataFetcher.setUrl("$API_URL/api/all-category");
      var response = await dataFetcher
          .fetchGetData({"x-access-token": loginController.token!});
      categories = response['data'];
    } catch (e) {
    } finally {
      isLoading = false;
      update();
    }
  }

  void AddCategory() async {
    Dio dio = Dio();
    dio.options.headers['x-access-token'] = loginController.token;
    Map<String, dynamic> data = {
      "name": nameController.text,
      "image": await MultipartFile.fromFile(image!.path,
          filename: image!.path.split("/").last,
          contentType: http.MediaType("image", "jpg"))
    };
    FormData formData = FormData.fromMap(data);

    try {
      Response response =
          await dio.post('${API_URL}/api/add-catgeory', data: formData);
      print(response);
      if (response.data['message'] == "Success") {
        getx.Get.rawSnackbar(
            message: "success", title: "SUccessfully added Category");
        return;
      }
      getx.Get.rawSnackbar(title: "Error", message: "Failed to add category. ");
    } catch (e) {
      print(e);
      getx.Get.rawSnackbar(title: "Error", message: "Failed to add Vechice. ");
    } finally {}
  }

  void deleteCategory({required int id, required int index}) async {
    try {
      dataFetcher.setUrl("$API_URL/api/delete-category/$id");
      var response = await dataFetcher
          .fetchGetData({"x-access-token": loginController.token!});

      if (response['message'] == "Success") {
        categories.removeAt(index);
        getx.Get.rawSnackbar(
            title: "Success", message: "Category deleted successfully");
        categories.removeAt(index);
        return;
      }
      getx.Get.rawSnackbar(
          title: "Error", message: "Category deleted Unsuccessfully");
      return;
    } catch (e) {
      getx.Get.rawSnackbar(
          title: "Error", message: "Category deleted Unsuccessfully");
    } finally {
      update();
    }
  }
}
