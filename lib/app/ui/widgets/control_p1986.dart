import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/utils/demo.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/widgets/controller_boiler_info.dart';
import 'package:heethings_demo/app/ui/widgets/temperature_set_widget.dart';

class P1986ControlWidget extends StatelessWidget {
  const P1986ControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(builder: (dc) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Current:"),
              Text(
                DemoUtils.displayTemperature(dc.demo.currentRoomTemperature),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("SET: "),
              TemperatureSetterWidget(
                  temperature: dc.demo.p1986SetTemperature,
                  callback: (v) {
                    dc.setP1986SetTemperature(v);
                  }),
            ],
          ),
          const Divider(),
          const ControllerBoilerInfoWidget(),
        ],
      );
    });
  }
}
