import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';
class PendingVehicleController extends GetxController {
  List pendingVehicleRequest = [];

  @override
  void onInit() {
    getPendingVechicleRequest();
    super.onInit();
  }

  getPendingVechicleRequest() async {
    isLoading = true;
    update();
    try {
      dataFetcher.setUrl("${API_URL}/api/admin-pending-vehicle");
      var response = await dataFetcher
          .fetchGetData({"x-access-token": "${loginController.token}"});
      print(response);
      pendingVehicleRequest = response['data'];
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  bool isLoading = true;
}
