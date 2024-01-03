import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/ui/widgets/logo.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool automaticallyImplyLeading;
  final Widget? action;
  const AppBarWidget({
    super.key,
    this.automaticallyImplyLeading = true,
    this.action,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:
          !automaticallyImplyLeading && action != null ? Container() : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: const LogoWidget(),
      centerTitle: true,
      actions: [
        (action != null)
            ? action!
            : (automaticallyImplyLeading)
                ? const Padding(
                    padding: UiDimens.r6,
                    child: IconButton(
                      icon: Icon(Icons.help),
                      onPressed: null,
                    ),
                  )
                : Container(),
      ],
    );
  }
}
