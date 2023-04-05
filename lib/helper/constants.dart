import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

/*
* connstant functions
*/

var connectivity = Connectivity();

isNetConnected() async {
  bool res =
      (await connectivity.checkConnectivity()) != ConnectivityResult.none;
  if (!res) showNetworkError();
  return res;
}

showNetworkError() {
  Get.snackbar(
    'Network Error',
    'Check Your Internet Connection',
    backgroundColor: Colors.red,
    colorText: Colors.white,
    icon: const Icon(
      Icons.signal_cellular_connected_no_internet_4_bar,
      color: Colors.white,
    ),
  );
}

const data64String = "data:image/jpeg;base64,";

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'VMS', // id
  'VMS Dbzeus', // title
  description: 'This channel is used for important notifications.',
  // description
  importance: Importance.max,
);

/*
* connstant strings used for session and intent params
*/

const APP_VERSION = 'APP_VERSION';
const USER_ID = 'USER_ID';
const CLIENT_ID = 'CLIENT_ID';
const GROUP_ID = 'GROUP_ID';
const CLIENT_LOGO = 'CLIENT_LOGO';
const USER_NAME = 'USER_NAME';
const PASSWORD = 'PASSWORD';
const IS_REMEMBER_ME = 'IS_REMEMBER_ME';
const IS_LOGIN = 'IS_LOGIN';
const IS_ADMIN = 'IS_ADMIN';
const IS_SECURITY = 'IS_SECURITY';
const FIRST_NAME = 'FIRST_NAME';
const SELECTED_CLIENT = 'SELECTED_CLIENT';
const SELECTED_LOCATION = 'SELECTED_LOCATION';
const SELECTED_GATE = 'SELECTED_GATE';
const SELECTED_SYSTEM = 'SELECTED_SYSTEM';
const CLIENT_GROUP_ID = 'CLIENT_GROUP_ID';
