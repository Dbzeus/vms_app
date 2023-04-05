import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vms_app/helper/colors.dart';
import 'package:vms_app/helper/constants.dart';
import 'package:vms_app/helper/utils.dart';
import 'package:vms_app/model/visitor_response.dart';

class VisitorList extends StatelessWidget {
  final Visitor visitor;
  final Function() inTimeClick;
  final Function() outTimeClick;

  const VisitorList(this.visitor, this.inTimeClick, this.outTimeClick,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 160,
      child: Stack(
        children: [
          Positioned(
            left: 25,
            child: Container(
              height: 145,
              width: Get.width - 45,
              padding: const EdgeInsets.all(12),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              visitor.visitorName.trim(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            /*Text(
                              visitor.visitorFrom.trim(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),*/
                            InkWell(
                              onTap: () {
                                launchUrlString(
                                    "tel://" + visitor.visitorPhoneNo);
                              },
                              onLongPress: () {
                                Clipboard.setData(ClipboardData(
                                    text: visitor.visitorPhoneNo));
                                showSnackbar(
                                    'Phone no Copied!', visitor.visitorPhoneNo);
                              },
                              child: Text(
                                visitor.visitorPhoneNo,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              visitor.hostName.trim(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              visitor.visitorTypeName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              child: Text(
                                visitor.visitingStatusName,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              visitor.purposeofVisitName,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      visitor.visitorsInTime.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Appointment OTP ${visitor.appointmentOTP}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                visitor.statusId == 1
                                    ? InkWell(
                                        onTap: inTimeClick,
                                        child: const Text(
                                          'Update Visitor In Time',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: primary),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  visitor.gateName,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  visitor.visitorsInTime,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ],
                            ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(visitor.visitorPassNo,style: const TextStyle(
                              color: Colors.black, fontSize: 12),),
                          const SizedBox(
                            height: 4,
                          ),
                          visitor.visitorsInTime.isEmpty
                              ? const SizedBox.shrink()
                              : visitor.visitorsOutTime.isEmpty && visitor.statusId==3
                              ? InkWell(
                            onTap: outTimeClick,
                            child: const Icon(
                              Icons.login_outlined,
                              color: Colors.red,
                              size: 20,
                            ),
                          )
                              : Text(
                            visitor.visitorsOutTime,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 15,
            child: visitor.visitorPhoto.isURL
                ? CircleAvatar(
                    backgroundImage: NetworkImage(visitor.visitorPhoto),
                    radius: 28,
                  )
                : CircleAvatar(
                    backgroundImage: MemoryImage(base64Decode(
                        visitor.visitorPhoto.replaceAll(data64String, ''))),
                    radius: 28,
                  ),
          ),
        ],
      ),
    );
  }
}
