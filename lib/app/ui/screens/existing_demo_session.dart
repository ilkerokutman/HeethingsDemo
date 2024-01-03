import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/enums.dart';
import 'package:heethings_demo/app/core/constants/keys.dart';
import 'package:heethings_demo/app/core/utils/box.dart';
import 'package:heethings_demo/app/core/utils/common.dart';
import 'package:heethings_demo/app/core/utils/screen.dart';
import 'package:heethings_demo/app/data/routes/routes.dart';
import 'package:heethings_demo/app/data/services/app.dart';
import 'package:heethings_demo/app/data/services/mqtt.dart';
import 'package:heethings_demo/app/ui/components/appbar.dart';
import 'package:heethings_demo/app/ui/components/appbutton.dart';
import 'package:heethings_demo/app/ui/components/gap.dart';

class ExistingDemoSessionScreen extends StatelessWidget {
  const ExistingDemoSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      ScreenSize screenSize = ScreenUtils.screenSize(constraints);
      bool isMobile = screenSize == ScreenSize.xs || screenSize == ScreenSize.s;

      log("ScreenSize: $screenSize");
      return GetBuilder<AppController>(builder: (app) {
        return GetBuilder<MqttController>(builder: (mqtt) {
          String existingDemoId = Box.getString(key: Keys.demoId);

          Widget titleWidget = Container(
            margin: UiDimens.b60,
            child: Text(
              "Load an Existing Demo Session",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );

          Widget latestWidget = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              labelTextWidget(context, "Continue with latest demo session:"),
              Container(
                margin: UiDimens.v20,
                width: double.infinity,
                height: UiDimens.buttonHeight,
                child: AppButton(
                  callback: () {
                    continueDemoSession(existingDemoId);
                  },
                  title: "Load Last Demo",
                ),
              ),
              const Gap(50),
            ],
          );

          Widget formWidget = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              labelTextWidget(context, "Enter a demo session id"),
              Container(
                margin: UiDimens.v20,
                height: UiDimens.buttonHeight,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: app.existingDemoIdFocusNode,
                        controller: app.existingDemoIdTextController,
                        textAlign: TextAlign.center,
                        inputFormatters: [app.existingDemoIdMaskFormatter],
                        autocorrect: false,
                        enableSuggestions: false,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: UiDimens.stadium),
                          labelText: "Demo Session Id",
                          hintText: "xxx-xxxx-xxx",
                        ),
                      ),
                    ),
                    const Gap(20),
                    SizedBox(
                      height: UiDimens.buttonHeight,
                      child: AppButton(
                        callback: () {
                          continueDemoSession(
                              app.existingDemoIdTextController.text);
                        },
                        title: "Load Demo",
                      ),
                    )
                  ],
                ),
              ),
              const Gap(50),
            ],
          );

          Widget qrWidget = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              labelTextWidget(context, "Scan a demo session Qr Code"),
              Container(
                margin: UiDimens.v20,
                width: double.infinity,
                height: UiDimens.buttonHeight,
                child: AppButton(
                  callback: onQrButtonPressed,
                  icon: const Icon(Icons.qr_code),
                  title: "Scan",
                ),
              ),
              const Gap(50),
            ],
          );

          Widget startNewWidget = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("or"),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Start a new Demo Session"),
              ),
              const Gap(20),
            ],
          );

          return Scaffold(
            appBar: const AppBarWidget(),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth:
                          isMobile ? double.infinity : ScreenUtils.breakpointS),
                  padding: UiDimens.a40,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      titleWidget,
                      // if (existingDemoId.isNotEmpty)
                      latestWidget,
                      formWidget,
                      if (app.cameras.isNotEmpty) qrWidget,
                      startNewWidget,
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      });
    });
  }

  Widget labelTextWidget(BuildContext context, String text) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }

  Future<void> onQrButtonPressed() async {
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
    continueDemoSession(qrScanResult);
  }

  Future<void> continueDemoSession(String id) async {
    final AppController appController = Get.find();
    if (CommonUtils.validateTextPattern(id)) {
      await appController.continueExistingDemoSession(id);
      Future.delayed(Duration.zero, () => Get.offAndToNamed(Routes.connecting));
    } else {
      //TODO: show error alert
    }
  }
}
