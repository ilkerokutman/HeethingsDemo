import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:heethings_demo/app/ui/widgets/outside_heater.dart';

class ViewerCafeWidget extends StatelessWidget {
  const ViewerCafeWidget({
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
                      'assets/images/cafe_background.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.92, -0.19),
                  child: OutsideHeaterWidget(
                      level: dc.demo.p1999z1d1, zoom: ratio),
                ),
                Align(
                  alignment: const Alignment(0.2, -0.19),
                  child: OutsideHeaterWidget(
                      level: dc.demo.p1999z1d2, zoom: ratio),
                ),
                Align(
                  alignment: const Alignment(0.95, -0.19),
                  child: OutsideHeaterWidget(
                      level: dc.demo.p1999z1d3, zoom: ratio),
                ),
              ],
            );
          }),
        ),
      );
    });
  }
}
