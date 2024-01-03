import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/enums.dart';
import 'package:heethings_demo/app/core/utils/dialogs.dart';
import 'package:heethings_demo/app/core/utils/screen.dart';
import 'package:heethings_demo/app/data/services/app.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/data/services/mqtt.dart';
import 'package:heethings_demo/app/ui/components/appbar.dart';
import 'package:heethings_demo/app/ui/widgets/sensor_demo.dart';
import 'package:heethings_demo/app/ui/widgets/viewer/cafe/viewer_cafe_widget.dart';
import 'package:heethings_demo/app/ui/widgets/viewer/factory/viewer_factory_widget.dart';
import 'package:heethings_demo/app/ui/widgets/viewer/home/viewer_home_widget.dart';
import 'package:heethings_demo/app/ui/widgets/viewer/viewer_menu_widget.dart';

class DemoViewerScreen extends StatelessWidget {
  const DemoViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenSize screenSize = ScreenUtils.screenSize(constraints);
        bool isMobile =
            screenSize == ScreenSize.xs || screenSize == ScreenSize.s;
        return GetBuilder<AppController>(
          builder: (ac) {
            return GetBuilder<DemoController>(
              builder: (dc) {
                return Scaffold(
                  appBar: AppBarWidget(
                    automaticallyImplyLeading: true,
                    action: IconButton(
                        onPressed: () {
                          final MqttController mqtt = Get.find();
                          DialogUtils.showQrDialog(context, mqtt.demoId ?? '');
                        },
                        icon: const Icon(Icons.qr_code)),
                  ),
                  body: dc.demoViewport == DemoViewport.none
                      ? ViewerMenuWidget(isMobile: isMobile)
                      : Stack(
                          children: [
                            dc.demoViewport == DemoViewport.cafe
                                ? const ViewerCafeWidget()
                                : dc.demoViewport == DemoViewport.factory
                                    ? const ViewerFactoryWidget()
                                    : dc.demoViewport == DemoViewport.home
                                        ? const ViewerHomeWidget()
                                        : dc.demoViewport == DemoViewport.sensor
                                            ? const SensorDemoWidget()
                                            : Container(),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: UiDimens.a20,
                                decoration: BoxDecoration(
                                  color: UiColors.white,
                                  borderRadius: UiDimens.c20,
                                  boxShadow: [
                                    BoxShadow(
                                      color: UiColors.black.withOpacity(0.1),
                                      blurRadius: 12,
                                      offset: const Offset(1, 1),
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: UiDimens.c20,
                                  child: ToggleButtons(
                                    isSelected: [
                                      dc.demoViewport == DemoViewport.none,
                                      dc.demoViewport == DemoViewport.home,
                                      dc.demoViewport == DemoViewport.cafe,
                                      dc.demoViewport == DemoViewport.factory,
                                      dc.demoViewport == DemoViewport.sensor,
                                    ],
                                    onPressed: (int index) =>
                                        dc.setDemoViewport(
                                            DemoViewport.values[index]),
                                    children: const [
                                      Icon(Icons.menu),
                                      Icon(Icons.home),
                                      Icon(Icons.coffee),
                                      Icon(Icons.factory),
                                      Icon(Icons.sensors),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                );
              },
            );
          },
        );
      },
    );
  }
}
