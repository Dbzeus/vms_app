import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:vms_app/apis/api_call.dart';
import 'package:vms_app/helper/constants.dart';
import 'package:vms_app/model/login_response.dart';
import 'package:vms_app/routes/app_routes.dart';

class LoginController extends GetxController {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isRememberMe = true.obs, isSecure = true.obs;
  var passwordIcon = Icons.visibility.obs;
  late PackageInfo packageInfo;
  RxString appVersion = ''.obs;

  RxBool isLoginLoading = false.obs;

  String token = '';

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  GetStorage box = GetStorage();

  @override
  void onInit() async {
    super.onInit();

    packageInfo = await PackageInfo.fromPlatform();
    box.write(APP_VERSION, packageInfo.version);

    appVersion('App Version ${packageInfo.version}');

    userNameController.text = box.read(USER_NAME) ?? '';
    passwordController.text = box.read(PASSWORD) ?? '';
  }

  @override
  void onReady() async {
    _fcm.requestPermission(alert: true,sound: true, badge: true);

  }

  login() async {
    Get.focusScope!.unfocus();

    print(
        'password : ${passwordController.text} mobile : ${userNameController.text} $token');

    if (userNameController.text.isEmpty) {
      Get.snackbar('Invalid', 'Enter User Name',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } else if (passwordController.text.isEmpty) {
      Get.snackbar('Invalid', 'Enter Password',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } else {
      // if (!await checkLocationPermission()) {
      //   return Get.snackbar(
      //     'Permission Error',
      //     'Location permissions are permanently denied, we cannot request permissions.',
      //     snackPosition: SnackPosition.BOTTOM,
      //     colorText: Colors.white,
      //   );
      // }

      if (await isNetConnected()) {
        isLoginLoading(true);

        token = await _fcm.getToken() ?? '';


        LoginResponse? response = await ApiCall()
            .login(userNameController.text, passwordController.text, token);
        if (response != null) {
          if (response.rtnStatus) {
            box.write(IS_REMEMBER_ME, isRememberMe.value);
            box.write(USER_ID, response.rtnData?.userID);
            box.write(USER_NAME, response.rtnData?.userName);
            box.write(PASSWORD, passwordController.text);
            box.write(FIRST_NAME, response.rtnData?.firstName);
            box.write(CLIENT_ID, response.rtnData?.clientID);
            box.write(GROUP_ID, response.rtnData?.clientGroupID);
            box.write(CLIENT_LOGO, response.rtnData?.clientLogo ?? '');
            box.write(
                IS_ADMIN,
                ((response.rtnData?.isAdmin ?? false) ||
                    (response.rtnData?.isSuperAdmin ?? false) ||
                    (response.rtnData?.isTenant ?? false) ||
                    (response.rtnData?.isTechnician ?? false)));
            box.write(IS_SECURITY, response.rtnData?.isSecurity);
            box.write(IS_LOGIN, true);
            print("is login ? ${box.read(IS_LOGIN)}");

            if (response.rtnData?.isSecurity ?? false) {
              Get.offAndToNamed(Routes.GATE_HOME);
            } else if (box.read(IS_ADMIN) ?? false) {
              Get.offAndToNamed(Routes.HOST_HOME);
            }
          } else {
            Get.snackbar(
              'Login Failed',
              response.rtnMessage,
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
            );
          }
        }
        isLoginLoading(false);
      }
    }
  }

  passwordToggle() {
    isSecure(!isSecure.value);
    isSecure.value
        ? passwordIcon(Icons.visibility)
        : passwordIcon(Icons.visibility_off);
  }

  void forgetMpin() async {
    /*   try {
      showLoader(title: 'Sending SMS');
      var response = await sendMpin(mobileController.text);
      showToastMsg('${response["RtnMessage"]}');
      hideLoader();
    } catch (e) {
      showToastMsg('Something went wrong');
      hideLoader();
    }*/
  }
}
