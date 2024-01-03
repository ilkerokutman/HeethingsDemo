import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';

class LevelControlWidget extends StatelessWidget {
  const LevelControlWidget({
    super.key,
    this.title,
    required this.index,
    required this.value,
    required this.callback,
  });
  final String? title;
  final int index;
  final int value;
  final Function(int p1) callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UiDimens.v10,
      child: ListTile(
        title: Text(title ?? (index == 0 ? "All" : "Heater $index")),
        trailing: ToggleButtons(
          isSelected: [
            value == 0,
            value == 1,
            value == 2,
            value == 3,
          ],
          children: const [
            Text("0"),
            Text("1"),
            Text("2"),
            Text("3"),
          ],
          onPressed: (v) {
            callback(v);
          },
        ),
      ),
    );
  }
}
