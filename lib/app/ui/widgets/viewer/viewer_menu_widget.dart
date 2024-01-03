import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/enums.dart';
import 'package:heethings_demo/app/core/utils/screen.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/widgets/option_item.dart';

class ViewerMenuWidget extends StatelessWidget {
  const ViewerMenuWidget({
    super.key,
    required this.isMobile,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final DemoController dc = Get.find();
    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : ScreenUtils.breakpointS),
          padding: UiDimens.a40,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Choose Viewport",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Wrap(
                children: [
                  OptionItemCardWidget(
                    title: "HOME",
                    description:
                        "Demonstrates following products: 1986, 1972, 1975, 2010",
                    actionText: "Open Scenario",
                    callback: () {
                      dc.setDemoViewport(DemoViewport.home);
                    },
                    icon: Icons.home,
                  ),
                  OptionItemCardWidget(
                    title: "CAFE",
                    description: "Demonstrates following products: 1999, 1942",
                    actionText: "Open Scenario",
                    callback: () {
                      dc.setDemoViewport(DemoViewport.cafe);
                    },
                    icon: Icons.coffee,
                  ),
                  OptionItemCardWidget(
                    title: "FACTORY",
                    description:
                        "Demonstrates following products: 1994, 1999, 1942, 1995, 2000",
                    actionText: "Open Scenario",
                    callback: () {
                      dc.setDemoViewport(DemoViewport.factory);
                    },
                    icon: Icons.factory,
                  ),
                  OptionItemCardWidget(
                    title: "SENSOR",
                    description:
                        "Demonstrates communication with real Room Thermostat p1972",
                    actionText: "Open Scenario",
                    callback: () {
                      dc.setDemoViewport(DemoViewport.sensor);
                    },
                    icon: Icons.coffee,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
