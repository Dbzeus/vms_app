import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vms_app/helper/colors.dart';


showSnackbar(String? title, String? msg) {
  msg=msg ?? "";
  debugPrint('toast $title $msg');
  Fluttertoast.showToast(
      msg: msg.isEmpty ?  "Something went wrong" : msg,
      toastLength: Toast.LENGTH_LONG,

  );
 /* Get.snackbar(title ?? '', msg ?? '',
      snackPosition: SnackPosition.BOTTOM, colorText: Colors.black);*/
}

final _picker = ImagePicker();

Future<String?> showOptionDialog() async {
  Get.focusScope!.unfocus();
  return await showDialog(
    context: Get.context!,
    barrierDismissible: true,
    builder: (BuildContext con) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Image From?',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final pickedFile = await _picker.pickImage(
                          source: ImageSource.camera, imageQuality: 15);

                      if (pickedFile != null) {
                        var r = base64Encode(
                            File(pickedFile.path).readAsBytesSync());
                        Get.back(result: r);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: const Text(
                      'Camera',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedFile = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 15);

                      if (pickedFile != null) {
                        var r = base64Encode(
                            File(pickedFile.path).readAsBytesSync());
                        Get.back(result: r);
                      } else {}
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primary,
                    ),
                    child: const Text('Gallery',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

showAlert(String title, String msg, Function() onNegativeClick,
    Function()? onPossitiveClick) async {
  Get.focusScope!.unfocus();
  await showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext con) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                msg,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: onNegativeClick,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: const Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  onPossitiveClick == null
                      ? const SizedBox.shrink()
                      : ElevatedButton(
                          onPressed: onPossitiveClick,
                          style: ElevatedButton.styleFrom(
                            primary: primary,
                          ),
                          child: const Text('Visitor-IN',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
