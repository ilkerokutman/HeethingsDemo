import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/data/services/app.dart';

class QrScanButtonWidget extends StatelessWidget {
  final Function(String) onScanCompleted;
  const QrScanButtonWidget({super.key, required this.onScanCompleted});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (app) {
        return (app.cameras.isNotEmpty)
            ? IconButton(
                icon: const Icon(Icons.qr_code),
                onPressed: () async {
                  late String qrScanResult;
                  try {
                    qrScanResult = await FlutterBarcodeScanner.scanBarcode(
                      '#F47E1A',
                      "Vazgeç",
                      true,
                      ScanMode.QR,
                    );
                  } catch (e) {
                    qrScanResult = "";
                  }
                  onScanCompleted(qrScanResult);
                },
                iconSize: 42,
              )
            : Container();
      },
    );
  }
}
