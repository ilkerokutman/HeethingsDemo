import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/enums.dart';
import 'package:heethings_demo/app/core/utils/screen.dart';
import 'package:heethings_demo/app/data/routes/routes.dart';
import 'package:heethings_demo/app/data/services/app.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/components/appbutton.dart';
import 'package:heethings_demo/app/ui/components/appcard.dart';
import 'package:heethings_demo/app/ui/components/gap.dart';
import 'package:heethings_demo/app/ui/widgets/logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GetBuilder<DemoController>(builder: (dc) {
        ScreenSize screenSize = ScreenUtils.screenSize(constraints);
        double? cardWidth;
        double? aspectRatio;
        EdgeInsets? margin;
        switch (screenSize) {
          case ScreenSize.xxl:
            cardWidth = math.min(ScreenUtils.breakpointS,
                math.max(constraints.maxWidth / 2.6, 300));
            // aspectRatio = 1.3;
            margin = null;
            break;
          case ScreenSize.xl:
            cardWidth = math.min(ScreenUtils.breakpointS,
                math.max(constraints.maxWidth / 2, 300));
            //   aspectRatio = 1.2;
            margin = null;
            break;
          case ScreenSize.l:
            cardWidth = math.min(ScreenUtils.breakpointS,
                math.max(constraints.maxWidth / 2, 300));
            aspectRatio = null;
            margin = null;
            break;
          case ScreenSize.m:
            cardWidth = constraints.maxWidth - 120;
            aspectRatio = null;
            margin = null;
            break;
          case ScreenSize.s:
            cardWidth = null;
            aspectRatio = null;
            margin = UiDimens.a40;
            break;

          case ScreenSize.xs:
            cardWidth = null;
            aspectRatio = null;
            margin = UiDimens.a20;
            break;
          default:
            cardWidth = constraints.maxWidth - 60;
            aspectRatio = null;
            margin = UiDimens.a20;
            break;
        }

        return Scaffold(
          appBar: AppBar(
            title: const LogoWidget(),
            centerTitle: true,
          ),
          body: Center(
            child: AppCardWidget(
              width: cardWidth,
              aspectRatio: aspectRatio,
              margin: margin,
              header: Text(
                "Heethings Demo",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: UiColors.white),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to the demonstration of the Heethings IoT Products communication.\n\n"
                    "You will need two devices, one with the viewer role, and the other one with the controller role, to experience the demo.\n\n"
                    "Start new session with your first device, than continue the same session with your second device.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Gap(20),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: UiDimens.buttonHeight / 3,
                      spacing: UiDimens.buttonHeight,
                      children: [
                        AppButton(
                          callback: () => Future.delayed(Duration.zero,
                              () => Get.toNamed(Routes.existingDemoSession)),
                          title: "Continue Existing Demo Session",
                        ),
                        AppButton(
                          callback: () async {
                            final AppController ac = Get.find();
                            final String demoId =
                                await ac.startNewDemoSession();
                            log("new demoId: $demoId");
                            Future.delayed(Duration.zero,
                                () => Get.toNamed(Routes.connecting));
                          },
                          title: "Start New Demo Session",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
