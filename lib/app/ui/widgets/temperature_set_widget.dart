import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/utils/demo.dart';

class TemperatureSetterWidget extends StatelessWidget {
  final int temperature;
  final Function(int) callback;
  final bool dense;
  const TemperatureSetterWidget({
    super.key,
    required this.temperature,
    required this.callback,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => callback(temperature - 1),
          icon: const Icon(Icons.remove),
          iconSize: dense ? 24 : 48,
        ),
        Text(
          DemoUtils.displayTemperature(temperature),
          style: dense ? null : Theme.of(context).textTheme.titleLarge,
        ),
        IconButton(
          onPressed: () => callback(temperature + 1),
          icon: const Icon(Icons.add),
          iconSize: dense ? 24 : 48,
        ),
      ],
    );
  }
}
