import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:get/get.dart';
import 'package:vms_app/helper/colors.dart';
import 'package:vms_app/model/host_dashboard_response.dart';
import 'package:vms_app/routes/app_routes.dart';
import 'package:vms_app/screens/host/home/host_home_controller.dart';
import 'package:vms_app/widget/host_visitor_list.dart';
import 'package:vms_app/widget/spinner.dart';
import 'package:vms_app/widget/visitor_count_shimmer.dart';
import 'package:vms_app/widget/visitor_shimmer.dart';

class HostHomeScreen extends GetView<HostHomeController> {
  HostHomeScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(HostHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Hi ${controller.name.value}!',
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
              onRefresh: (){
                return controller.getVisitorList();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Obx(() {
                                return Spinner(controller.location.value,
                                    controller.locationList,
                                    hint: 'Select Location',
                                    fontSize: 12,
                                    onChanged: (val) =>
                                        controller.changeLocation(val));
                              }),
                            ),
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                controller.selectDates();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Obx(() => Text(
                                      '${controller.dates}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Statistics',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.HOST_APPOINTMENT);
                            },
                            child: const Text(
                              'Create Appointment',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                  letterSpacing: 1,
                                  decorationStyle: TextDecorationStyle.dotted,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 220,
                        child: Obx(
                          () => controller.isDashboardLoading.value
                              ? const VisitorCountShimmer()
                              : controller.dashboardList.isEmpty
                                  ? const Center(
                                      child: Text(
                                      'No Client Found',
                                      style: TextStyle(color: Colors.grey),
                                    ))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.dashboardList.length,
                                      itemBuilder: (_, index) {
                                        return companyListItem(
                                            controller.dashboardList[index]);
                                      },
                                    ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
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
                                      Get.toNamed(Routes.HOST_VISITOR_LIST,
                                          arguments: {
                                            'visitors': controller.visitorList,
                                            'groupId': '${controller.groupId}',
                                            'userId': '${controller.userId}',
                                            'fromDate': controller.fromDate,
                                            'toDate': controller.toDate,
                                          });
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
                                    return HostVisitorList(
                                      controller.visitorList[index],
                                            (id)=>controller.onActionClick(id,controller.visitorList[index].visitorID, index)
                                    );
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
    );
  }

  companyListItem(HostDashboard list) {
    return SizedBox(
      width: 160,
      height: 200,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 40,
            child: Container(
              width: 150,
              height: 150,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(10, 20),
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: Colors.grey.withOpacity(.05)),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: Text(
                      list.clientName,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            '${list.inVisitor}',
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            '${list.outVisitor}',
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          CachedNetworkImage(
            imageUrl: list.logoPath,
            width: 100,
            height: 80,
          ),
        ],
      ),
    );
  }
}
