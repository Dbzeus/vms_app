import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:vms_app/apis/api_call.dart';
import 'package:vms_app/helper/constants.dart';
import 'package:vms_app/helper/utils.dart';
import 'package:vms_app/model/insert_visitor.dart';
import 'package:vms_app/model/search_visitor_response.dart';
import 'package:vms_app/routes/app_routes.dart';
import 'package:vms_app/widget/spinner.dart';

class GateAppointmentController extends GetxController {
  var today = '', time = '';

  SearchVisitor? visitor = Get.arguments['visitor'];
  final _box = GetStorage();
  Rx<bool> isOtp = Rx(Get.arguments['isOtp']);

  var nameController = TextEditingController();
  var companyController = TextEditingController();
  var mobileController = TextEditingController(text: Get.arguments['mobile']);
  var mailController = TextEditingController();
  var bloodController = TextEditingController();
  var tempController = TextEditingController();
  var proofNoController = TextEditingController();
  var vehicleController = TextEditingController();
  var passNoController = TextEditingController();
  RxString visitorImage = "".obs;
  RxBool isInfection = false.obs;
  RxBool isLoading = false.obs;
  int userId = -1;
  String clientId = '-1';
  String groupId = '-1';
  String warningMsg = "";
  String msg = "In this type of visitors need approval from the approver";
  RxBool isWalkin = false.obs;
  RxBool isOptionalVisible = false.obs;

  //idproof
  RxString proof = ''.obs;
  RxList<Map<String, String>> idProofList = RxList();

  //vehicle
  RxString vehicle = '-1'.obs;
  RxList<Map<String, String>> vehicleList = RxList();

  //purpose
  RxString purpose = ''.obs;
  RxList<Map<String, String>> purposeList = RxList();

  //visitor type
  RxString visitorType = ''.obs;
  RxList<Map<String, String>> visitorTypeList = RxList();

  //host
  RxString host = ''.obs;
  RxList<Map<String, String>> hostList = RxList();

  @override
  void onInit() {
    if (visitor != null) {
      nameController.text = visitor!.visitorName;
      companyController.text = visitor!.visitorFrom;
      mobileController.text = visitor!.visitorPhoneNo;
      mailController.text = visitor!.visitorEmailID;
      bloodController.text = visitor!.bloodGroup;
      proofNoController.text = visitor!.iDProofNo;
      vehicleController.text = visitor!.vehicleNo;
      passNoController.text = visitor!.visitorPassNo;
      visitorImage(visitor!.visitorPhoto.replaceAll(data64String, ''));

      if (!visitor!.isReturnPass) {
        showSnackbar("Warning", visitor!.returnMsg);
      }
      // warningMsg = visitor!.isReturnPass ? "" : visitor!.returnMsg;
    }
    userId = _box.read(USER_ID) ?? -1;
    clientId = _box.read(SELECTED_CLIENT) ?? '-1';
    groupId = _box.read(CLIENT_GROUP_ID) ?? '-1';
    today = DateFormat('MMM dd yyyy').format(DateTime.now());
    time = DateFormat('hh:mm a').format(DateTime.now());
    super.onInit();

    getVehicleProofList();
  }

  @override
  void onReady() {
    super.onReady();
    if (isWalkin.value) {
      showSnackbar("Warning", msg);
    }
  }

  getVehicleProofList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getProofAndVehicle();
      if (response != null) {
        vehicleList.clear();
        idProofList.clear();
        if (response['RtnStatus']) {
          idProofList.add({'id': '-1', 'value': 'Select ID Proof'});
          vehicleList.add({'id': '-1', 'value': 'Select Vehicle'});
          for (var r in response['RtnData']) {
            if (r['TypeID'] == 1) {
              idProofList.add({
                'id': '${r['DropdownID']}',
                'value': '${r['Dropdown']}',
              });
            } else if (r['TypeID'] == 2) {
              vehicleList.add({
                'id': '${r['DropdownID']}',
                'value': '${r['Dropdown']}',
              });
            }
          }

          if (visitor != null) {
            if (idProofList.length > 1 &&
                idProofList.any((element) =>
                    element['id'] == visitor!.iDProofTypeID.toString())) {
              proof('${visitor!.iDProofTypeID}');
            } else {
              if (idProofList.length > 1) {
                proof('${idProofList.first['id']}');
              }
            }
            if (visitor != null &&
                vehicleList.length > 1 &&
                vehicleList.any((element) =>
                    element['id'] == visitor!.vehicleTypeID.toString())) {
              vehicle('${visitor!.vehicleTypeID}');
            } else {
              if (vehicleList.length > 1) {
                vehicle('${vehicleList.first['id']}');
              }
            }
          } else {
            if (idProofList.length > 1) {
              proof('${idProofList.first['id']}');
            }
            if (vehicleList.length > 1) {
              vehicle('${vehicleList.first['id']}');
            }
          }
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      // isLoading(false);
      getPurposeList();
    }
  }

  getPurposeList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getPurpose(groupId, '0');
      if (response != null) {
        purposeList.clear();
        if (response['RtnStatus']) {
          purposeList.add({'id': '-1', 'value': 'Select Purpose Of Visit'});
          for (var r in response['RtnData']) {
            purposeList.add({
              'id': '${r['PurposeofVisitID']}',
              'value': '${r['PurposeofVisitName']}',
            });
          }

          if (visitor != null &&
              purposeList.length > 1 &&
              purposeList.any((element) =>
                  element['id'] == visitor!.purposeOfVisit.toString())) {
            purpose('${visitor!.purposeOfVisit}');
          } else if (purposeList.length > 1) {
            purpose('${purposeList[1]['id']}');
          }
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      // isLoading(false);
      if (isOtp.value) {
        getVisitorType();
      } else {
        getGateVisitorType();
      }
    }
  }

  getVisitorType() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getVisitorType(groupId, '0');
      if (response != null) {
        visitorTypeList.clear();
        if (response['RtnStatus']) {
          visitorTypeList.add({
            'id': '-1',
            'value': 'Select Visitor Type',
          });
          for (var r in response['RtnData']) {
            visitorTypeList.add({
              'id': '${r['VisitorTypeID']}',
              'value': '${r['VisitorTypeName']}',
            });
          }

          if (visitor != null &&
              visitorTypeList.length > 1 &&
              visitorTypeList.any((element) =>
                  element['id'] == visitor!.visitingType.toString())) {
            visitorType('${visitor!.visitingType}');
          } else if (visitorTypeList.length > 1) {
            visitorType('${visitorTypeList[1]['id']}');
          }
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      // isLoading(false);
      getHostList();
    }
  }

  getGateVisitorType() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getGateVisitorType(groupId, '0');
      if (response != null) {
        visitorTypeList.clear();
        if (response['RtnStatus']) {
          visitorTypeList.add({
            'id': '-1',
            'value': 'Select Visitor Type',
          });
          for (var r in response['RtnData']) {
            visitorTypeList.add({
              'id': '${r['VisitorTypeID']}',
              'value': '${r['VisitorTypeName']}',
              'showWalkin': '${r['ShowWalkInVisitor']}',
              // 'walkin': '${r['WalkInVisitor']}',
              'walkin': '${r['IsApprovalNeed']}',
            });
          }

          visitorTypeList
              .removeWhere((element) => element['showWalkin'] == 'false');

          if (visitorTypeList.length > 1) {
            visitorType('${visitorTypeList[1]['id']}');
            //show message
            isWalkin(visitorTypeList[1]['walkin'] == "true");
          }
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      // isLoading(false);
      getHostList();
    }
  }

  changeVisitorType(String? val) {
    if (val != null) {
      visitorType(val);
      var map = getMapItem(visitorTypeList.value, val);
      if (map['walkin'] != null) {
        isWalkin(map['walkin'] == 'true');
      }
    }
  }

  getHostList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getUserByClient(clientId, '0');
      if (response != null) {
        hostList.clear();
        if (response['RtnStatus']) {
          hostList.add({
            'id': '-1',
            'value': 'Select Host',
            'mobile': '',
          });
          for (var r in response['RtnData']) {
            hostList.add({
              'id': '${r['UserID']}',
              'value': '${r['UserName']} - ${r['TenantName']}',
              'mobile': '${r['MobileNo']}',
            });
          }

          if (visitor != null &&
              hostList.length > 1 &&
              hostList.any((p0) => p0['id'] == visitor!.hostID.toString())) {
            host('${visitor!.hostID}');
            // passNoController.text = visitor!.hostPhoneNo;
          } else {
            if (hostList.length > 1) {
              host('${hostList[1]['id']}');
              // passNoController.text = '${hostList.first['mobile']}';
            }
          }
        } else {
          showSnackbar(null, response['RtnMessage']);
        }
      }
      isLoading(false);
    }
  }

  selectVisitorImage() async {
    var res = await showOptionDialog();
    if (res != null) {
      visitorImage(res);
    }
  }

  changeHost(String? val) {
    if (val != null) {
      host(val);
      // passNoController.text = '${getMapItem(hostList, host.value)['mobile']}';
      //set host mobile number
    }
  }

  submitVisitor() async {
    if (nameController.text.isEmpty) {
      showSnackbar('Invalid', 'Enter Visitor Name');
      return;
    }
    // else if (companyController.text.isEmpty) {
    //   showSnackbar('Invalid', 'Enter Visitor From');
    // }

    if (await isNetConnected()) {
      isLoading(true);
      InsertVisitor submitVisitor = InsertVisitor();

      submitVisitor.visitorType =
          isOtp.value ? 2 : 1; // mobile no search 1, otp 2
      submitVisitor.visitorID = 0;
      submitVisitor.visitorPhoto = '$data64String${visitorImage.value}';
      submitVisitor.visitorName = nameController.text;
      submitVisitor.visitorPhoneNo = mobileController.text;
      submitVisitor.visitorEmailID = mailController.text;
      submitVisitor.visitorFrom = companyController.text;
      submitVisitor.bloodGroup = bloodController.text;
      submitVisitor.iDProofTypeID = int.parse(proof.value);
      submitVisitor.iDProofNo = proofNoController.text;
      submitVisitor.vehicleTypeID = int.parse(vehicle.value);
      submitVisitor.vehicleNo = vehicleController.text;
      submitVisitor.visitorTemprature = tempController.text;
      submitVisitor.isVirusInfected = isInfection.value;
      submitVisitor.purposeOfVisitID = int.parse(purpose.value);
      submitVisitor.purposeofVisitName =
          '${getMapItem(purposeList.value, purpose.value)['value']}';
      submitVisitor.visitorTypeID = int.parse(visitorType.value);
      submitVisitor.visitorTypeName =
          '${getMapItem(visitorTypeList.value, visitorType.value)['value']}';
      submitVisitor.hostID = int.parse(host.value);
      submitVisitor.hostName =
          '${getMapItem(hostList.value, host.value)['value']}';
      submitVisitor.appoinmentID = visitor?.appoinmentID ?? 0;
      submitVisitor.appoinmentOTP = 0;
      submitVisitor.visitingStatus = 0;
      submitVisitor.visitorsInTime = '';
      submitVisitor.visitorsOutTime = '';
      submitVisitor.systemID = _box.read(SELECTED_SYSTEM);
      submitVisitor.gateID = int.parse(_box.read(SELECTED_GATE));
      submitVisitor.gateName = "";
      submitVisitor.securityID = userId;
      submitVisitor.securityName = _box.read(USER_NAME) ?? '';
      submitVisitor.clientID = int.parse(clientId);
      submitVisitor.cuid = userId;
      submitVisitor.isAdditionalPerson = false;
      submitVisitor.additionalPerson = [];
      submitVisitor.isAssetCarryon = false;
      submitVisitor.assetDetails = [];
      submitVisitor.visitorPassNo = passNoController.text.toString();

      if (isWalkin.value) {
        var response = await ApiCall().requestVisitor(submitVisitor);
        isLoading(false);
        if (response != null) {
          if (response['RtnStatus']) {
            String msg = response['RtnMessage'];
            showAlert('VMS', msg, () {
              Get.offAllNamed(Routes.GATE_HOME);
            }, null);
          } else {
            showSnackbar('Something Wrong', '${response['RtnMessage']}');
          }
        }
      } else {
        var response = await ApiCall().insertVisitor(submitVisitor);
        isLoading(false);
        if (response != null) {
          if (response['RtnStatus']) {
            String msg = response['RtnMessage'];
            showAlert('VMS', msg, () {
              Get.offAllNamed(Routes.GATE_HOME);
            }, () async {
              var res =
                  await ApiCall().visitorInTimeUpdate('${response['ID']}');
              if (res != null) {
                if (res['RtnStatus']) {
                  Get.offAllNamed(Routes.GATE_HOME);
                  showSnackbar('Updated', '${response['RtnMessage']}');
                } else {
                  showSnackbar('Failed', '${response['RtnMessage']}');
                }
              }
            });
          } else {
            showSnackbar('Something Wrong', '${response['RtnMessage']}');
          }
        }
      }
    }
  }
}
