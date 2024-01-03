import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/mqtt.dart';
import 'package:heethings_demo/app/data/services/demo.dart';

class ControllerBoilerHardwareSetWidget extends StatelessWidget {
  final int initialIndex;
  const ControllerBoilerHardwareSetWidget({
    super.key,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Boiler Hardware"),
        ToggleButtons(
          borderRadius: UiDimens.c20,
          isSelected: [initialIndex == 0, initialIndex == 1],
          onPressed: (value) {
            final DemoController dc = Get.find();
            dc.broadcast(MqttTopic.boilerHardwareIndex, value);
          },
          children: const [Text("1986"), Text("2010")],
        ),
      ],
    );
  }
}
