import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vms_app/apis/api_call.dart';
import 'package:vms_app/helper/constants.dart';
import 'package:vms_app/helper/utils.dart';
import 'package:vms_app/model/host_visitor_response.dart';

class HostVisitorListController extends GetxController {
  RxList<HostVisitor> visitorList = Get.arguments['visitors'];
  List<HostVisitor> templist = Get.arguments['visitors'].value;
  final _box = GetStorage();
  int userId = -1;

  RxBool isLoading = false.obs;
  RxBool isVisitorLoading = false.obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    userId = _box.read(USER_ID) ?? -1;
  }

  @override
  void dispose() {
    Get.focusScope?.unfocus();
    searchController.clear();
    visitorList(templist);
    super.dispose();
  }

  @override
  void onReady() {
    searchController.addListener(() {
      String search = searchController.text.toLowerCase();
      // print(search);
      if (search.isNotEmpty && templist.isNotEmpty) {
        //filter list
        visitorList(templist
            .where((element) =>
                element.visitorName.toLowerCase().contains(search) ||
                element.visitorPhoneNo.toLowerCase().contains(search))
            .toList());
      } else {
        visitorList(templist);
      }
    });
  }

  getVisitorList() async {
    if (await isNetConnected()) {
      isVisitorLoading(true);
      var response = await ApiCall().getHostVisitorList(
          Get.arguments['groupId'],
          '0',
          Get.arguments['userId'],
          Get.arguments['fromDate'],
          Get.arguments['toDate'],
          '0');
      if (response != null) {
        visitorList.clear();
        templist.clear();
        if (response.rtnStatus) {
          visitorList(response.rtnData);
          templist = response.rtnData;
        } else {
          showSnackbar(null, response.rtnMessage);
        }
      }
      isVisitorLoading(false);
    }
  }

  onActionClick(int id, int visitorId, int index) async {
    if (await isNetConnected()) {
      isVisitorLoading(true);
      var response = await ApiCall().sendActionCall(userId, id, visitorId);
      if (response != null) {
        showSnackbar('Updated!', response['RtnMessage'] ?? '');
        if (response['RtnStatus']) {
          visitorList[index].visitingStatus = id;
          visitorList[index].visitingStatusName =
              id == 1 ? 'Approved' : 'Rejected';
          visitorList.refresh();

          templist[index].visitingStatus = id;
          templist[index].visitingStatusName =
              id == 1 ? 'Approved' : 'Rejected';
        }
      }
      isVisitorLoading(false);
    }
  }
}
