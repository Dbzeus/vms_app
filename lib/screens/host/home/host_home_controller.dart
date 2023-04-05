import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:vms_app/apis/api_call.dart';
import 'package:vms_app/helper/constants.dart';
import 'package:vms_app/helper/utils.dart';
import 'package:vms_app/model/host_dashboard_response.dart';
import 'package:vms_app/model/host_visitor_response.dart';
import 'package:vms_app/routes/app_routes.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vms_app/widget/button.dart';

class HostHomeController extends GetxController {
  final noController = TextEditingController();
  RxString dates = "".obs;
  final _box = GetStorage();
  DateTimeRange? dateRange;

  int userId = -1;
  int companyId = -1;
  int groupId = -1;
  RxBool isLoading = false.obs;
  RxBool isVisitorLoading = false.obs;
  RxBool isDashboardLoading = false.obs;
  RxString name = ''.obs;
  RxString logo = ''.obs;

  String fromDate = '';
  String toDate = '';

  RxList<HostVisitor> visitorList = RxList();
  RxList<HostDashboard> dashboardList = RxList();

  //location
  RxString location = ''.obs;
  RxList<Map<String, String>> locationList = RxList();

  var sendFormat = DateFormat('MM/dd/yyyy');
  var showFormat = DateFormat('dd MMM yyyy');

  @override
  void onInit() {
    super.onInit();
    userId = _box.read(USER_ID) ?? -1;
    companyId = _box.read(CLIENT_ID) ?? -1;
    groupId = _box.read(GROUP_ID) ?? -1;
    name(_box.read(FIRST_NAME) ?? "");
    logo(_box.read(CLIENT_LOGO) ?? "");

    fromDate = sendFormat.format(DateTime.now());
    toDate = sendFormat.format(DateTime.now());
    dates(
        '${showFormat.format(sendFormat.parse(fromDate))} - ${showFormat.format(
            sendFormat.parse(toDate))}');

    getLocationList();
    checkAppVersion();
  }

  getLocationList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getLocations('$companyId');
      if (response != null) {
        locationList.clear();
        if (response['RtnStatus']) {
          for (var r in response['RtnData']) {
            locationList.add({
              'id': '${r['LocationID']}',
              'value': '${r['LocationName']}',
            });
          }

          //check session
          if (_box.read(SELECTED_LOCATION) == null && locationList.isNotEmpty) {
            _box.write(SELECTED_LOCATION, locationList.first['id']);
          }
          location(_box.read(SELECTED_LOCATION) ?? '');
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      isLoading(false);
      getDashboard();
    }
  }

  changeLocation(String? val) {
    if (val != null) {
      location(val);
    }
  }

  getDashboard() async {
    if (await isNetConnected()) {
      isDashboardLoading(true);
      var response = await ApiCall()
          .getHostDashboard('$groupId', '0', '$userId', fromDate, toDate);
      if (response != null) {
        dashboardList.clear();
        if (response.rtnStatus) {
          dashboardList(response.rtnData);
        } else {
          showSnackbar(null, response.rtnMessage);
        }
      }
      isDashboardLoading(false);
      getVisitorList();
    }
  }

  getVisitorList() async {
    if (await isNetConnected()) {
      isVisitorLoading(true);
      var response = await ApiCall()
          .getHostVisitorList(
          '$groupId', '0', '$userId', fromDate, toDate, '0');
      if (response != null) {
        visitorList.clear();
        if (response.rtnStatus) {
          visitorList(response.rtnData);
        } else {
          showSnackbar(null, response.rtnMessage);
        }
      }
      isVisitorLoading(false);
    }
  }

  selectDates() async {
    dateRange = await showDateRangePicker(
        context: Get.context!,
        initialDateRange: dateRange,
        firstDate: DateTime(2021),
        lastDate: DateTime.now());

    if (dateRange == null) return;

    fromDate = sendFormat.format(dateRange!.start);
    toDate = sendFormat.format(dateRange!.end);

    dates(
        '${showFormat.format(sendFormat.parse(fromDate))} - ${showFormat.format(
            sendFormat.parse(toDate))}');

    getDashboard();
  }

  logout() {
    isLoading(true);
    if (_box.read(IS_REMEMBER_ME)) {
      String uname = _box.read(USER_NAME);
      String password = _box.read(PASSWORD);
      _box.erase();
      _box.write(USER_NAME, uname);
      _box.write(PASSWORD, password);
    } else {
      _box.erase();
    }
    isLoading(false);
    Get.offAllNamed(Routes.LOGIN);
  }

  checkAppVersion() async {
    if (await isNetConnected()) {
      try {
        var response = await ApiCall().getAppVersion();
        if (response != null && response['vms'] != null) {
          var result = response['vms'];
          int currentVersionCode =
          int.parse((await PackageInfo.fromPlatform()).buildNumber);
          int versionCode = result['versionCode'];
          bool forceUpdate = result['forceUpdate'];
          if (versionCode > currentVersionCode) {
            Get.bottomSheet(
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        '${result['title']}',
                        style:
                        const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const Divider(),
                      Text(
                          '${result['message']}'),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomButton(
                        buttonText: 'Update',
                        onPressed: () {
                          if (Platform.isAndroid) {
                            launchUrlString(
                                '${result['androidUrl']}',
                                mode: LaunchMode.externalApplication);
                          } else {
                            launchUrlString(
                                '${result['iosUrl']}',
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        width: 100,
                        height: 32,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.transparent,
                enableDrag: !forceUpdate,
                isDismissible: !forceUpdate);
          }
        }
      } catch (e) {
        //ignored
      }
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
        }
      }
      isVisitorLoading(false);
    }
  }
}
