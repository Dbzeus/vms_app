import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vms_app/helper/colors.dart';
import 'package:vms_app/helper/constants.dart';
import 'package:vms_app/model/host_visitor_response.dart';

import '../helper/utils.dart';

class HostVisitorList extends StatelessWidget {
  final HostVisitor visitor;
  final Function(int id) onClickAction;

  const HostVisitorList(this.visitor,this.onClickAction, {Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 180,
      child: Stack(
        children: [
          Positioned(
            left: 25,
            child: Container(
              height: 165,
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
                            Text(
                              visitor.visitorFrom.trim(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
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
                            // Text(
                            //   visitor.visitorIDProofNo,
                            //   style: const TextStyle(
                            //       color: Colors.black, fontSize: 12),
                            // ),
                            // const SizedBox(
                            //   height: 4,
                            // ),
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
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              visitor.hostName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
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
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              visitor.visitorTypeName,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            visitor.visitingStatus==0 ?
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  child: InkWell(
                                    onTap: ()=>onClickAction(1),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.thumb_up_alt_rounded,size: 12, color: Colors.white,),
                                        SizedBox(width: 4,),
                                        Text(
                                          'Approved',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  child: InkWell(
                                    onTap: ()=>onClickAction(2),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.thumb_down_alt_rounded,size: 12, color: Colors.white,),
                                        SizedBox(width: 4,),
                                        Text(
                                          'Reject',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ) : const SizedBox.shrink(),
                            // Text(
                            //   visitor.vehicleNo.isEmpty
                            //       ? visitor.vehType
                            //       : visitor.vehicleNo,
                            //   style: const TextStyle(
                            //       color: Colors.black, fontSize: 12),
                            // ),
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
                      Column(
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
                        children: [
                          Text(
                            visitor.securityName,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            visitor.visitorsOutTime,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
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
