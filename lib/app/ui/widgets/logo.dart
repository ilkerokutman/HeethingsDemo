import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heethings_demo/app/core/constants/assets.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UiDimens.a4,
      width: double.infinity,
      height: kToolbarHeight,
      child: Image.asset(
        Get.isDarkMode ? UiAssets.logoDark : UiAssets.logoLight,
        fit: BoxFit.contain,
      ),
    );
  }
}
