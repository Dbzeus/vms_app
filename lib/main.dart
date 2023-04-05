import 'package:alice/alice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vms_app/helper/colors.dart';
import 'package:vms_app/helper/constants.dart';
import 'package:vms_app/routes/app_pages.dart';

import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //check session
  await GetStorage.init();

  final box = GetStorage();

  String path = Routes.LOGIN;
  if (box.read(IS_LOGIN) ?? false) {
    if (box.read(IS_SECURITY) ?? false) {
      path = Routes.GATE_HOME;
    } else if (box.read(IS_ADMIN) ?? false) {
      path = Routes.HOST_HOME;
    }
  }

  await Firebase.initializeApp();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((message) {
    RemoteNotification? notification = message.notification!;
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: 'notify_icon',
            channelDescription: channel.description,
            importance: channel.importance,
          ),
        ));
  });

  runApp(MyApp(path));
}

class MyApp extends StatelessWidget {
  String path;

  MyApp(
    this.path, {
    Key? key,
  }) : super(key: key);

  static final alice = Alice(
    showNotification: true,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'VMS',
      navigatorKey: alice.getNavigatorKey(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primary,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: path,
      getPages: AppPages.routes,
    );
  }
}
