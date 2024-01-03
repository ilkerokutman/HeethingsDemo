import 'package:flutter/material.dart';

class P1986HardwareWidget extends StatelessWidget {
  final double zoom;
  const P1986HardwareWidget({
    super.key,
    this.zoom = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 57 * zoom,
      height: 62 * zoom,
      child: Image.asset(
        'assets/images/p1986_device.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
