import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';
import 'package:heethings_demo/app/ui/components/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DialogUtils {
  //show alert / confirm

  //show modal
  static showQrDialog(BuildContext context, String qrCode) {
    showDialog(
      context: context,
      builder: (_) {
        return Material(
          type: MaterialType.transparency,
          color: Colors.purple,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  width: 340,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Theme.of(context).primaryColor,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        child: Text(
                          "Scan to join demo",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: UiColors.white,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: QrImageView(
                          data: qrCode,
                          version: QrVersions.auto,
                          // size: 600,
                        ),
                      ),
                      Center(
                        child: Text(
                          qrCode,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //show bottomsheet
}
