import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/mqtt.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/components/gap.dart';

class ControllerBoilerInfoWidget extends StatelessWidget {
  const ControllerBoilerInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(builder: (dc) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Boiler Status"),
              ToggleButtons(
                borderRadius: UiDimens.c20,
                isSelected: [
                  dc.demo.boilerStatus == 0,
                  dc.demo.boilerStatus == 1,
                ],
                onPressed: (value) {
                  dc.broadcast(MqttTopic.boilerStatus, value);
                },
                children: const [
                  Text("OFF"),
                  Text("ON"),
                ],
              ),
            ],
          ),
          const Gap(10),
          if (dc.demo.boilerStatus == 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Boiler Mode"),
                ToggleButtons(
                  borderRadius: UiDimens.c20,
                  isSelected: [
                    dc.demo.boilerMode == 0,
                    dc.demo.boilerMode == 1,
                  ],
                  onPressed: (value) {
                    dc.broadcast(MqttTopic.boilerMode, value);
                  },
                  children: const [
                    Text("Summer"),
                    Text("Winter"),
                  ],
                ),
              ],
            ),
          const Gap(10),
          if (dc.demo.boilerStatus == 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dc.demo.boilerIndicator == 1 ? "1.6 bar" : "1.0 bar"),
                CircleAvatar(
                  backgroundColor: dc.demo.boilerIndicator == 1
                      ? Colors.orange
                      : Colors.grey.withOpacity(0.7),
                ),
              ],
            ),
        ],
      );
    });
  }
}
