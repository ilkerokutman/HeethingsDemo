import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/constants/enums.dart';

class ScreenUtils {
  static const double breakpointXS = 360;
  static const double breakpointS = 600;
  static const double breakpointM = 840;
  static const double breakpointL = 1024;
  static const double breakpointXL = 1400;

  static ScreenSize screenSize(BoxConstraints constraints) {
    ScreenSize result = ScreenSize.xs;
    if (constraints.maxWidth > breakpointXS) result = ScreenSize.s;
    if (constraints.maxWidth > breakpointS) result = ScreenSize.m;
    if (constraints.maxWidth > breakpointM) result = ScreenSize.l;
    if (constraints.maxWidth > breakpointL) result = ScreenSize.xl;
    if (constraints.maxWidth > breakpointXL) result = ScreenSize.xxl;
    return result;
  }

  
}
