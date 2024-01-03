import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';

class P1972SensorWidget extends StatelessWidget {
  final double zoom;
  final int index;
  final bool active;
  const P1972SensorWidget({
    super.key,
    this.zoom = 1,
    this.index = 1,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    double w = 0;
    double h = 0;

    switch (index) {
      case 1:
        w = 27;
        h = 12;
        break;
      case 2:
        w = 26;
        h = 12;
        break;
      case 3:
        w = 58;
        h = 56;
        break;
    }

    return SizedBox(
      width: w * zoom,
      height: h * zoom,
      child: Stack(
        children: [
          Image.asset('assets/images/p1972_$index.png', fit: BoxFit.contain),
          if (active)
            const Center(
              child: CircleAvatar(backgroundColor: UiColors.success, radius: 3),
            )
        ],
      ),
    );
  }
}
