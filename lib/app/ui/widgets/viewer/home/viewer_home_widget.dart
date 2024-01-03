import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/enums.dart';
import 'package:heethings_demo/app/core/utils/demo.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/widgets/airflow.dart';
import 'package:heethings_demo/app/ui/widgets/hardware_set_panel.dart';
import 'package:heethings_demo/app/ui/widgets/p1972_sensor.dart';
import 'package:heethings_demo/app/ui/widgets/p1975_sensor.dart';
import 'package:heethings_demo/app/ui/widgets/p1986_hardware.dart';
import 'package:heethings_demo/app/ui/widgets/p1986_sensor.dart';
import 'package:heethings_demo/app/ui/widgets/viewer/home/background.dart';

class ViewerHomeWidget extends StatelessWidget {
  const ViewerHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(builder: (dc) {
      return Stack(
        children: [
          const ViewerHomeSceneBackground(),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: UiDimens.a20,
              child: AspectRatio(
                aspectRatio: 1213 / 999,
                child: LayoutBuilder(builder: (_, c) {
                  double width = c.maxWidth;
                  double ratio = width / 1213;
                  return Stack(
                    children: [
                      // background
                      const ViewerHomeLayoutBackground(),

                      ///
                      ///
                      /// 1975
                      ///
                      ///
                      // 1975 valve 1
                      if (dc.demo.demoRoomHardwareIndex == DemoRoomHardwareSet.p1975.index)
                        Align(
                          alignment: const Alignment(0.298, -0.43),
                          child: P1975SensorWidget(
                            level: dc.demo.p1975room1ValveStatus,
                            zoom: ratio,
                          ),
                        ),
                      // 1975 valve 2
                      if (dc.demo.demoRoomHardwareIndex == DemoRoomHardwareSet.p1975.index)
                        Align(
                          alignment: const Alignment(0.468, 0.12),
                          child: P1975SensorWidget(
                            level: dc.demo.p1975room2ValveStatus,
                            zoom: ratio,
                          ),
                        ),
                      // 1975 valve 3
                      if (dc.demo.demoRoomHardwareIndex == DemoRoomHardwareSet.p1975.index)
                        Align(
                          alignment: const Alignment(-0.273, 0.12),
                          child: P1975SensorWidget(
                            level: dc.demo.p1975room3ValveStatus,
                            zoom: ratio,
                          ),
                        ),

                      ///
                      ///
                      /// 1986
                      ///
                      ///
                      // 1986 thermostat 1
                      if (dc.demo.demoRoomHardwareIndex == DemoRoomHardwareSet.p1986.index &&
                          dc.demo.p1986SelectedRoomIndex == 1)
                        Align(
                          alignment: const Alignment(-0.39, -0.52),
                          child: P1986SensorWidget(
                            zoom: ratio,
                          ),
                        ),
                      // 1986 thermostat 2
                      if (dc.demo.demoRoomHardwareIndex == DemoRoomHardwareSet.p1986.index &&
                          dc.demo.p1986SelectedRoomIndex == 2)
                        Align(
                          alignment: const Alignment(0.886, 0.174),
                          child: P1986SensorWidget(
                            zoom: ratio,
                          ),
                        ),
                      // 1986 thermostat 3
                      if (dc.demo.demoRoomHardwareIndex == DemoRoomHardwareSet.p1986.index &&
                          dc.demo.p1986SelectedRoomIndex == 3)
                        Align(
                          alignment: const Alignment(-0.82, 0.18),
                          child: P1986SensorWidget(
                            zoom: ratio,
                          ),
                        ),
                      // 1986 device
                      if (dc.demo.demoBoilerHardwareIndex == DemoBoilerHardwareSet.p1986.index)
                        Align(
                          alignment: const Alignment(0.843, 0.668),
                          child: P1986HardwareWidget(zoom: ratio),
                        ),

                      ///
                      ///
                      /// 1972
                      ///
                      ///
                      // 1972 sensor 1
                      if (dc.demo.demoRoomHardwareIndex == DemoRoomHardwareSet.p1972.index)
                        Align(
                          alignment: const Alignment(-0.38, -0.47),
                          child: P1972SensorWidget(
                            index: 1,
                            zoom: ratio,
                            active: dc.demo.p1972SelectedRoomIndex == 1 ||
                                dc.demo.p1972SelectedRoomIndex == 0,
                          ),
                        ),
                      // 1972 sensor 2
                      if (dc.demo.demoRoomHardwareIndex == DemoRoomHardwareSet.p1972.index)
                        Align(
                          alignment: const Alignment(0.866, 0.184),
                          child: P1972SensorWidget(
                            index: 2,
                            zoom: ratio,
                            active: dc.demo.p1972SelectedRoomIndex == 2 ||
                                dc.demo.p1972SelectedRoomIndex == 0,
                          ),
                        ),
                      // 1972 sensor 3
                      if (dc.demo.demoRoomHardwareIndex == DemoRoomHardwareSet.p1972.index)
                        Align(
                          alignment: const Alignment(-0.782, -0.06),
                          child: P1972SensorWidget(
                            index: 3,
                            zoom: ratio,
                            active: dc.demo.p1972SelectedRoomIndex == 3 ||
                                dc.demo.p1972SelectedRoomIndex == 0,
                          ),
                        ),

                      ///
                      ///
                      /// LABEL
                      ///
                      ///
                      // label room 1
                      Align(
                        alignment: const Alignment(0.273, -0.7),
                        child: SizedBox(
                          width: 74 * ratio,
                          height: 70 * ratio,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Room 1",
                                  textScaler: TextScaler.linear(ratio),
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  DemoUtils.displayTemperature(dc.demo.room1CurrentTemperature)
                                      .replaceAll("C", ""),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  textScaler: TextScaler.linear(ratio),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // label room 2
                      Align(
                        alignment: const Alignment(0.270, -0.17),
                        child: SizedBox(
                          width: 74 * ratio,
                          height: 70 * ratio,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Room 2",
                                  textScaler: TextScaler.linear(ratio),
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  DemoUtils.displayTemperature(dc.demo.room2CurrentTemperature)
                                      .replaceAll("C", ""),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  textScaler: TextScaler.linear(ratio),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // label room 3
                      Align(
                        alignment: const Alignment(-0.582, -0.17),
                        child: SizedBox(
                          width: 74 * ratio,
                          height: 70 * ratio,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Room 3",
                                  textScaler: TextScaler.linear(ratio),
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  DemoUtils.displayTemperature(dc.demo.room3CurrentTemperature)
                                      .replaceAll("C", ""),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  textScaler: TextScaler.linear(ratio),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      ///
                      ///
                      /// FLAME
                      ///
                      ///
                      // boiler flame
                      if (dc.demo.boilerIndicator == 1)
                        Align(
                          alignment: const Alignment(0.9, 0.55),
                          child: Container(
                            width: 40 * ratio,
                            height: 40 * ratio,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20 * ratio),
                              color: Colors.orange.withOpacity(0.9),
                            ),
                          ),
                        ),

                      ///
                      ///
                      /// AIRFLOW
                      ///
                      ///
                      // airflow 1
                      if (((dc.demo.demoRoomHardwareIndex == 2 &&
                                  dc.demo.p1975room1ValveStatus == 1) ||
                              (dc.demo.demoRoomHardwareIndex != 2)) &&
                          dc.demo.boilerIndicator == 1 &&
                          dc.demo.boilerStatus == 1 &&
                          dc.demo.boilerMode == 1)
                        Align(
                          alignment: const Alignment(0.09, -0.51),
                          child: AirFlowWidget(index: 1, zoom: ratio),
                        ),
                      // airflow 2
                      if (((dc.demo.demoRoomHardwareIndex == 2 &&
                                  (dc.demo.p1975room2ValveStatus == 1)) ||
                              (dc.demo.demoRoomHardwareIndex != 2)) &&
                          dc.demo.boilerIndicator == 1 &&
                          dc.demo.boilerStatus == 1 &&
                          dc.demo.boilerMode == 1)
                        Align(
                          alignment: const Alignment(0.29, 0),
                          child: AirFlowWidget(index: 2, zoom: ratio),
                        ),
                      // airflow 3
                      if (((dc.demo.demoRoomHardwareIndex == 2 &&
                                  dc.demo.p1975room3ValveStatus == 1) ||
                              (dc.demo.demoRoomHardwareIndex != 2)) &&
                          dc.demo.boilerIndicator == 1 &&
                          dc.demo.boilerStatus == 1 &&
                          dc.demo.boilerMode == 1)
                        Align(
                          alignment: const Alignment(-0.41, 0),
                          child: AirFlowWidget(index: 3, zoom: ratio),
                        ),
                    ],
                  );
                }),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 260,
              padding: UiDimens.b70,
              margin: UiDimens.a20,
              child: const Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: HardwareSetPanel(),
                  ),
                ],
              ),
            ),
          ),
          // ,
        ],
      );
    });
  }
}
