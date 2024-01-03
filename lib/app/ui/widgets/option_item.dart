import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/ui/components/gap.dart';

class OptionItemCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;
  final GestureTapCallback callback;
  final IconData icon;
  final bool showTimer;
  const OptionItemCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.actionText,
    required this.callback,
    required this.icon,
    this.showTimer = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: UiDimens.c20),
      color: Theme.of(context).colorScheme.primaryContainer,
      margin: UiDimens.a20,
      child: Container(
        decoration: BoxDecoration(borderRadius: UiDimens.c20),
        padding: UiDimens.a20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            Text(description),
            const Gap(10),
            Container(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: callback,
                icon: Icon(icon),
                label: Text(actionText),
              ),
            )
          ],
        ),
      ),
    );
  }
}
