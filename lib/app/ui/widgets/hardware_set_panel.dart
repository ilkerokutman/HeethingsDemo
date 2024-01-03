import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/core/constants/mqtt.dart';
import 'package:heethings_demo/app/core/utils/demo.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/components/gap.dart';
import 'package:heethings_demo/app/ui/widgets/control_p1972_listtile.dart';
import 'package:heethings_demo/app/ui/widgets/temperature_set_widget.dart';

class HardwareSetPanel extends StatelessWidget {
  const HardwareSetPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(
      builder: (dc) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: UiDimens.a10,
                decoration: BoxDecoration(
                  borderRadius: UiDimens.c20,
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Boiler\nHardware"),
                    ToggleButtons(
                      borderRadius: UiDimens.c20,
                      isSelected: [dc.demo.demoBoilerHardwareIndex == 0, dc.demo.demoBoilerHardwareIndex == 1],
                      onPressed: (value) {
                        dc.broadcast(MqttTopic.boilerHardwareIndex, value);
                      },
                      children: const [Text("1986"), Text("2010")],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                padding: UiDimens.a10,
                decoration: BoxDecoration(
                  borderRadius: UiDimens.c20,
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Room\nHardware"),
                    ToggleButtons(
                      borderRadius: UiDimens.c20,
                      isSelected: [
                        dc.demo.demoRoomHardwareIndex == 0,
                        dc.demo.demoRoomHardwareIndex == 1,
                        dc.demo.demoRoomHardwareIndex == 2,
                      ],
                      onPressed: (value) {
                        dc.broadcast(MqttTopic.roomHardwareIndex, value);
                      },
                      children: const [Text("1986"), Text("1972"), Text("1975")],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                padding: UiDimens.a10,
                decoration: BoxDecoration(
                  borderRadius: UiDimens.c20,
                  color: Colors.white,
                ),
                child: dc.demo.demoRoomHardwareIndex == 0
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Current:"),
                              Text(
                                DemoUtils.displayTemperature(dc.demo.currentRoomTemperature),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Set:"),
                              TemperatureSetterWidget(
                                temperature: dc.demo.p1986SetTemperature,
                                callback: (value) {
                                  dc.broadcast(MqttTopic.p1986SetTemperature, value);
                                },
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Move\nThermostat\nto Room"),
                              ToggleButtons(
                                borderRadius: UiDimens.c20,
                                isSelected: [
                                  dc.demo.p1986SelectedRoomIndex == 1,
                                  dc.demo.p1986SelectedRoomIndex == 2,
                                  dc.demo.p1986SelectedRoomIndex == 3,
                                ],
                                onPressed: (value) {
                                  dc.broadcast(MqttTopic.p1986SelectedRoomIndex, value + 1);
                                },
                                children: const [Text("1"), Text("2"), Text("3")],
                              )
                            ],
                          ),
                        ],
                      )
                    : dc.demo.demoRoomHardwareIndex == 1
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              P1972ControlListTileWidget(
                                index: 1,
                                temperature: dc.demo.room1CurrentTemperature,
                                selected: dc.demo.p1972SelectedRoomIndex == 1,
                                callback: () {
                                  dc.broadcast(MqttTopic.p1972SelectedRoomIndex, 1);
                                },
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
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Room 1"),
                                      Chip(
                                        backgroundColor:
                                            dc.demo.p1975room1ValveStatus == 0 ? UiColors.danger.withOpacity(0.2) : UiColors.success.withOpacity(0.2),
                                        label: Text(
                                          DemoUtils.displayTemperature(dc.demo.room1CurrentTemperature),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TemperatureSetterWidget(
                                    temperature: dc.demo.p1975d1SetTemperature,
                                    callback: (v) {
                                      dc.setP1975SetTemperature(roomIndex: 1, value: v);
                                    },
                                  ),
                                ],
                              ),
                              const Gap(30),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Room 2"),
                                      Chip(
                                        backgroundColor:
                                            dc.demo.p1975room2ValveStatus == 0 ? UiColors.danger.withOpacity(0.2) : UiColors.success.withOpacity(0.2),
                                        label: Text(
                                          DemoUtils.displayTemperature(dc.demo.room2CurrentTemperature),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TemperatureSetterWidget(
                                    temperature: dc.demo.p1975d2SetTemperature,
                                    callback: (v) {
                                      dc.setP1975SetTemperature(roomIndex: 2, value: v);
                                    },
                                  ),
                                ],
                              ),
                              const Gap(30),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Room 3"),
                                      Chip(
                                        backgroundColor:
                                            dc.demo.p1975room3ValveStatus == 0 ? UiColors.danger.withOpacity(0.2) : UiColors.success.withOpacity(0.2),
                                        label: Text(
                                          DemoUtils.displayTemperature(dc.demo.room3CurrentTemperature),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TemperatureSetterWidget(
                                    temperature: dc.demo.p1975d3SetTemperature,
                                    callback: (v) {
                                      dc.setP1975SetTemperature(roomIndex: 3, value: v);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
              ),
              const Divider(),
              Container(
                  padding: UiDimens.a10,
                  decoration: BoxDecoration(
                    borderRadius: UiDimens.c20,
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Boiler\nStatus"),
                          ToggleButtons(
                            borderRadius: UiDimens.c20,
                            isSelected: [dc.demo.boilerStatus == 0, dc.demo.boilerStatus == 1],
                            onPressed: (value) {
                              dc.broadcast(MqttTopic.boilerStatus, value);
                            },
                            children: const [Text("OFF"), Text("ON")],
                          )
                        ],
                      ),
                      if (dc.demo.boilerStatus == 1) const Gap(20),
                      if (dc.demo.boilerStatus == 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Boiler\nMode"),
                            ToggleButtons(
                              borderRadius: UiDimens.c20,
                              isSelected: [dc.demo.boilerMode == 0, dc.demo.boilerMode == 1],
                              onPressed: (value) {
                                dc.broadcast(MqttTopic.boilerMode, value);
                              },
                              children: const [Icon(Icons.sunny), Icon(Icons.ac_unit)],
                            )
                          ],
                        ),
                      if (dc.demo.boilerStatus == 1) const Gap(20),
                      if (dc.demo.boilerStatus == 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dc.demo.boilerIndicator == 0 ? '1.0 bar' : '1.6 bar'),
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: dc.demo.boilerIndicator == 0 ? Colors.grey : Colors.orange,
                            )
                          ],
                        )
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }
}

// class HardwareSetPanel extends StatefulWidget {
//   final int initialBoilerHardwareIndex;
//   const HardwareSetPanel({
//     super.key,
//     required this.initialBoilerHardwareIndex,
//   });

//   @override
//   State<HardwareSetPanel> createState() => _HardwareSetPanelState();
// }

// class _HardwareSetPanelState extends State<HardwareSetPanel> {
//   final DemoController demoController = Get.find();
//   late PageController boilerController;
//   late PageController hardwareController;

//   @override
//   void initState() {
//     super.initState();
//     boilerController = PageController(
//       initialPage: widget.initialBoilerHardwareIndex,
//     );
//     hardwareController = PageController(
//       initialPage: demoController.demo.demoRoomHardwareIndex,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<DemoController>(builder: (dc) {
//       return Container(
//         decoration: BoxDecoration(
//           borderRadius: UiDimens.c20,
//         ),
//         child: ClipRRect(
//           borderRadius: UiDimens.c20,
//           child: SingleChildScrollView(
//               child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [

//               // title("Boiler Set"),
//               // content(
//               //   height: 100,
//               //   child: PageView(
//               //     controller: boilerController,
//               //     onPageChanged: (p) {
//               //       demoController.setBoilerHardwareIndex(p);
//               //     },
//               //     children: [
//               //       Center(
//               //         child: Text(
//               //           "1986",
//               //           style: Theme.of(context).textTheme.headlineLarge,
//               //         ),
//               //       ),
//               //       Center(
//               //         child: Text(
//               //           "2010",
//               //           style: Theme.of(context).textTheme.headlineLarge,
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               title("Hardware Set"),
//               content(
//                 child: PageView(
//                   controller: hardwareController,
//                   onPageChanged: (p) {
//                     demoController.setRoomHardwareIndex(p);
//                   },
//                   children: [
//                     //1986
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Center(
//                           child: Text(
//                             "1986",
//                             style: Theme.of(context).textTheme.headlineLarge,
//                           ),
//                         ),
//                         AspectRatio(
//                             aspectRatio: 1,
//                             child: Stack(
//                               children: [
//                                 Image.asset(
//                                   'assets/images/thermostat_display.png',
//                                   fit: BoxFit.contain,
//                                 ),
//                                 Align(
//                                   alignment: const Alignment(0, 0.1),
//                                   child: Container(
//                                     margin: UiDimens.h20,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         const Icon(
//                                           Icons.home,
//                                           color: Colors.cyan,
//                                         ),
//                                         Text(
//                                           DemoUtils.displayTemperature(
//                                               dc.demo.p1986SetTemperature),
//                                           style: const TextStyle(
//                                               color: Colors.cyan, fontSize: 24),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: const Alignment(0, -0.4),
//                                   child: Container(
//                                     margin: UiDimens.h20,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         const Icon(
//                                           Icons.thermostat,
//                                           color: Colors.cyan,
//                                         ),
//                                         const Gap(3),
//                                         Text(
//                                           DemoUtils.displayTemperature(
//                                               dc.demo.currentRoomTemperature),
//                                           style: const TextStyle(
//                                               color: Colors.cyan, fontSize: 20),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: const Alignment(-0.5, 0.8),
//                                   child: IconButton(
//                                     icon: const Icon(Icons.remove),
//                                     onPressed: () {
//                                       dc.setP1986SetTemperature(
//                                           dc.demo.p1986SetTemperature - 1);
//                                     },
//                                     // color: UiColors.black,
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: const Alignment(0.5, 0.8),
//                                   child: IconButton(
//                                     icon: const Icon(Icons.add),
//                                     onPressed: () {
//                                       dc.setP1986SetTemperature(
//                                           dc.demo.p1986SetTemperature + 1);
//                                     },
//                                     // color: UiColors.black,
//                                   ),
//                                 ),
//                               ],
//                             )),
//                         const Divider(),
//                         const Text("Move Thermostat to Room"),
//                         ToggleButtons(
//                           onPressed: (p) {
//                             demoController.setP1986SelectedRoomIndex(p + 1);
//                           },
//                           isSelected: [
//                             dc.demo.p1986SelectedRoomIndex == 1,
//                             dc.demo.p1986SelectedRoomIndex == 2,
//                             dc.demo.p1986SelectedRoomIndex == 3
//                           ],
//                           children: const [
//                             Text("1"),
//                             Text("2"),
//                             Text("3"),
//                           ],
//                         ),
//                       ],
//                     ),
//                     //1972
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Center(
//                           child: Text(
//                             "1972",
//                             style: Theme.of(context).textTheme.headlineLarge,
//                           ),
//                         ),
//                         const Divider(),
//                         P1972ControlListTileWidget(
//                             index: 1,
//                             temperature: dc.demo.room1CurrentTemperature,
//                             selected: dc.demo.p1972SelectedRoomIndex == 1,
//                             callback: () => dc.setP1972SelectedIndex(1)),
//                         P1972ControlListTileWidget(
//                             index: 2,
//                             temperature: dc.demo.room2CurrentTemperature,
//                             selected: dc.demo.p1972SelectedRoomIndex == 2,
//                             callback: () => dc.setP1972SelectedIndex(2)),
//                         P1972ControlListTileWidget(
//                             index: 3,
//                             temperature: dc.demo.room3CurrentTemperature,
//                             selected: dc.demo.p1972SelectedRoomIndex == 3,
//                             callback: () => dc.setP1972SelectedIndex(3)),
//                         P1972ControlListTileWidget(
//                             index: 0,
//                             temperature: dc.demo.averageCurrentTemperature,
//                             selected: dc.demo.p1972SelectedRoomIndex == 0,
//                             callback: () => dc.setP1972SelectedIndex(0)),
//                         const Divider(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             IconButton(
//                                 onPressed: () => dc.setP1972SetTemperature(
//                                     dc.demo.p1972SetTemperature - 1),
//                                 icon: const Icon(Icons.remove)),
//                             Text(DemoUtils.displayTemperature(
//                                 dc.demo.p1972SetTemperature)),
//                             IconButton(
//                                 onPressed: () => dc.setP1972SetTemperature(
//                                     dc.demo.p1972SetTemperature + 1),
//                                 icon: const Icon(Icons.add)),
//                           ],
//                         ),
//                       ],
//                     ),
//                     //1975
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Center(
//                           child: Text(
//                             "1975",
//                             style: Theme.of(context).textTheme.headlineLarge,
//                           ),
//                         ),
//                         const Divider(),
//                         p1975ListTile(
//                           index: 1,
//                           setTemperature: dc.demo.p1975d1SetTemperature,
//                           callback: (i) {
//                             dc.setP1975SetTemperature(roomIndex: 1, value: i);
//                           },
//                         ),
//                         p1975ListTile(
//                           index: 2,
//                           setTemperature: dc.demo.p1975d2SetTemperature,
//                           callback: (i) {
//                             dc.setP1975SetTemperature(roomIndex: 2, value: i);
//                           },
//                         ),
//                         p1975ListTile(
//                           index: 3,
//                           setTemperature: dc.demo.p1975d3SetTemperature,
//                           callback: (i) {
//                             dc.setP1975SetTemperature(roomIndex: 3, value: i);
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )),
//         ),
//       );
//     });
//   }

//   Widget title(String text) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         color: Theme.of(context).primaryColor,
//       ),
//       padding: UiDimens.a10,
//       width: double.infinity,
//       child: Text(
//         text,
//         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//               color: UiColors.white,
//             ),
//       ),
//     );
//   }

//   Widget content({required Widget child, double? height}) {
//     return Container(
//       margin: UiDimens.b10,
//       width: double.infinity,
//       height: height,
//       constraints: BoxConstraints(
//         maxHeight: height == null ? 400 : double.infinity,
//       ),
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//         ),
//         color: UiColors.white,
//       ),
//       child: child,
//     );
//   }

//   Widget p1975ListTile(
//       {required int index,
//       required int setTemperature,
//       required Function(int) callback}) {
//     return ListTile(
//       title: Text("Room $index"),
//       subtitle: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.remove),
//             onPressed: () {
//               callback(setTemperature - 1);
//             },
//           ),
//           Text(DemoUtils.displayTemperature(setTemperature)),
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () {
//               callback(setTemperature + 1);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
