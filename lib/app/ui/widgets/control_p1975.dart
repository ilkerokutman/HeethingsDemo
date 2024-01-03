import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';
import 'package:heethings_demo/app/core/utils/demo.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/components/gap.dart';
import 'package:heethings_demo/app/ui/widgets/controller_boiler_info.dart';
import 'package:heethings_demo/app/ui/widgets/temperature_set_widget.dart';

class P1975ControlWidget extends StatelessWidget {
  const P1975ControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(builder: (dc) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Room 1"),
              TemperatureSetterWidget(
                temperature: dc.demo.p1975d1SetTemperature,
                callback: (v) {
                  dc.setP1975SetTemperature(roomIndex: 1, value: v);
                },
              ),
              Chip(
                backgroundColor: dc.demo.p1975room1ValveStatus == 0
                    ? UiColors.danger.withOpacity(0.2)
                    : UiColors.success.withOpacity(0.2),
                label: Text(
                  DemoUtils.displayTemperature(dc.demo.room1CurrentTemperature),
                ),
              ),
            ],
          ),
          const Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Room 2"),
              TemperatureSetterWidget(
                temperature: dc.demo.p1975d2SetTemperature,
                callback: (v) {
                  dc.setP1975SetTemperature(roomIndex: 2, value: v);
                },
              ),
              Chip(
                backgroundColor: dc.demo.p1975room2ValveStatus == 0
                    ? UiColors.danger.withOpacity(0.2)
                    : UiColors.success.withOpacity(0.2),
                label: Text(
                  DemoUtils.displayTemperature(dc.demo.room2CurrentTemperature),
                ),
              ),
            ],
          ),
          const Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Room 3"),
              TemperatureSetterWidget(
                temperature: dc.demo.p1975d3SetTemperature,
                callback: (v) {
                  dc.setP1975SetTemperature(roomIndex: 3, value: v);
                },
              ),
              Chip(
                backgroundColor: dc.demo.p1975room3ValveStatus == 0
                    ? UiColors.danger.withOpacity(0.2)
                    : UiColors.success.withOpacity(0.2),
                label: Text(
                  DemoUtils.displayTemperature(dc.demo.room3CurrentTemperature),
                ),
              ),
            ],
          ),
          const Divider(),
          const ControllerBoilerInfoWidget(),
        ],
      );
    });
  }
}
