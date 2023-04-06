import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
import 'package:vms_app/helper/colors.dart';
import 'package:vms_app/routes/app_routes.dart';
import 'package:vms_app/widget/box_edittext.dart';
import 'package:vms_app/widget/spinner.dart';
import 'package:vms_app/widget/visitor_list.dart';
import 'package:vms_app/widget/visitor_shimmer.dart';

import 'gate_home_controller.dart';

class GateHomeScreen extends GetView<GateHomeController> {
  @override
  final controller = Get.put(GateHomeController());

  GateHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Scaffold(
        appBar: AppBar(
          leading: Obx(
            () => controller.logo.value.isEmpty
                ? const SizedBox.shrink()
                : CachedNetworkImage(
                    imageUrl: controller.logo.value,
                  ),
          ),
          title: Obx(
            () => Text(
              'Hi ${controller.name}!',
              style: const TextStyle(fontSize: 17),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  //app logout
                  Get.toNamed(Routes.NOTIFICATION);
                },
                icon: const Icon(
                  Icons.notifications_rounded,
                )),
            IconButton(
                onPressed: () {
                  //app logout
                  controller.logout();
                },
                icon: const Icon(
                  WebSymbols.logout,
                  size: 17,
                ))
          ],
        ),
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () {
                return controller.getVisitorList();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Obx(() => Spinner(controller.company.value,
                                  controller.companyList.value,
                                  hint: 'Select Company',
                                  fontSize: 12,
                                  onChanged: (val) =>
                                      controller.changeCompany(val))),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Obx(() => Spinner(
                                  controller.location.value,
                                  controller.locationList.value,
                                  hint: 'Select Location',
                                  fontSize: 12,
                                  onChanged: (val) =>
                                      controller.changeLocation(val))),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Obx(() => Spinner(controller.gate.value,
                                  controller.gateList.value,
                                  hint: 'Select Gate',
                                  fontSize: 12,
                                  onChanged: (val) =>
                                      controller.changeGate(val))),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Obx(() => Spinner(controller.system.value,
                                  controller.systemList.value,
                                  hint: 'Select System',
                                  fontSize: 12,
                                  onChanged: (val) =>
                                      controller.changeSystem(val))),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(10, 20),
                                blurRadius: 10,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(.1)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Visitor Entry',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87),
                                ),
                                IconButton(
                                    onPressed: () {
                                      controller.qrscan();
                                    },
                                    icon: const Icon(Icons.qr_code_scanner))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            BoxEditText(
                              placeholder: 'OTP / Mobile Number',
                              controller: controller.noController,
                              fillColor: Colors.white12,
                              suffixIcon: GestureDetector(
                                  onTap: () => controller.submitMobileNo(),
                                  child: const Icon(
                                    WebSymbols.search,
                                    size: 20,
                                  )),
                              textInputAction: TextInputAction.search,
                              keyboardType: TextInputType.phone,
                              isOnlyInt: true,
                              maxLength: 10,
                              maxLines: 1,
                              onSubmitted: (_) => controller.submitMobileNo(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Today Visitors',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                          Obx(
                            () => InkWell(
                              onTap: controller.visitorList.isEmpty
                                  ? null
                                  : () {
                                      // go to visitor list screen
                                      Get.toNamed(Routes.GATE_VISITOR_LIST,
                                          arguments: controller.visitorList);
                                    },
                              child: Text(
                                'View More',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: controller.visitorList.isEmpty
                                        ? Colors.grey
                                        : primary),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(() => controller.isVisitorLoading.value
                          ? VisitorShimmer()
                          : controller.visitorList.isEmpty
                              ? const Center(
                                  child: Text(
                                  'No Visitors Found',
                                  style: TextStyle(color: Colors.grey),
                                ))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.visitorList.length < 5
                                      ? controller.visitorList.length
                                      : 5,
                                  itemBuilder: (_, index) {
                                    var v = controller.visitorList[index];
                                    return VisitorList(
                                        v,
                                        () => controller.updateInTime(v),
                                        () => controller.updateOutTime(v));
                                  },
                                )),
                    ],
                  ),
                ),
              ),
            ),
            Obx(() => controller.isLoading.value
                ? Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.grey.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
