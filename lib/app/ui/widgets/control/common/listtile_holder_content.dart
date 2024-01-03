import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';

class ControlListTileHolderContentWidget extends StatelessWidget {
  const ControlListTileHolderContentWidget({
    super.key,
    required this.context,
    required this.color,
    required this.children,
  });

  final BuildContext context;
  final Color color;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: UiDimens.a10,
      decoration: BoxDecoration(
          borderRadius: UiDimens.bottom20, color: color.withOpacity(0.1)),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: children,
      ),
    );
  }
}
