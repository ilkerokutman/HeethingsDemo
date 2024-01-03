import 'package:flutter/widgets.dart';

class AirFlowWidget extends StatelessWidget {
  final double zoom;
  final int index;
  const AirFlowWidget({
    super.key,
    this.zoom = 1,
    this.index = 1,
  });

  @override
  Widget build(BuildContext context) {
    double w = 57;
    double h = 48;
    String file = "airflow_boiler.png";
    if (index == 1) {
      w = 139;
      h = 39;
      file = "airflow_boiler_large.png";
    }
    return SizedBox(
      width: w * zoom,
      height: h * zoom,
      child: Image.asset('assets/images/$file'),
    );
  }
}
