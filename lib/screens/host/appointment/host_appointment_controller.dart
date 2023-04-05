import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:vms_app/apis/api_call.dart';
import 'package:vms_app/helper/constants.dart';
import 'package:vms_app/helper/utils.dart';
import 'package:vms_app/model/insert_appointment.dart';
import 'package:vms_app/widget/spinner.dart';

class HostAppointmentController extends GetxController {
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var vehicleController = TextEditingController();

  var visitorMobileController = TextEditingController();
  var visitorNameController = TextEditingController();
  var visitorCompanyNameController = TextEditingController();
  var visitorEmailController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString isApprover = 'false'.obs;
  final _box = GetStorage();

  int userId = -1;
  String groupId = '-1';

  //branch
  RxString branch = ''.obs;
  RxList<Map<String, String>> branchList = RxList();

  //location
  RxString location = ''.obs;
  RxList<Map<String, String>> locationList = RxList();

  //purpose
  RxString purpose = ''.obs;
  RxList<Map<String, String>> purposeList = RxList();

  //visitor type
  RxString visitorType = ''.obs;
  RxList<Map<String, String>> visitorTypeList = RxList();

  //approvers
  RxString app1 = '-1'.obs;
  RxList<Map<String, String>> app1List = RxList();

  RxString app2 = '-1'.obs;
  RxList<Map<String, String>> app2List = RxList();

  RxString app3 = '-1'.obs;
  RxList<Map<String, String>> app3List = RxList();

  RxList<VisitorDetailsDTO> visitors = RxList();

  DateTime appDateTime = DateTime.now();
  TimeOfDay appTime = TimeOfDay(hour: 0, minute: 0);

  @override
  void onInit() {
    super.onInit();
    userId = _box.read(USER_ID) ?? 75;
    groupId = _box.read(CLIENT_GROUP_ID) ?? '-1';

    getCompanyList();
  }

  getCompanyList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getClients('$userId');
      if (response != null) {
        branchList.clear();
        if (response['RtnStatus']) {
          for (var r in response['RtnData']) {
            branchList.add({
              'id': '${r['ClientID']}',
              'value': '${r['ClientName']}',
              'group': '${r['ClientGroupID']}',
            });
          }

          if (branchList.isNotEmpty) {
            branch(branchList.first['id']);
            groupId = branchList.first['group'].toString();
            getLocationList();
            getPurposeList();
            getVisitorType();
          }
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      isLoading(false);
    }
  }

  changeBranch(String? val) {
    if (val != null) {
      branch(val);
      groupId = getMapItem(branchList.value, val)['group'].toString();
      getLocationList();
      getPurposeList();
      getVisitorType();
    }
  }

  getLocationList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getLocations(branch.value);
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
          if (locationList.isNotEmpty) {
            location(locationList.first['id']);
          }
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      isLoading(false);
    }
  }

  changeLocation(String? val) {
    if (val != null) {
      location(val);
    }
  }

  getPurposeList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getPurpose(groupId, '0');
      if (response != null) {
        purposeList.clear();
        if (response['RtnStatus']) {
          for (var r in response['RtnData']) {
            purposeList.add({
              'id': '${r['PurposeofVisitID']}',
              'value': '${r['PurposeofVisitName']}',
            });
          }

          if (purposeList.isNotEmpty) {
            purpose('${purposeList.first['id']}');
          }
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      isLoading(false);
    }
  }

  changePurpose(String? val) {
    if (val != null) {
      purpose(val);
    }
  }

  getVisitorType() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getVisitorType(groupId, '0');
      if (response != null) {
        visitorTypeList.clear();
        if (response['RtnStatus']) {
          for (var r in response['RtnData']) {
            visitorTypeList.add({
              'id': '${r['VisitorTypeID']}',
              'value': '${r['VisitorTypeName']}',
              'isNeedApprove': '${r['IsApprovalNeed']}',
            });
          }

          log('vis\n' + visitorTypeList.toString());

          if (visitorTypeList.isNotEmpty) {
            visitorType('${visitorTypeList.first['id']}');
            isApprover(visitorTypeList.first['isNeedApprove']
                .toString()
                .toLowerCase());
            if (isApprover.value == "true") {
              //get approver list
              getApproverList();
            }
          }
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      isLoading(false);
    }
  }

  changeVisitorType(String? val) {
    print('$val');
    if (val != null) {
      visitorType(val);
      print('visi ${visitorTypeList.value}');
      print('${getMapItem(visitorTypeList.value, val)}');
      isApprover(getMapItem(visitorTypeList.value, val)['isNeedApprove']
          .toString()
          .toLowerCase());
      print('visit ${visitorType.value} isapp ${isApprover.value}');
      if (isApprover.value == "true") {
        getApproverList();
      }
    }
  }

  getApproverList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getApproverList(
          branch.value, location.value, '0', visitorType.value, '0');
      if (response != null) {
        app1List.clear();
        app2List.clear();
        app3List.clear();
        if (response.rtnStatus) {
          response.rtnData.removeWhere(
              (element) => element.visitorType.toString() != visitorType.value);

          //approval 1
          response.rtnData
              .where((element) => element.approvalOrder == 1)
              .forEach((element) {
            app1List.add({
              'id': '${element.approvalID}',
              'value': '${element.approvalName}',
            });
          });

          if (app1List.isNotEmpty) app1(app1List.first['id'].toString());

          //approval 2
          response.rtnData
              .where((element) => element.approvalOrder == 2)
              .forEach((element) {
            app2List.add({
              'id': '${element.approvalID}',
              'value': '${element.approvalName}',
            });
          });

          if (app2List.isNotEmpty) app2(app2List.first['id'].toString());

          //approval 3
          response.rtnData
              .where((element) => element.approvalOrder == 3)
              .forEach((element) {
            app3List.add({
              'id': '${element.approvalID}',
              'value': '${element.approvalName}',
            });
          });

          if (app3List.isNotEmpty) app3(app3List.first['id'].toString());
        } else {
          showSnackbar(null, response.rtnMessage);
        }
      }
      isLoading(false);
    }
  }

  //search visitor
  submitMobileNo() async {
    int size = visitorMobileController.text.length;
    if (size < 10) {
      showSnackbar('Invalid', 'Enter Correct Mobile Number');
    } else {
      Get.focusScope?.unfocus();
      if (await isNetConnected()) {
        isLoading(true);
        var response = await ApiCall()
            .getVisitor('0', visitorMobileController.text, branch.value);
        if (response != null) {
          if (size == 6 && !response.rtnStatus) {
            showSnackbar('Not Found', response.rtnMessage);
          } else {
            visitorNameController.text = response.rtnData?.visitorName ?? '';
            visitorCompanyNameController.text =
                response.rtnData?.visitorFrom ?? '';
            visitorEmailController.text =
                response.rtnData?.visitorEmailID ?? '';
          }
        }
        isLoading(false);
      }
    }
  }

  selectDateTime() async {
    Get.focusScope?.unfocus();
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: appDateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 60)));
    if (picked != null) {
      appDateTime = picked;

      final TimeOfDay? tpicked = await showTimePicker(
        context: Get.context!,
        initialTime: appTime,
      );
      if (tpicked != null) {
        appTime = tpicked;
      }
      dateController.text =
          '${DateFormat('dd/MM/yyyy').format(appDateTime)} ${tpicked.toString().substring(10, 15)}';
    }
  }

  addVisitor() {
    if (visitorMobileController.text.isEmpty ||
        visitorMobileController.text.length < 10) {
      showSnackbar('Invalid', 'Enter Correct Mobile Number');
    } else if (visitorNameController.text.isEmpty) {
      showSnackbar('Invalid', 'Enter Visitor Name');
    } else if (visitorCompanyNameController.text.isEmpty) {
      showSnackbar('Invalid', 'Enter Visitor From');
    } else {
      Get.focusScope?.unfocus();
      visitors.add(VisitorDetailsDTO(
          '',
          visitorMobileController.text,
          visitorNameController.text,
          visitorCompanyNameController.text,
          visitorEmailController.text,
          0));

      visitorMobileController.clear();
      visitorNameController.clear();
      visitorCompanyNameController.clear();
      visitorEmailController.clear();
    }
  }

  submit() async {
    if (titleController.text.isEmpty) {
      showSnackbar('Invalid', 'Enter Appointment Title');
    } else if (dateController.text.isEmpty) {
      showSnackbar('Invalid', 'Enter Appointment Date Time');
    } else if (visitors.isEmpty) {
      showSnackbar('Invalid', 'Add Visitors');
    } else {
      AppoinmentMasterDTO app = AppoinmentMasterDTO(
          0,
          int.parse(location.value),
          titleController.text,
          '${DateFormat('MM-dd-yyyy').format(appDateTime)} ${appTime.toString().substring(10, 15)}',
          int.parse(purpose.value),
          int.parse(visitorType.value),
          int.parse(app1.value),
          int.parse(app2.value),
          int.parse(app3.value),
          int.parse(groupId),
          int.parse(branch.value),
          0,
          true,
          userId);

      InsertAppointment appointment = InsertAppointment(app, visitors.value);

      if (await isNetConnected()) {
        isLoading(true);
        var response = await ApiCall().insertAppointment(appointment);
        if (response != null) {
          if (response['RtnStatus']) {
            Get.back();
            showSnackbar("Success", response['RtnMessage']);
          } else {
            showSnackbar(null, response['RtnMessage']);
          }
        }
        isLoading(false);
      }
    }
  }
}
