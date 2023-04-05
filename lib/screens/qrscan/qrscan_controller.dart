import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanController extends GetxController {
  Barcode? result;
  QRViewController? qrController;
  GetStorage box = GetStorage();
  int appId = -1, userId = -1;
  RxBool isLoading = false.obs;
  Rx<IconData> flash = Rx(Icons.flash_on);

  String qrcode = Get.arguments?['qrcode'] ?? '';

  void onQRViewCreated(QRViewController qr) {
    qrController = qr;

    qrController?.scannedDataStream.listen((scanData) async {
      result = scanData;
      if (result != null) {
        print(result?.code);
        Get.back(result: result?.code);
      }
    });
  }

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }
}
