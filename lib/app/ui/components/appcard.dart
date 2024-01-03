import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';

class AppCardWidget extends StatelessWidget {
  final Widget? header;
  final Widget? footer;
  final Widget child;
  final double? width;
  final double? aspectRatio;
  final EdgeInsets? margin;
  const AppCardWidget({
    super.key,
    required this.child,
    this.width,
    this.header,
    this.footer,
    this.aspectRatio,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return width == null
        ? Container(
            margin: margin,
            constraints: const BoxConstraints.expand(),
            child: card,
          )
        : SizedBox(
            width: width,
            child: aspectRatio == null
                ? card
                : AspectRatio(
                    aspectRatio: aspectRatio!,
                    child: card,
                  ),
          );
  }

  Widget get card => Card(
        shape: RoundedRectangleBorder(borderRadius: UiDimens.c20),
        elevation: 2,
        child: ClipRRect(
          borderRadius: UiDimens.c20,
          child: Column(
            mainAxisSize:
                aspectRatio == null ? MainAxisSize.min : MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (header != null)
                Container(
                  width: double.infinity,
                  padding: UiDimens.a20,
                  color: UiColors.primary,
                  child: header,
                ),
              aspectRatio == null
                  ? Container(
                      width: double.infinity,
                      padding: UiDimens.a20,
                      child: child,
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        padding: UiDimens.a20,
                        child: child,
                      ),
                    )),
              if (footer != null)
                Container(
                  width: double.infinity,
                  padding: UiDimens.a20,
                  alignment: Alignment.centerRight,
                  child: footer,
                )
            ],
          ),
        ),
      );
}
