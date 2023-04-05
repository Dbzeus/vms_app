import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vms_app/apis/api_call.dart';
import 'package:vms_app/helper/constants.dart';
import 'package:vms_app/helper/utils.dart';
import 'package:vms_app/model/visitor_response.dart';

class GateVisitorListController extends GetxController {
  RxList<Visitor> visitorList = Get.arguments;
  List<Visitor> templist = Get.arguments.value;

  final _box = GetStorage();
  RxBool isLoading = false.obs;
  RxBool isVisitorLoading = false.obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
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
      String search = searchController.text.trim().toLowerCase();
      // print(search);
      if (search.isNotEmpty && templist.isNotEmpty) {
        //filter list
        visitorList(templist
            .where((element) =>
                element.visitorName.toLowerCase().contains(search) ||
                element.visitorPhoneNo.toLowerCase().contains(search) ||
                element.visitorPassNo.toLowerCase().contains(search))
            .toList());
      } else {
        visitorList(templist);
      }
    });
  }

  getVisitorList() async {
    if (await isNetConnected()) {
      isVisitorLoading(true);
      var response =
          await ApiCall().getVisitorList(_box.read(SELECTED_SYSTEM), '0');
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

  updateInTime(Visitor visitor) async {
    if (await isNetConnected()) {
      isLoading(true);
      var response =
          await ApiCall().visitorInTimeUpdate('${visitor.visitorID}');
      if (response != null) {
        if (response['RtnStatus']) {
          showSnackbar('Updated', response['RtnMessage']);
          getVisitorList();
        } else {
          showSnackbar('Failed', response['RtnMessage']);
        }
      }
      isLoading(false);
    }
  }

  updateOutTime(Visitor visitor) async {
    if (await isNetConnected()) {
      isLoading(true);
      var response =
          await ApiCall().visitorOutTimeUpdate('${visitor.visitorID}');
      if (response != null) {
        if (response['RtnStatus']) {
          showSnackbar('Updated', response['RtnMessage']);
          getVisitorList();
        } else {
          showSnackbar('Failed', response['RtnMessage']);
        }
      }
      isLoading(false);
    }
  }
}
