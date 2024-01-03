import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/mqtt.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/widgets/control/common/control_listtile.dart';
import 'package:heethings_demo/app/ui/widgets/control/common/listtile_holder_content.dart';
import 'package:heethings_demo/app/ui/widgets/control/common/listtile_holder_title.dart';

class FactoryControlWidget extends StatelessWidget {
  const FactoryControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(
      builder: (dc) {
        const String assetProduction =
            'assets/images/production_2_level_{0}.png';
        const String assetFoodCourt =
            'assets/images/food_court_2_level_{0}.png';
        const String assetGarden = 'assets/images/garden_level_{0}.png';
        const Color colorProduction = Color.fromRGBO(112, 155, 200, 1);
        const Color colorFoodCourt = Color.fromRGBO(200, 112, 155, 1);
        const Color colorGarden = Color.fromRGBO(155, 112, 200, 1);
        return SingleChildScrollView(
          padding: UiDimens.h10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ControlListTileHolderTitleWidget(
                  context: context,
                  title: "Production",
                  color: colorProduction),
              ControlListTileHolderContentWidget(
                  context: context,
                  color: colorProduction,
                  children: [
                    ControlListTileWidget(
                      index: 1,
                      level: dc.demo.p1994z1d1,
                      callback: (v) => dc.broadcast(MqttTopic.p1994z1d1, v),
                      asset: assetProduction,
                      valueHandler: () => dc.demo.p1994z1d1,
                      tagPrefix: 'production_',
                    ),
                    ControlListTileWidget(
                      index: 2,
                      level: dc.demo.p1994z1d2,
                      callback: (v) => dc.broadcast(MqttTopic.p1994z1d2, v),
                      asset: assetProduction,
                      valueHandler: () => dc.demo.p1994z1d2,
                      tagPrefix: 'production_',
                    ),
                    ControlListTileWidget(
                      index: 3,
                      level: dc.demo.p1994z1d3,
                      callback: (v) => dc.broadcast(MqttTopic.p1994z1d3, v),
                      asset: assetProduction,
                      valueHandler: () => dc.demo.p1994z1d3,
                      tagPrefix: 'production_',
                    ),
                    ControlListTileWidget(
                      index: 0,
                      level: dc.demo.p1994z1Max,
                      callback: (v) {
                        dc.broadcast(MqttTopic.p1994z1d1, v);
                        dc.broadcast(MqttTopic.p1994z1d2, v);
                        dc.broadcast(MqttTopic.p1994z1d3, v);
                      },
                      asset: assetProduction,
                      valueHandler: () => dc.demo.p1994z1Max,
                      tagPrefix: 'production_',
                    ),
                  ]),
              ControlListTileHolderTitleWidget(
                  context: context, title: "Food Court", color: colorFoodCourt),
              ControlListTileHolderContentWidget(
                  context: context,
                  color: colorFoodCourt,
                  children: [
                    ControlListTileWidget(
                      index: 1,
                      level: dc.demo.p1994z2d1,
                      callback: (v) => dc.broadcast(MqttTopic.p1994z2d1, v),
                      asset: assetFoodCourt,
                      valueHandler: () => dc.demo.p1994z2d1,
                      tagPrefix: 'foodCourt_',
                    ),
                    ControlListTileWidget(
                      index: 2,
                      level: dc.demo.p1994z2d2,
                      callback: (v) => dc.broadcast(MqttTopic.p1994z2d2, v),
                      asset: assetFoodCourt,
                      valueHandler: () => dc.demo.p1994z2d2,
                      tagPrefix: 'foodCourt_',
                    ),
                    ControlListTileWidget(
                      index: 0,
                      level: dc.demo.p1994z2Max,
                      callback: (v) {
                        dc.broadcast(MqttTopic.p1994z2d1, v);
                        dc.broadcast(MqttTopic.p1994z2d2, v);
                      },
                      asset: assetFoodCourt,
                      valueHandler: () => dc.demo.p1994z2Max,
                      tagPrefix: 'foodCourt_',
                    ),
                  ]),
              ControlListTileHolderTitleWidget(
                  context: context, title: "Garden", color: colorGarden),
              ControlListTileHolderContentWidget(
                  context: context,
                  color: colorGarden,
                  children: [
                    ControlListTileWidget(
                      index: 1,
                      level: dc.demo.p1994z3d1,
                      callback: (v) => dc.broadcast(MqttTopic.p1994z3d1, v),
                      asset: assetGarden,
                      valueHandler: () => dc.demo.p1994z3d1,
                      tagPrefix: 'garden_',
                    ),
                  ]),
              Container(
                width: double.infinity,
                height: 80,
                margin: UiDimens.a40,
                child: ElevatedButton(
                  onPressed: () {
                    dc.broadcast(MqttTopic.p1994z1d1, 0);
                    dc.broadcast(MqttTopic.p1994z1d2, 0);
                    dc.broadcast(MqttTopic.p1994z1d3, 0);
                    dc.broadcast(MqttTopic.p1994z2d1, 0);
                    dc.broadcast(MqttTopic.p1994z2d2, 0);
                    dc.broadcast(MqttTopic.p1994z3d1, 0);
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: const Text("Emergency Shutdown"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
