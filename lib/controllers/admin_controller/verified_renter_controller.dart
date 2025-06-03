import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/main.dart';

class VerifiedRenterController extends GetxController {
  List pendingRenterRequest = [];

  @override
  void onInit() {
    getPendingREnterequest();
    super.onInit();
  }

  getPendingREnterequest() async {
    isLoading = true;
    update();
    try {
      dataFetcher.setUrl("${API_URL}/api/admin-renter");
      var response = await dataFetcher
          .fetchGetData({"x-access-token": "${loginController.token}"});
      print(response);
      pendingRenterRequest = response['data'];
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  bool isLoading = true;
}
