import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/widgets/food_court_heater.dart';
import 'package:heethings_demo/app/ui/widgets/garden_heater.dart';
import 'package:heethings_demo/app/ui/widgets/production_heater.dart';

class ViewerFactoryWidget extends StatelessWidget {
  const ViewerFactoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(builder: (dc) {
      return Center(
        child: AspectRatio(
          aspectRatio: 2034 / 1009,
          child: LayoutBuilder(builder: (_, c) {
            double width = c.maxWidth;
            double ratio = width / 2034;
            return Stack(
              children: [
                Center(
                  child: Opacity(
                    opacity: 0.7,
                    child: Image.asset(
                      'assets/images/factory_background.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.57, 0.705),
                  child:
                      GardenHeaterWidget(level: dc.demo.p1994z3d1, zoom: ratio),
                ),
                Align(
                  alignment: const Alignment(-0.547, 0.26),
                  child: FoodCourtHeaterWidget(
                    level: dc.demo.p1994z2d1,
                    zoom: ratio,
                    index: 1,
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.56, 1.06),
                  child: FoodCourtHeaterWidget(
                    level: dc.demo.p1994z2d2,
                    zoom: ratio,
                    index: 2,
                  ),
                ),
                Align(
                  alignment: const Alignment(0.924, 0.1),
                  child: ProductionHeaterWidget(
                    level: dc.demo.p1994z1d1,
                    zoom: ratio,
                    index: 1,
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.175, -0.94),
                  child: ProductionHeaterWidget(
                    level: dc.demo.p1994z1d2,
                    zoom: ratio,
                    index: 2,
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.927, -0.40),
                  child: ProductionHeaterWidget(
                    level: dc.demo.p1994z1d3,
                    zoom: ratio,
                    index: 3,
                  ),
                ),
              ],
            );
          }),
        ),
      );
    });
  }
}
