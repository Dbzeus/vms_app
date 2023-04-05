import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:get/get.dart';
import 'package:vms_app/model/insert_appointment.dart';
import 'package:vms_app/screens/host/appointment/host_appointment_controller.dart';
import 'package:vms_app/widget/box_edittext.dart';
import 'package:vms_app/widget/button.dart';
import 'package:vms_app/widget/spinner.dart';

class HostAppointmentScreen extends GetView<HostAppointmentController> {
  @override
  final controller = Get.put(HostAppointmentController());

  HostAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Appointment',
          style: TextStyle(fontSize: 17),
        ),
        leading: GestureDetector(
          onTap: () => {Get.back()},
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: GestureDetector(
              onTap: () => Get.focusScope?.unfocus(),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Spinner(
                          controller.branch.value, controller.branchList,
                          hint: 'Select Branch',
                          onChanged: (val) => controller.changeBranch(val));
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(() {
                      return Spinner(
                          controller.location.value, controller.locationList,
                          hint: 'Select Location',
                          onChanged: (val) => controller.changeLocation(val));
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    BoxEditText(
                      placeholder: 'Appointment Title',
                      prefixIcon: const Icon(
                        Icons.title,
                        size: 14,
                      ),
                      controller: controller.titleController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BoxEditText(
                      placeholder: 'Appointment Date',
                      controller: controller.dateController,
                      prefixIcon: const Icon(
                        Entypo.calendar,
                        size: 14,
                      ),
                      readOnly: true,
                      onTab: ()=>controller.selectDateTime(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(() {
                      return Spinner(
                          controller.purpose.value, controller.purposeList,
                          hint: 'Select Purpose',
                          onChanged: (val) => controller.changePurpose(val));
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(() {
                      return Spinner(controller.visitorType.value,
                          controller.visitorTypeList,
                          hint: 'Select Visitor Type',
                          onChanged: (val) =>
                              controller.changeVisitorType(val));
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(() => controller.isApprover.value == "false"
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              Obx(() => controller.app1List.isEmpty
                                  ? const SizedBox.shrink()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Approver L1',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Spinner(controller.app1.value,
                                            controller.app1List,
                                            hint: 'Select Approver Level1',
                                            onChanged: (val) {
                                          if (val != null) {
                                            controller.app1(val);
                                          }
                                        }),
                                      ],
                                    )),
                              const SizedBox(
                                height: 8,
                              ),
                              Obx(() => controller.app2List.isEmpty
                                  ? const SizedBox.shrink()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Approver L2',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Spinner(controller.app2.value,
                                            controller.app2List,
                                            hint: 'Select Approver Level2',
                                            onChanged: (val) {
                                          if (val != null) {
                                            controller.app2(val);
                                          }
                                        }),
                                      ],
                                    )),
                              const SizedBox(
                                height: 8,
                              ),
                              Obx(() => controller.app3List.isEmpty
                                  ? const SizedBox.shrink()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Approver L3',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Spinner(controller.app3.value,
                                            controller.app3List,
                                            hint: 'Select Approver Level3',
                                            onChanged: (val) {
                                          if (val != null) {
                                            controller.app3(val);
                                          }
                                        }),
                                      ],
                                    )),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          )),
                    const Divider(),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Add Visitors',
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
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
                            height: 6,
                          ),
                          BoxEditText(
                            placeholder: 'Mobile Number',
                            controller: controller.visitorMobileController,
                            prefixIcon: const Icon(
                              Entypo.mobile,
                              size: 14,
                            ),
                            suffixIcon: GestureDetector(
                                onTap: () => controller.submitMobileNo(),
                                child: const Icon(
                                  WebSymbols.search,
                                  size: 12,
                                )),
                            textInputAction: TextInputAction.search,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            maxLines: 1,
                            fillColor: Colors.grey.shade50,
                            onSubmitted: (_) => controller.submitMobileNo(),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          BoxEditText(
                            placeholder: 'Name',
                            prefixIcon: const Icon(
                              Entypo.user,
                              size: 14,
                            ),
                            fillColor: Colors.grey.shade50,
                            controller: controller.visitorNameController,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          BoxEditText(
                            placeholder: 'Company Name',
                            prefixIcon: const Icon(
                              FontAwesome.building,
                              size: 14,
                            ),
                            fillColor: Colors.grey.shade50,
                            controller: controller.visitorCompanyNameController,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          BoxEditText(
                            placeholder: 'Email ID',
                            prefixIcon: const Icon(
                              Zocial.email,
                              size: 14,
                            ),
                            fillColor: Colors.grey.shade50,
                            controller: controller.visitorEmailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: CustomButton(
                                buttonText: 'Add',
                                onPressed: () {
                                  controller.addVisitor();
                                },
                                textSize: 12,
                                width: 60,
                                height: 35,
                              )),
                          const SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Visitor Details',
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(
                      () => controller.visitors.isEmpty
                          ? const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Add Visitor For Appointment',
                                style: TextStyle(color: Colors.grey),
                              ))
                          : ListView.builder(
                              itemCount: controller.visitors.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                return _buildVisitorList(
                                    controller.visitors[index]);
                              }),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          buttonText: 'Cancel',
                          onPressed: () {
                            Get.back();
                          },
                          buttonType: ButtonType.secondary,
                        ),
                        CustomButton(
                          buttonText: 'Submit',
                          onPressed: () {
                            controller.submit();
                          },
                          buttonType: ButtonType.primary,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
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

  _buildVisitorList(VisitorDetailsDTO visitor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              visitor.visitorName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
            Text(
              visitor.companyName,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              visitor.phoneNo,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
            Text(
              visitor.emailID,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            //remove visitor
          },
          child: InkWell(
            onTap: () {
              controller.visitors.remove(visitor);
            },
            child: const Text(
              'Remove Visitor',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                  letterSpacing: 1),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
