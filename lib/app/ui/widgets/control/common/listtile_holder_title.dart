import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';

class ControlListTileHolderTitleWidget extends StatelessWidget {
  const ControlListTileHolderTitleWidget({
    super.key,
    required this.context,
    required this.title,
    required this.color,
  });

  final BuildContext context;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: UiDimens.t20,
      width: double.infinity,
      padding: UiDimens.v20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: UiDimens.top20,
      ),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: UiColors.white),
      ),
    );
  }
}
