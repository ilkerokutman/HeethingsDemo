import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/widgets/controller_boiler_hardware.dart';
import 'package:heethings_demo/app/ui/widgets/controller_room_hardware.dart';

class HomeControlWidget extends StatelessWidget {
  const HomeControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(
      builder: (dc) {
        return SingleChildScrollView(
          padding: UiDimens.h20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: Text("t"),
              ),
            ],
          ),

          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Text(
          //       "Home Controller",
          //       style: Theme.of(context).textTheme.titleLarge,
          //     ),
          //     const Divider(),
          //     ControllerBoilerHardwareSetWidget(
          //       initialIndex: dc.demo.demoBoilerHardwareIndex,
          //     ),
          //     const Divider(),
          //     ControllerRoomHardwareSetWidget(
          //       initialIndex: dc.demo.demoRoomHardwareIndex,
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}
