import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: RefreshIndicator(
        onRefresh: ()async {
          await controller.notification();
        },
        child: Obx(() => controller.isLoading.value
            ? const Center(
              child: CircularProgressIndicator(),
            )
            : controller.list.isEmpty ? const Center(child: Text('No New Notification')): ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.list.length,
                itemBuilder: (_, index) {
                  var detail=controller.list[index];
                  return Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 2.0,
                              spreadRadius: 1.0,
                            ), //BoxShadow//BoxShado
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    detail['NotificationTitle'],
                                    style:
                                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                ),
                                Text(
                                  detail['CuDate'],
                                  style:
                                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              detail['NotificationMsg'],
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
