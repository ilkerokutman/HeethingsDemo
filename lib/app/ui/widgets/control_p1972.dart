import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:heethings_demo/app/core/constants/mqtt.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/widgets/control_p1972_listtile.dart';
import 'package:heethings_demo/app/ui/widgets/controller_boiler_info.dart';
import 'package:heethings_demo/app/ui/widgets/temperature_set_widget.dart';

class P1972ControlWidget extends StatelessWidget {
  const P1972ControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(builder: (dc) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          P1972ControlListTileWidget(
            index: 1,
            temperature: dc.demo.room1CurrentTemperature,
            selected: dc.demo.p1972SelectedRoomIndex == 1,
            callback: () {
              dc.broadcast(MqttTopic.p1972SelectedRoomIndex, 1);
            },
            dense: false,
          ),
          P1972ControlListTileWidget(
            index: 2,
            temperature: dc.demo.room2CurrentTemperature,
            selected: dc.demo.p1972SelectedRoomIndex == 2,
            callback: () {
              dc.broadcast(MqttTopic.p1972SelectedRoomIndex, 2);
            },
            dense: false,
          ),
          P1972ControlListTileWidget(
            index: 3,
            temperature: dc.demo.room3CurrentTemperature,
            selected: dc.demo.p1972SelectedRoomIndex == 3,
            callback: () {
              dc.broadcast(MqttTopic.p1972SelectedRoomIndex, 3);
            },
            dense: false,
          ),
          P1972ControlListTileWidget(
            index: 0,
            temperature: dc.demo.averageCurrentTemperature,
            selected: dc.demo.p1972SelectedRoomIndex == 0,
            callback: () {
              dc.broadcast(MqttTopic.p1972SelectedRoomIndex, 0);
            },
            dense: false,
          ),
          const Divider(),
          TemperatureSetterWidget(
            temperature: dc.demo.p1972SetTemperature,
            callback: (v) {
              dc.setP1972SetTemperature(v);
            },
          ),
          const Divider(),
          const ControllerBoilerInfoWidget(),
        ],
      );
    });
  }
}
