import 'package:flutter/material.dart';
import 'package:heethings_demo/app/ui/widgets/control_p1972.dart';
import 'package:heethings_demo/app/ui/widgets/control_p1975.dart';
import 'package:heethings_demo/app/ui/widgets/control_p1986.dart';
import 'package:heethings_demo/app/ui/widgets/room_hardware_tab.dart';

class ControllerRoomHardwareSetWidget extends StatefulWidget {
  final int initialIndex;
  const ControllerRoomHardwareSetWidget({
    super.key,
    required this.initialIndex,
  });

  @override
  State<ControllerRoomHardwareSetWidget> createState() =>
      _ControllerRoomHardwareSetWidgetState();
}

class _ControllerRoomHardwareSetWidgetState
    extends State<ControllerRoomHardwareSetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RoomHardwareTabWidget(initial: widget.initialIndex),
        const Divider(),
        widget.initialIndex == 0
            ? const P1986ControlWidget()
            : widget.initialIndex == 1
                ? const P1972ControlWidget()
                : const P1975ControlWidget(),
      ],
    );
  }
}
