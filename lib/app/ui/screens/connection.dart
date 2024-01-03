import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';
import 'package:heethings_demo/app/core/constants/enums.dart';
import 'package:heethings_demo/app/core/utils/common.dart';
import 'package:heethings_demo/app/core/utils/screen.dart';
import 'package:heethings_demo/app/data/routes/routes.dart';
import 'package:heethings_demo/app/data/services/app.dart';
import 'package:heethings_demo/app/data/services/mqtt.dart';
import 'package:heethings_demo/app/ui/components/appbar.dart';
import 'package:heethings_demo/app/ui/components/gap.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  final MqttController mqttController = Get.find();
  bool ignoreTimer = false;

  @override
  void initState() {
    super.initState();
    initConnection();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (app) {
      return GetBuilder<MqttController>(builder: (mqtt) {
        return Scaffold(
          appBar: AppBarWidget(
            automaticallyImplyLeading: false,
            action: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                mqttController.disconnectMqtt();
                if (mounted) setState(() => ignoreTimer = true);
                Future.delayed(
                    Duration.zero, () => Get.offAllNamed(Routes.home));
              },
            ),
          ),
          body: Center(
            child: mqtt.demoId == null ||
                    mqtt.demoId!.isEmpty ||
                    !CommonUtils.validateTextPattern(mqtt.demoId!)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Analyzing Demo Code"),
                      ElevatedButton(
                          onPressed: () => Get.offAllNamed(Routes.home),
                          child: const Text("Startover")),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Demo Session (${mqtt.demoId})",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(50),
                      connectionStatusWidget(
                          "internet connection",
                          mqtt.isConnectedToInternet
                              ? ConnectionStatus.connected
                              : ConnectionStatus.connecting),
                      connectionStatusWidget(
                          mqtt.mqttInitializationText, mqtt.mqttInitialization),
                      connectionStatusWidget(
                          mqtt.mqttConnectionText, mqtt.mqttConnection),
                      connectionStatusWidget(
                          mqtt.mqttSubscriptionText, mqtt.mqttSubscription),
                    ],
                  ),
          ),
        );
      });
    });
  }

  Widget connectionStatusWidget(String text, ConnectionStatus status) {
    Widget leading = Container();
    switch (status) {
      case ConnectionStatus.idle:
        leading = const Icon(Icons.more_horiz);
        break;
      case ConnectionStatus.connecting:
        leading = const CircularProgressIndicator();
        break;
      case ConnectionStatus.connected:
        leading = const Icon(Icons.check, color: UiColors.success);
        break;
      case ConnectionStatus.error:
        leading = const Icon(Icons.error, color: UiColors.danger);
        break;
    }
    return SizedBox(
      width: ScreenUtils.breakpointXS,
      child: ListTile(
        leading: leading,
        title: Text(text),
      ),
    );
  }

  void initConnection() async {
    mqttController.initMqtt();
    triggerChecker();
  }

  Future<void> triggerChecker() async {
    if (ignoreTimer) return;
    Future.delayed(const Duration(seconds: 1), () {
      final MqttController mc = Get.find();
      if (mc.isConnectedToInternet && mc.mqttReady) {
        if (!ignoreTimer) {
          Future.delayed(
              Duration.zero, () => Get.offAndToNamed(Routes.demoRoleOptions));
        }
      } else {
        if (!ignoreTimer) {
          triggerChecker();
        }
      }
    });
  }
}
