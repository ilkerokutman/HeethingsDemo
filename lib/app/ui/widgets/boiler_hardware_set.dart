import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/data/models/demo.dart';
import 'package:heethings_demo/app/data/services/demo.dart';

class BoilerHardwareSetChangerWidget extends StatefulWidget {
  const BoilerHardwareSetChangerWidget({super.key});

  @override
  State<BoilerHardwareSetChangerWidget> createState() =>
      _BoilerHardwareSetChangerWidgetState();
}

class _BoilerHardwareSetChangerWidgetState
    extends State<BoilerHardwareSetChangerWidget> {
  late PageController pageController;
  int currentPage = 0;
  final DemoController dc = Get.find();

  @override
  void initState() {
    super.initState();
    currentPage = dc.demo.demoBoilerHardwareIndex;
    pageController = PageController(initialPage: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: (p) {
        setState(() => currentPage = p);
        Demo d = dc.demo;
        d.demoBoilerHardwareIndex = currentPage;
        dc.setDemo(d);
      },
      children: const [
        Center(
          child: Text("1986"),
        ),
        Center(
          child: Text("2010"),
        ),
      ],
    );
  }
}
