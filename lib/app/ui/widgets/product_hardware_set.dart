import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/data/models/demo.dart';
import 'package:heethings_demo/app/data/services/demo.dart';

class ProductHardwareSetChangerWidget extends StatefulWidget {
  const ProductHardwareSetChangerWidget({super.key});

  @override
  State<ProductHardwareSetChangerWidget> createState() =>
      _ProductHardwareSetChangerWidgetState();
}

class _ProductHardwareSetChangerWidgetState
    extends State<ProductHardwareSetChangerWidget> {
  late PageController pageController;
  int currentPage = 0;
  final DemoController dc = Get.find();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: (p) {
        setState(() => currentPage = p);
        Demo d = dc.demo;
        d.demoRoomHardwareIndex = currentPage;
        dc.setDemo(d);
      },
      children: [
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("1986"),
                Image.asset('assets/images/thermostat_display.png'),
                const Divider(),
                const Text("Move Thermostat to Room"),
                ToggleButtons(
                  onPressed: (p) {
                    Demo d = dc.demo;
                    d.p1986SelectedRoomIndex = p + 1;
                    dc.setDemo(d);
                  },
                  isSelected: [
                    dc.demo.p1986SelectedRoomIndex == 1,
                    dc.demo.p1986SelectedRoomIndex == 2,
                    dc.demo.p1986SelectedRoomIndex == 3
                  ],
                  children: const [
                    Text("1"),
                    Text("2"),
                    Text("3"),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        ),
        const Center(
          child: Text("1972"),
        ),
        const Center(
          child: Text("1975"),
        ),
      ],
    );
  }
}
