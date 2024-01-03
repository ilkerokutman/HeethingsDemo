import 'package:flutter/material.dart';

class GardenHeaterWidget extends StatelessWidget {
  final int level;
  final double zoom;
  const GardenHeaterWidget({
    super.key,
    this.level = 0,
    this.zoom = 1,
  });

  @override
  Widget build(BuildContext context) {
    String image;
    switch (level) {
      case 1:
        image = 'assets/images/garden_level_1.png';
        break;
      case 2:
        image = 'assets/images/garden_level_2.png';
        break;
      case 3:
        image = 'assets/images/garden_level_3.png';
        break;
      default:
        image = 'assets/images/garden_level_0.png';
        break;
    }
    return SizedBox(
      width: 324 * zoom,
      height: 218 * zoom,
      child: Image.asset(image, fit: BoxFit.contain),
    );
  }
}
