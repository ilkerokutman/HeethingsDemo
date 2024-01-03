import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';

class AppButton extends StatelessWidget {
  final String title;
  final GestureTapCallback? callback;
  final Widget? icon;
  const AppButton({
    super.key,
    required this.title,
    this.callback,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: UiDimens.buttonHeight,
      child: icon == null
          ? ElevatedButton(
              onPressed: callback,
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(UiColors.primary),
                foregroundColor: MaterialStatePropertyAll(UiColors.white),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            )
          : ElevatedButton.icon(
              onPressed: callback,
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(UiColors.primary),
                foregroundColor: MaterialStatePropertyAll(UiColors.white),
              ),
              icon: icon!,
              label: Text(
                title,
                textAlign: TextAlign.center,
              )),
    );
  }
}
