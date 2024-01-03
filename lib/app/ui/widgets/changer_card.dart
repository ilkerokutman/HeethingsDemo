import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/constants/colors.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';

class FloatingChangerCard extends StatefulWidget {
  final Widget child;
  final String title;
  final double height;
  const FloatingChangerCard({
    super.key,
    required this.child,
    required this.title,
    this.height = 200,
  });

  @override
  State<FloatingChangerCard> createState() => _FloatingChangerCardState();
}

class _FloatingChangerCardState extends State<FloatingChangerCard> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: UiDimens.a20,
      width: 200,
      height: expanded ? widget.height : kToolbarHeight,
      decoration: BoxDecoration(
        borderRadius: UiDimens.c20,
        color: UiColors.white,
      ),
      child: ClipRRect(
        borderRadius: UiDimens.c20,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              borderRadius: UiDimens.c20,
              onTap: () => setState(() => expanded = !expanded),
              child: Container(
                height: kToolbarHeight,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Center(
                    child: Text(
                  widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: UiColors.white),
                )),
              ),
            ),
            Expanded(
              child: expanded ? widget.child : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
