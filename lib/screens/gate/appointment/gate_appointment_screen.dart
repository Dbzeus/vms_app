import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vms_app/helper/colors.dart';
import 'package:vms_app/widget/box_edittext.dart';
import 'package:vms_app/widget/button.dart';
import 'package:vms_app/widget/spinner.dart';

import 'gate_appointment_controller.dart';

class GateAppointmentScreen extends GetView<GateAppointmentController> {
  GateAppointmentScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(GateAppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Visitor Details',
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: GestureDetector(
                    onTap: () => Get.focusScope?.unfocus(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // _buildCard(),
                          /*controller.warningMsg.isNotEmpty
                              ? Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                      child: Text(
                                    controller.warningMsg,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  )),
                                )
                              : const SizedBox.shrink(),*/
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Personal Details',
                                style: TextStyle(
                                    color: Colors.black87, fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  const Icon(FontAwesome.calendar,size: 12,),
                                  const SizedBox(width: 4,),
                                  Text('${controller.today} ${controller.time}',style: const TextStyle(fontSize: 13),)
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => controller.selectVisitorImage(),
                                child: CircleAvatar(
                                  radius: 33,
                                  child: Obx(
                                    () => controller.visitorImage.isNotEmpty
                                        ? CircleAvatar(
                                            backgroundImage: MemoryImage(base64Decode(
                                                controller.visitorImage.value)),
                                            backgroundColor: Colors.grey,
                                            radius: 30,
                                          )
                                        : const CircleAvatar(
                                            backgroundColor: Colors.black38,
                                            child: Icon(
                                              Icons.add_a_photo_outlined,
                                              color: Colors.white,
                                            ),
                                            radius: 30,
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    BoxEditText(
                                      placeholder: 'Visitor Name',
                                      prefixIcon: const Icon(
                                    Entypo.user,
                                    size: 14,
                                      ),
                                      readOnly: controller.isOtp.value,
                                      controller: controller.nameController,
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    BoxEditText(
                                      placeholder: 'Mobile Number',
                                      controller: controller.mobileController,
                                      prefixIcon: const Icon(
                                        Entypo.mobile,
                                        size: 14,
                                      ),
                                      keyboardType: TextInputType.phone,
                                      maxLength: 10,
                                      readOnly: true,
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    BoxEditText(
                                      placeholder: 'Company Name',
                                      prefixIcon: const Icon(
                                        FontAwesome.building,
                                        size: 14,
                                      ),
                                      readOnly: controller.isOtp.value,
                                      controller: controller.companyController,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                         /* const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: BoxEditText(
                                  placeholder: 'Date',
                                  prefixIcon: const Icon(
                                    FontAwesome.calendar,
                                    size: 14,
                                  ),
                                  readOnly: true,
                                  controller: TextEditingController(text: controller.today),
                                ),
                              ),
                              const SizedBox(width: 8,),
                              Expanded(
                                child: BoxEditText(
                                  placeholder: 'Time',
                                  prefixIcon: const Icon(
                                    FontAwesome.clock,
                                    size: 14,
                                  ),
                                  readOnly: true,
                                  controller: TextEditingController(text: controller.time),
                                ),
                              ),
                            ],
                          ),*/

                          /*const SizedBox(
                            height: 8,
                          ),
                          BoxEditText(
                            placeholder: 'Blood Group',
                            controller: controller.bloodController,
                            caps: TextCapitalization.characters,
                            prefixIcon: const Icon(
                              Icons.bloodtype,
                              size: 14,
                            ),
                            maxLength: 4,
                          ),*/
                          const Divider(),
                          /*const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'ID Proof Details',
                            style: TextStyle(
                                color: Colors.black87, fontWeight: FontWeight.w600),
                          ),*/
                          Obx(() => Spinner(
                                  controller.proof.value, controller.idProofList,
                                  showHint: true,
                                  hint: 'Select ID Proof', onChanged: (val) {
                                if (val != null) {
                                  controller.proof(val);
                                }
                              })),
                          const SizedBox(
                            height: 8,
                          ),
                          BoxEditText(
                            placeholder: 'ID Proof Number',
                            caps: TextCapitalization.characters,
                            prefixIcon: const Icon(
                              FontAwesome5.id_badge,
                              size: 14,
                            ),
                            controller: controller.proofNoController,
                          ),
                          const Divider(),
                         /* const Text(
                            'Vehicle Details',
                            style: TextStyle(
                                color: Colors.black87, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 8,
                          ),*/

                        /*  const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Visiting Details',
                            style: TextStyle(
                                color: Colors.black87, fontWeight: FontWeight.w600),
                          ),*/
                          Obx(() => Spinner(
                              controller.purpose.value, controller.purposeList,
                              hint: 'Select Purpose Of Visit',
                              showHint: true,
                              onChanged: controller.isOtp.value
                                  ? null
                                  : (val) {
                                      if (val != null) {
                                        controller.purpose(val);
                                      }
                                    })),
                          const SizedBox(
                            height: 8,
                          ),
                          Obx(() => Spinner(controller.visitorType.value,
                              controller.visitorTypeList,
                              hint: 'Select Visitor Type',
                              showHint: true,
                              onChanged: controller.isOtp.value
                                  ? null
                                  : (val) => controller.changeVisitorType(val))),
                          /*Obx(()=>controller.isWalkin.value
                              ? Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                      child: Text(
                                    controller.msg,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800),
                                  )),
                                )
                              : const SizedBox.shrink(),),*/
                          const SizedBox(
                            height: 8,
                          ),
                          Obx(() => Spinner(
                              controller.host.value, controller.hostList,
                              hint: 'Select Host',
                              showHint:true,
                              onChanged: controller.isOtp.value
                                  ? null
                                  : (val) => controller.changeHost(val))),
                          BoxEditText(
                            placeholder: 'Pass Id',
                            prefixIcon: const Icon(
                              FontAwesome5.passport,
                              size: 14,
                            ),
                            controller: controller.passNoController,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Divider(),
                          GestureDetector(
                            onTap: ()=>controller.isOptionalVisible(!controller.isOptionalVisible.value),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Optional'),
                                  Obx(()=>Icon(controller.isOptionalVisible.value ? Icons.arrow_drop_up : Icons.arrow_drop_down))
                                ],
                              ),
                            ),
                          ),
                          Obx(()=>Visibility(
                            visible: controller.isOptionalVisible.value,
                            child: Column(
                              children: [
                                Obx(() => Spinner(
                                    controller.vehicle.value, controller.vehicleList,
                                    showHint: true,
                                    hint: 'Select Vehicle', onChanged: (val) {
                                  if (val != null) {
                                    controller.vehicle(val);
                                  }
                                })),
                                const SizedBox(
                                  height: 8,
                                ),
                                BoxEditText(
                                  placeholder: 'Vehicle Number',
                                  caps: TextCapitalization.characters,
                                  prefixIcon: const Icon(
                                    Icons.electric_bike,
                                    size: 14,
                                  ),
                                  controller: controller.vehicleController,
                                ),
                                const Divider(),
                                BoxEditText(
                                  placeholder: 'Email ID',
                                  prefixIcon: const Icon(
                                    Zocial.email,
                                    size: 14,
                                  ),
                                  readOnly: controller.isOtp.value,
                                  controller: controller.mailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                BoxEditText(
                                  placeholder: 'Temperature',
                                  controller: controller.tempController,
                                  prefixIcon: const Icon(
                                    Typicons.temperatire,
                                    size: 14,
                                  ),
                                  keyboardType: const TextInputType.numberWithOptions(
                                    signed: true,
                                  ),
                                  maxLength: 5,
                                ),
                                Obx(
                                      () => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: SwitchListTile(
                                      value: controller.isInfection.value,
                                      secondary: const Icon(FontAwesome5.virus),
                                      onChanged: (val) {
                                        controller.isInfection(!controller.isInfection.value);
                                      },
                                      title: const Text(
                                        'Virus Infected?',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      dense: true,
                                      activeColor: primary,
                                      selected: controller.isInfection.value,
                                      contentPadding: const EdgeInsets.all(0),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),),
                          const SizedBox(
                            height: 24,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      buttonText: 'Cancel',
                      onPressed: () {
                        Get.back();
                      },
                      buttonType: ButtonType.secondary,
                    ),
                    Obx(
                          () => CustomButton(
                        buttonText: controller.isWalkin.value
                            ? 'Request Approval'
                            : 'Save',
                        textSize: controller.isWalkin.value
                            ? 12
                            : 14,
                        onPressed: () {
                          controller.submitVisitor();
                        },
                        buttonType: ButtonType.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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

  _buildCard() {
    return Card(
      elevation: 6,
      color: primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -30,
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(250, 250, 250, 1),
                    Color.fromRGBO(240, 240, 240, 1),
                  ])),
              width: 130,
              height: 100,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.asset(
                'assets/calendar.png',
                width: 50,
                height: 50,
              ),
              title: Text(
                controller.today,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
              subtitle: Text(
                controller.time,
                style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              trailing: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/sun.png',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
