import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/mqtt.dart';
import 'package:heethings_demo/app/data/services/demo.dart';

class RoomHardwareTabWidget extends StatelessWidget {
  final int initial;
  const RoomHardwareTabWidget({
    super.key,
    required this.initial,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Room Hardware"),
        ToggleButtons(
          borderRadius: UiDimens.c20,
          isSelected: [
            initial == 0,
            initial == 1,
            initial == 2,
          ],
          onPressed: (p) {
            final DemoController dc = Get.find();
            dc.broadcast(MqttTopic.roomHardwareIndex, p);
          },
          children: const [
            Text("1986"),
            Text("1972"),
            Text("1975"),
          ],
        ),
      ],
    );
  }
}
