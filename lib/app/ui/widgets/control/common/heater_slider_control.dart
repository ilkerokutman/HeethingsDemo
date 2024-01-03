import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/data/services/demo.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HeaterSliderControlScreen extends StatefulWidget {
  final int index;
  final int level;
  final Function(int) callback;
  final String tag;
  final String asset;
  final Function valueHandler;
  const HeaterSliderControlScreen({
    super.key,
    required this.index,
    required this.callback,
    required this.tag,
    this.level = 0,
    required this.asset,
    required this.valueHandler,
  });

  @override
  State<HeaterSliderControlScreen> createState() =>
      _HeaterSliderControlScreenState();
}

class _HeaterSliderControlScreenState extends State<HeaterSliderControlScreen> {
  int selectedLevel = 0;
  bool userInteracting = false;
  bool showSlider = false;
  @override
  void initState() {
    super.initState();
    selectedLevel = widget.level;
    Future.delayed(const Duration(milliseconds: 200),
        () => setState(() => showSlider = true));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(
      builder: (dc) {
        bool commandApplied = widget.valueHandler() == selectedLevel;
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                constraints: const BoxConstraints.expand(),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: widget.tag,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: UiDimens.controlScreenHeight,
                      maxWidth: UiDimens.controlScreenWidth,
                    ),
                    child: Card(
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: UiDimens.t20,
                              child: Image.asset(
                                widget.asset
                                    .replaceAll('{0}', '$selectedLevel'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (showSlider)
                                  Container(
                                    constraints: const BoxConstraints(
                                      maxHeight: UiDimens.controlScreenWidth,
                                      maxWidth: UiDimens.controlScreenWidth / 2,
                                    ),
                                    child: SfSliderTheme(
                                      data: SfSliderThemeData(
                                        activeTrackHeight:
                                            UiDimens.sliderTrackWidth,
                                        inactiveTrackHeight:
                                            UiDimens.sliderTrackWidth,
                                        activeTrackColor: UiColors.danger,
                                        thumbColor: UiColors.primary,
                                        thumbRadius: UiDimens.sliderTrackWidth,
                                        inactiveDividerRadius:
                                            UiDimens.sliderTrackWidth / 10,
                                        activeDividerRadius:
                                            UiDimens.sliderTrackWidth / 10,
                                        overlayColor:
                                            UiColors.primary.withOpacity(0.4),
                                        overlayRadius:
                                            UiDimens.sliderTrackWidth * 2,
                                      ),
                                      child: SfSlider.vertical(
                                        value: selectedLevel,
                                        onChanged: (dynamic v) {
                                          int newValue = v.round();
                                          setState(() {
                                            selectedLevel = newValue;
                                          });
                                        },
                                        max: 3,
                                        min: 0,
                                        interval: 1.0,
                                        onChangeEnd: (value) {
                                          int newValue = value.round();
                                          setState(() {
                                            userInteracting = false;
                                          });
                                          widget.callback(newValue);
                                        },
                                        onChangeStart: (v) {
                                          setState(() {
                                            userInteracting = true;
                                          });
                                        },
                                        showDividers: true,
                                        showLabels: true,
                                      ),
                                    ),
                                  ),
                                Text(
                                  widget.index == 0
                                      ? 'ALL'
                                      : '#${widget.index}',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: UiColors.black.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!userInteracting && !commandApplied)
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: UiDimens.a20,
                                child: const Icon(
                                  Icons.wifi,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
