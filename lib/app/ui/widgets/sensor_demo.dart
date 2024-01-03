import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/mqtt.dart';
import 'package:heethings_demo/app/core/utils/demo.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/components/gap.dart';

class SensorDemoWidget extends StatelessWidget {
  const SensorDemoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(builder: (dc) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Click one of the sensors to activate"),
              const Gap(30),
              Wrap(
                spacing: UiDimens.buttonHeight,
                runSpacing: (UiDimens.buttonHeight / 4),
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  P1972SensorWidget(
                    index: 1,
                    degree: dc.demo.sensorP1972d1,
                    selected: dc.demo.sensorP1972s == 1,
                    callback: () => dc.broadcast(MqttTopic.sensorP1972Set0s, 1),
                  ),
                  P1972SensorWidget(
                    index: 2,
                    degree: dc.demo.sensorP1972d2,
                    selected: dc.demo.sensorP1972s == 2,
                    callback: () => dc.broadcast(MqttTopic.sensorP1972Set0s, 2),
                  ),
                  P1972SensorWidget(
                    index: 3,
                    degree: dc.demo.sensorP1972d3,
                    selected: dc.demo.sensorP1972s == 3,
                    callback: () => dc.broadcast(MqttTopic.sensorP1972Set0s, 3),
                  ),
                  P1972SensorWidget(
                    index: 0,
                    degree: ((dc.demo.sensorP1972d1 +
                                dc.demo.sensorP1972d2 +
                                dc.demo.sensorP1972d3) /
                            3)
                        .toPrecision(1)
                        .toInt(),
                    selected: dc.demo.sensorP1972s == 0,
                    callback: () => dc.broadcast(MqttTopic.sensorP1972Set0s, 0),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class P1972SensorWidget extends StatelessWidget {
  final int index;
  final int degree;
  final bool selected;
  final GestureTapCallback? callback;
  const P1972SensorWidget({
    super.key,
    required this.index,
    required this.degree,
    this.selected = false,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: UiDimens.c20,
        onTap: callback,
        child: Container(
          padding: UiDimens.a20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: UiDimens.c20,
                child: Image.asset("assets/images/p1972.png"),
              ),
              Text(index == 0 ? "Average" : "Sensor #$index"),
              Text(
                DemoUtils.displayTemperature(degree),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              selected
                  ? Text(
                      "Selected",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: UiColors.success, fontWeight: FontWeight.w800),
                    )
                  : Text(
                      "Passive",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: UiColors.black.withOpacity(0.3)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
