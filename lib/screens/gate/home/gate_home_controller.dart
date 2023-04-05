import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:vms_app/apis/api_call.dart';
import 'package:vms_app/helper/constants.dart';
import 'package:vms_app/helper/utils.dart';
import 'package:vms_app/model/visitor_response.dart';
import 'package:vms_app/routes/app_routes.dart';
import 'package:vms_app/widget/button.dart';
import 'package:vms_app/widget/spinner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GateHomeController extends GetxController {
  final noController = TextEditingController();
  final _box = GetStorage();
  int userId = -1;
  RxBool isLoading = false.obs;
  RxBool isVisitorLoading = false.obs;
  RxString name = ''.obs;
  RxString logo = ''.obs;

  //company
  RxString company = "".obs;
  RxList<Map<String, String>> companyList = RxList();

  //location
  RxString location = "".obs;
  RxList<Map<String, String>> locationList = RxList();

  //gate
  RxString gate = "".obs;
  RxList<Map<String, String>> gateList = RxList();

  //system
  RxString system = "".obs;
  RxList<Map<String, String>> systemList = RxList();

  RxList<Visitor> visitorList = RxList();

  @override
  void onInit() {
    super.onInit();
    userId = _box.read(USER_ID) ?? -1;
    name(_box.read(FIRST_NAME) ?? "");

    getCompanyList();
    checkAppVersion();
  }

  changeCompany(String? val) {
    if (val != null) {
      company(val);
      _box.write(SELECTED_CLIENT, jsonEncode(val));
      _box.write(CLIENT_GROUP_ID, getMapItem(companyList.value, val)['group']);
      logo('${getMapItem(companyList.value, val)['logo']}');
      getLocationList();
      gateList.clear();
    }
  }

  changeLocation(String? val) {
    if (val != null) {
      location(val);
      getGateList();
    }
  }

  changeGate(String? val) {
    if (val != null) {
      gate(val);
      getSystemList();
    }
  }

  changeSystem(String? val) {
    if (val != null) {
      system(val);
      getVisitorList();
    }
  }

  getCompanyList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getClients('$userId');
      if (response != null) {
        companyList.clear();
        if (response['RtnStatus']) {
          for (var r in response['RtnData']) {
            companyList.add({
              'id': '${r['ClientID']}',
              'value': '${r['ClientName']}',
              'group': '${r['ClientGroupID']}',
              'logo': '${r['LogoPath']}',
            });
          }

          //check session
          if ((_box.read(SELECTED_CLIENT) == null ||
                  _box.read(CLIENT_GROUP_ID) == null) &&
              companyList.isNotEmpty) {
            _box.write(SELECTED_CLIENT, companyList.first['id']);
            _box.write(CLIENT_GROUP_ID, companyList.first['group']);
          }
          company(_box.read(SELECTED_CLIENT) ?? '');
          logo('${getMapItem(companyList.value, company.value)['logo']}');
          getLocationList();
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      isLoading(false);
    }
  }

  getLocationList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getLocations(company.value);
      if (response != null) {
        locationList.clear();
        _box.remove(SELECTED_LOCATION);
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
          if (locationList.isNotEmpty) getGateList();
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      isLoading(false);
    }
  }

  getGateList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response =
          await ApiCall().getGateLit('0', company.value, location.value, '0');
      if (response != null) {
        gateList.clear();
        _box.remove(SELECTED_GATE);
        if (response['RtnStatus']) {
          for (var r in response['RtnData']) {
            gateList.add({
              'id': '${r['GateID']}',
              'value': '${r['GateName']}',
            });
          }

          //check session
          if (_box.read(SELECTED_GATE) == null && gateList.isNotEmpty) {
            _box.write(SELECTED_GATE, gateList.first['id']);
          }
          gate(_box.read(SELECTED_GATE) ?? '');
          if (gateList.isNotEmpty) getSystemList();
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      isLoading(false);
    }
  }

  getSystemList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall()
          .getSystemList(company.value, location.value, gate.value, '0');
      if (response != null) {
        systemList.clear();
        _box.remove(SELECTED_SYSTEM);
        if (response['RtnStatus']) {
          for (var r in response['RtnData']) {
            systemList.add({
              'id': '${r['SystemID']}',
              'value': '${r['SystemName']}',
            });
          }

          //check session
          if (_box.read(SELECTED_SYSTEM) == null && systemList.isNotEmpty) {
            _box.write(SELECTED_SYSTEM, systemList.first['id']);
          }
          system(_box.read(SELECTED_SYSTEM) ?? '');
          if (systemList.isNotEmpty) getVisitorList();
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      isLoading(false);
    }
  }

  getVisitorList() async {
    if (await isNetConnected()) {
      isVisitorLoading(true);
      var response = await ApiCall().getVisitorList(system.value, '0');
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

  submitMobileNo() async {
    int size = noController.text.length;
    if (size <= 0) {
      showSnackbar('Invalid', 'Enter OTP / Mobile Number / Pass No');
      return;
    }

    if (!noController.text.toLowerCase().startsWith("vp")) {
      if (size < 6) {
        showSnackbar('Invalid', 'Enter Correct OTP Value');
        return;
      } else if (size > 6 && size < 10) {
        showSnackbar('Invalid', 'Enter Correct Mobile Number');
        return;
      }
    }

    Get.focusScope?.unfocus();
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getVisitor(
        size == 6 ? noController.text : '0',
        size == 10 ? noController.text : '0',
        company.value,
        // noController.text.toLowerCase().startsWith("vp") ? noController.text : "",
      );
      if (response != null) {
        if (size == 6 && !response.rtnStatus) {
          showSnackbar('Not Found', response.rtnMessage);
        } else {
          Get.toNamed(Routes.GATE_APPOINTMENT, arguments: {
            'isOtp': size == 6,
            'mobile': size != 6 ? noController.text : '',
            'visitor': response.rtnData,
          });
        }
      }
      isLoading(false);
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

  qrscan() async {
    var result = await Get.toNamed(Routes.QR_SCAN);
    debugPrint('result $result');
    if (result != null) {
      try {
        updateOutTime(Visitor(int.parse(result)));
      } catch (e) {
        showSnackbar('Invalid', 'Invalid Visitor Pass Id');
      }
    }
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
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const Divider(),
                      Text('${result['message']}'),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomButton(
                        buttonText: 'Update',
                        onPressed: () {
                          if (Platform.isAndroid) {
                            launchUrlString('${result['androidUrl']}',
                                mode: LaunchMode.externalApplication);
                          } else {
                            launchUrlString('${result['iosUrl']}',
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
}
