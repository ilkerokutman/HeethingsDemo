import 'package:flutter/material.dart';

class P1975SensorWidget extends StatelessWidget {
  final int level;
  final double zoom;
  const P1975SensorWidget({super.key, required this.level, this.zoom = 1});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115 * zoom,
      height: 81 * zoom,
      child: Image.asset('assets/images/p1975_$level.png', fit: BoxFit.contain),
    );
  }
}
