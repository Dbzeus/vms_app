import 'package:get/get.dart';
import 'package:vms_app/screens/gate/appointment/gate_appointment_screen.dart';
import 'package:vms_app/screens/gate/home/gate_home_screen.dart';
import 'package:vms_app/screens/gate/visitors/visitor_list_screen.dart';
import 'package:vms_app/screens/host/appointment/host_appointment_screen.dart';
import 'package:vms_app/screens/host/home/host_home_screen.dart';
import 'package:vms_app/screens/host/visitors/visitor_list_screen.dart';
import 'package:vms_app/screens/login/login_screen.dart';
import 'package:vms_app/screens/notification/notification_screen.dart';

import '../screens/qrscan/qrscan_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.HOST_HOME,
      page: () => HostHomeScreen(),
    ),
    GetPage(
      name: Routes.HOST_APPOINTMENT,
      page: () => HostAppointmentScreen(),
    ),
    GetPage(
      name: Routes.GATE_HOME,
      page: () => GateHomeScreen(),
    ),
    GetPage(
      name: Routes.GATE_APPOINTMENT,
      page: () => GateAppointmentScreen(),
    ),
    GetPage(
      name: Routes.GATE_VISITOR_LIST,
      page: () => GateVisitorListScreen(),
    ),
    GetPage(
      name: Routes.HOST_VISITOR_LIST,
      page: () => HostVisitorListScreen(),
    ),
    GetPage(
      name: Routes.QR_SCAN,
      page: () => QRScanScreen(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => NotificationScreen(),
    ),
  ];
}
