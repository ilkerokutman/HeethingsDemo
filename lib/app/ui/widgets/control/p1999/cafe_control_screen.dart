import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/mqtt.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/widgets/control/common/control_listtile.dart';
import 'package:heethings_demo/app/ui/widgets/control/common/listtile_holder_content.dart';
import 'package:heethings_demo/app/ui/widgets/control/common/listtile_holder_title.dart';

class CafeControlWidget extends StatelessWidget {
  const CafeControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(
      builder: (dc) {
        const String asset = 'assets/images/cafe_level_{0}.png';

        const Color colorGarden = Color.fromRGBO(155, 112, 200, 1);
        return SingleChildScrollView(
          padding: UiDimens.h10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ControlListTileHolderTitleWidget(
                context: context,
                title: "Cafe Heaters",
                color: colorGarden,
              ),
              ControlListTileHolderContentWidget(
                context: context,
                color: colorGarden,
                children: [
                  ControlListTileWidget(
                    index: 1,
                    level: dc.demo.p1999z1d1,
                    callback: (v) => dc.broadcast(MqttTopic.p1999d1, v),
                    asset: asset,
                    valueHandler: () => dc.demo.p1999z1d1,
                  ),
                  ControlListTileWidget(
                    index: 2,
                    level: dc.demo.p1999z1d2,
                    callback: (v) => dc.broadcast(MqttTopic.p1999d2, v),
                    asset: asset,
                    valueHandler: () => dc.demo.p1999z1d2,
                  ),
                  ControlListTileWidget(
                    index: 3,
                    level: dc.demo.p1999z1d3,
                    callback: (v) => dc.broadcast(MqttTopic.p1999d3, v),
                    asset: asset,
                    valueHandler: () => dc.demo.p1999z1d3,
                  ),
                  ControlListTileWidget(
                    index: 0,
                    level: dc.demo.p1999Max,
                    callback: (v) {
                      dc.broadcast(MqttTopic.p1999d1, v);
                      dc.broadcast(MqttTopic.p1999d2, v);
                      dc.broadcast(MqttTopic.p1999d3, v);
                    },
                    asset: asset,
                    valueHandler: () => dc.demo.p1999Max,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
