import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class VehicleInfoController extends GetxController {
  bool isLoading = true;
  final int id;
  Map info = {};
  VehicleInfoController(this.id);
  List reviews = [];
  @override
  void onInit() {
    getInfo();
    super.onInit();
  }

  void getInfo() async {
    isLoading = true;
    update();
    dataFetcher.setUrl("${API_URL}/api/get-single-vechicle/$id");
    try {
      var response = await dataFetcher.fetchGetData({
        "x-access-token": loginController.token ??
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc3ODAyMDQ5LCJleHAiOjE2Nzc4ODg0NDl9.AUeyyts1gXj6iCH_v5bQdkIta9wOCY6Za1GEUB_GXcQ",
      });
      info = response['data'];
      reviews = response['data']['ratings'];
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;

      update();
    }
  }
}
