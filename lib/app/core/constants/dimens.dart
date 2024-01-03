import 'package:flutter/material.dart';

class UiDimens {
  static const EdgeInsets h20 = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets h10 = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets v10 = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets v20 = EdgeInsets.symmetric(vertical: 20);
  static const EdgeInsets a4 = EdgeInsets.all(4);
  static const EdgeInsets a10 = EdgeInsets.all(10);
  static const EdgeInsets a20 = EdgeInsets.all(20);
  static const EdgeInsets a40 = EdgeInsets.all(40);
  static const EdgeInsets a60 = EdgeInsets.all(60);

  static const EdgeInsets t20 = EdgeInsets.only(top: 20);

  static const EdgeInsets r6 = EdgeInsets.only(right: 6);

  static const EdgeInsets b60 = EdgeInsets.only(bottom: 60);
  static const EdgeInsets b100 = EdgeInsets.only(bottom: 100);
  static const EdgeInsets b70 = EdgeInsets.only(bottom: 70);
  static const EdgeInsets b10 = EdgeInsets.only(bottom: 10);
  static const EdgeInsets b20 = EdgeInsets.only(bottom: 20);

  static BorderRadius c20 = BorderRadius.circular(20);
  static BorderRadius top20 = const BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  );
  static BorderRadius bottom20 = const BorderRadius.only(
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  );

  static BorderRadius stadium = BorderRadius.circular(30);

  static const double buttonHeight = 60.0;

  static const double controlTileWidth = 180.0;
  static const double controlTileHeight = 180.0;

  static const double controlScreenWidth = 300.0;
  static const double controlScreenHeight = 500.0;

  static const double sliderTrackWidth = 20.0;
}
