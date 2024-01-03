import 'package:flutter/material.dart';

class P1986SensorWidget extends StatelessWidget {
  final double zoom;
  const P1986SensorWidget({
    super.key,
    this.zoom = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58 * zoom,
      height: 59 * zoom,
      child: Image.asset('assets/images/p1986_thermostat.png',
          fit: BoxFit.contain),
    );
  }
}
