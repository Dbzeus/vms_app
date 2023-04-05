import 'package:flutter/material.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:get/get.dart';
import 'package:vms_app/screens/gate/visitors/visitor_list_controller.dart';
import 'package:vms_app/widget/box_edittext.dart';
import 'package:vms_app/widget/host_visitor_list.dart';
import 'package:vms_app/widget/visitor_list.dart';
import 'package:vms_app/widget/visitor_shimmer.dart';

import 'visitor_list_controller.dart';

class HostVisitorListScreen extends GetView<HostVisitorListController> {
  HostVisitorListScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(HostVisitorListController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.dispose();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Visitor Details',
              style: TextStyle(fontSize: 17),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                controller.dispose();
                Get.back();
              },
            ),
            // actions: [
            //   IconButton(
            //     icon: const Icon(
            //       Icons.refresh,
            //     ),
            //     onPressed: () => controller.getVisitorList(),
            //   ),
            // ],
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        BoxEditText(
                          placeholder: 'Search',
                          controller: controller.searchController,
                          suffixIcon: const Icon(
                            WebSymbols.search,
                            size: 12,
                          ),
                          textInputAction: TextInputAction.search,
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
                                    itemCount: controller.visitorList.length,
                                    itemBuilder: (_, index) {
                                      return HostVisitorList(controller.visitorList[index], (id)=>controller.onActionClick(id,controller.visitorList[index].visitorID, index));
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
          )),
    );
  }
}
