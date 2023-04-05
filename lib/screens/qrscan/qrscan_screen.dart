import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vms_app/helper/colors.dart';

import 'qrscan_controller.dart';

class QRScanScreen extends GetView<QRScanController> {
  @override
  final controller = Get.put(QRScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(),
          Positioned(
            top: 32,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back)),
                IconButton(
                    onPressed: () {
                      controller.qrController?.toggleFlash();
                      controller.flash(
                          (controller.flash.value == Icons.flash_on)
                              ? Icons.flash_off
                              : Icons.flash_on);
                    },
                    color: Colors.white,
                    icon: Obx(() => Icon(controller.flash.value))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView() {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (Get.width < 400 || Get.height < 400) ? 180.0 : 350.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: GlobalKey(debugLabel: 'QR'),
          onQRViewCreated: controller.onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: primary,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) {
            if (!p) {
              Get.snackbar('Permission Denied', 'Camera Permission Denied');
            }
          },
        ),
        Obx(() => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const SizedBox.shrink()),
      ],
    );
  }
}
