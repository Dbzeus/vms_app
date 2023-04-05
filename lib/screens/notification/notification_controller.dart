import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../apis/api_call.dart';
import '../../helper/constants.dart';
import '../../helper/utils.dart';

class NotificationController extends GetxController {
  RxBool isLoading = true.obs;
  int userid = -1;
  final _box = GetStorage();
  RxList list = RxList();

  @override
  void onInit() async {
    super.onInit();
    userid = _box.read(USER_ID) ?? -1;
    notification();
  }

  notification() async {
    isLoading(true);

    var response = await ApiCall().getNotification(userid);
    if (response != null) {
      if (response["RtnStatus"]) {
        list(response['RtnData']);
      } else {
        showSnackbar("Response", response.rtnMessage);
      }
    }

    isLoading(false);
  }
}
