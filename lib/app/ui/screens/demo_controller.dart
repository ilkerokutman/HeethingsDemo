import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/enums.dart';
import 'package:heethings_demo/app/core/constants/mqtt.dart';
import 'package:heethings_demo/app/core/utils/dialogs.dart';
import 'package:heethings_demo/app/data/services/app.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/data/services/mqtt.dart';
import 'package:heethings_demo/app/ui/components/appbar.dart';
import 'package:heethings_demo/app/ui/widgets/control/p1999/cafe_control_screen.dart';
import 'package:heethings_demo/app/ui/widgets/control/p1994/factory_control.dart';
import 'package:heethings_demo/app/ui/widgets/home_control.dart';
import 'package:heethings_demo/app/ui/widgets/sensor_demo.dart';

class DemoControllerScreen extends StatelessWidget {
  const DemoControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ScreenSize screenSize = ScreenUtils.screenSize(constraints);
        // bool isMobile =
        //     screenSize == ScreenSize.xs || screenSize == ScreenSize.s;

        return GetBuilder<AppController>(
          builder: (ac) {
            return GetBuilder<DemoController>(
              builder: (dc) {
                Widget content = Container();
                switch (dc.demoViewport) {
                  case DemoViewport.none:
                    content = const Center(
                      child: Text("Select a scenario"),
                    );
                    break;
                  case DemoViewport.home:
                    content = const HomeControlWidget();
                    break;
                  case DemoViewport.cafe:
                    content = const CafeControlWidget();
                    break;
                  case DemoViewport.factory:
                    content = const FactoryControlWidget();
                    break;
                  case DemoViewport.sensor:
                    content = const SensorDemoWidget();
                    break;
                }

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
                  bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.menu),
                        label: "None",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.coffee),
                        label: "Cafe",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.factory),
                        label: "Factory",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.sensors),
                        label: "Sensors",
                      ),
                    ],
                    currentIndex: dc.demoViewport.index,
                    onTap: (i) {
                      dc.broadcast(MqttTopic.demoViewport, i);
                    },
                  ),
                  body: content,
                );
              },
            );
          },
        );
      },
    );
  }
}
