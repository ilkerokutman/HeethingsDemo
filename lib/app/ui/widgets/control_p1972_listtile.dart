import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/utils/demo.dart';

class P1972ControlListTileWidget extends StatelessWidget {
  final int index;
  final int temperature;
  final bool selected;
  final GestureTapCallback callback;
  final bool dense;

  const P1972ControlListTileWidget({
    super.key,
    required this.index,
    required this.temperature,
    required this.selected,
    required this.callback,
    this.dense = true,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      onChanged: (v) {
        if (v == true) {
          callback();
        }
      },
      value: selected,
      selected: selected,
      title: Text(index == 0 ? "Average" : "Room $index"),
      subtitle: Text(DemoUtils.displayTemperature(temperature)),
      dense: dense,
    );
  }
}
