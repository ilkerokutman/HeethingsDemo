import 'package:flutter/material.dart';

class ProductionHeaterWidget extends StatelessWidget {
  final int level;
  final double zoom;
  final int index;
  const ProductionHeaterWidget({
    super.key,
    this.level = 0,
    this.zoom = 1,
    this.index = 1,
  });

  @override
  Widget build(BuildContext context) {
    String image;

    double w = 0;
    double h = 0;

    switch (index) {
      case 1:
        w = 204;
        h = 159;
        break;
      case 2:
        w = 203;
        h = 187;
        break;
      case 3:
        w = 204;
        h = 159;
        break;
    }

    switch (level) {
      case 1:
        image = 'assets/images/production_${index}_level_1.png';
        break;
      case 2:
        image = 'assets/images/production_${index}_level_2.png';
        break;
      case 3:
        image = 'assets/images/production_${index}_level_3.png';
        break;
      default:
        image = 'assets/images/production_${index}_level_0.png';
        break;
    }
    return SizedBox(
      width: w * zoom,
      height: h * zoom,
      child: Image.asset(image, fit: BoxFit.contain),
    );
  }
}
