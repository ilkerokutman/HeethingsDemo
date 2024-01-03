import 'package:flutter/material.dart';

class FoodCourtHeaterWidget extends StatelessWidget {
  final int level;
  final double zoom;
  final int index;
  const FoodCourtHeaterWidget({
    super.key,
    this.level = 0,
    this.zoom = 1,
    this.index = 1,
  });

  @override
  Widget build(BuildContext context) {
    String image;
    switch (level) {
      case 1:
        image = 'assets/images/food_court_${index}_level_1.png';
        break;
      case 2:
        image = 'assets/images/food_court_${index}_level_2.png';
        break;
      case 3:
        image = 'assets/images/food_court_${index}_level_3.png';
        break;
      default:
        image = 'assets/images/food_court_${index}_level_0.png';
        break;
    }
    return SizedBox(
      width: 698 * zoom,
      height: (index == 1 ? 144 : 177) * zoom,
      child: Image.asset(image, fit: BoxFit.contain),
    );
  }
}
