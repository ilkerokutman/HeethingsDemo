import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/enums.dart';
import 'package:heethings_demo/app/core/utils/screen.dart';
import 'package:heethings_demo/app/data/routes/routes.dart';
import 'package:heethings_demo/app/data/services/app.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/data/services/mqtt.dart';
import 'package:heethings_demo/app/ui/components/appbar.dart';
import 'package:heethings_demo/app/ui/widgets/option_item.dart';

class RoleOptionsScreen extends StatefulWidget {
  const RoleOptionsScreen({super.key});

  @override
  State<RoleOptionsScreen> createState() => _RoleOptionsScreenState();
}

class _RoleOptionsScreenState extends State<RoleOptionsScreen> {
  bool hasTimerOnViewer = false;
  bool hasTimerOnController = false;
  bool timerStarted = false;
  int secondsLeftToTrigger = 6;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    runInitializer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      ScreenSize screenSize = ScreenUtils.screenSize(constraints);
      bool isMobile = screenSize == ScreenSize.xs || screenSize == ScreenSize.s;
      // if (!timerStarted) {
      //   switch (screenSize) {
      //     case ScreenSize.xxl:
      //     case ScreenSize.l:
      //     case ScreenSize.xl:
      //       if (mounted) setState(() => hasTimerOnViewer = true);
      //       startTimer();
      //       break;

      //     case ScreenSize.xs:
      //       if (mounted) setState(() => hasTimerOnController = true);
      //       startTimer();
      //       break;

      //     default:
      //       break;
      //   }
      // }

      return GetBuilder<AppController>(builder: (app) {
        return GetBuilder<MqttController>(builder: (mqtt) {
          return PopScope(
            onPopInvoked: (v) {
              //TODO: confirm dialog for exiting
            },
            child: Scaffold(
              appBar: AppBarWidget(
                automaticallyImplyLeading: false,
                action: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    mqtt.disconnectMqtt();
                    Get.offAllNamed(Routes.home);
                  },
                ),
              ),
              body: GestureDetector(
                onTap: () {
                  _timer?.cancel();
                  setState(() {
                    secondsLeftToTrigger = 0;
                    hasTimerOnController = false;
                    hasTimerOnViewer = false;
                    timerStarted = false;
                  });
                },
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: isMobile
                            ? double.infinity
                            : ScreenUtils.breakpointS),
                    padding: UiDimens.a40,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Choose Demo Role",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        OptionItemCardWidget(
                          title: "VIEWER",
                          description:
                              "Use this device to display demo content on large screen.",
                          icon: Icons.tv,
                          actionText:
                              hasTimerOnViewer && secondsLeftToTrigger > 0
                                  ? "Choose ($secondsLeftToTrigger)"
                                  : "Choose",
                          callback: () {
                            try {
                              _timer?.cancel();
                            } finally {
                              proceedWithViewer();
                            }
                          },
                        ),
                        OptionItemCardWidget(
                          title: "CONTROLLER",
                          description:
                              "Use this device to control demo session",
                          icon: Icons.settings_remote_sharp,
                          actionText:
                              hasTimerOnController && secondsLeftToTrigger > 0
                                  ? "Choose ($secondsLeftToTrigger)"
                                  : "Choose",
                          callback: () {
                            try {
                              _timer?.cancel();
                            } finally {
                              proceedWithController();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      });
    });
  }

  // Widget roleCard({
  //   required BuildContext context,
  //   required String title,
  //   required String description,
  //   required String actionText,
  //   required GestureTapCallback callback,
  //   required IconData icon,
  //   bool showTimer = false,
  // }) {
  //   return Card(
  //     elevation: 1,
  //     shape: RoundedRectangleBorder(borderRadius: UiDimens.c20),
  //     color: Theme.of(context).colorScheme.primaryContainer,
  //     margin: UiDimens.a20,
  //     child: Container(
  //       decoration: BoxDecoration(borderRadius: UiDimens.c20),
  //       padding: UiDimens.a20,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             title,
  //             style: Theme.of(context).textTheme.titleLarge,
  //           ),
  //           Divider(),
  //           Text(description),
  //           Gap(10),
  //           Container(
  //             alignment: Alignment.centerRight,
  //             child: ElevatedButton.icon(
  //               onPressed: callback,
  //               icon: Icon(icon),
  //               label: Text(actionText),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void runInitializer() {
    double w = Get.width;
    if (w > ScreenUtils.breakpointM) {
      if (mounted) setState(() => hasTimerOnViewer = true);
      startTimer();
    } else if (w < ScreenUtils.breakpointS) {
      if (mounted) setState(() => hasTimerOnController = true);
      startTimer();
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeftToTrigger > 0) {
        setState(() {
          secondsLeftToTrigger--;
        });
      } else {
        timer.cancel();
        if (hasTimerOnController) {
          proceedWithController();
        } else if (hasTimerOnViewer) {
          proceedWithViewer();
        }
      }
    });
  }

  void proceedWithViewer() {
    final DemoController dc = Get.find();
    dc.setDemoRole(DemoRole.viewer);
    Get.toNamed(Routes.demoViewer);
  }

  void proceedWithController() {
    final DemoController dc = Get.find();
    dc.setDemoRole(DemoRole.controller);
    Get.toNamed(Routes.demoController);
  }
}
