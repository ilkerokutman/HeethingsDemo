import 'package:flutter/material.dart';
import 'package:heethings_demo/app/core/constants/dimens.dart';
import 'package:heethings_demo/app/ui/widgets/control/common/heater_slider_control.dart';

class ControlListTileWidget extends StatelessWidget {
  final int index;
  final int level;
  final Function(int) callback;
  final Function valueHandler;
  final String asset;
  final String tagPrefix;
  const ControlListTileWidget({
    super.key,
    required this.index,
    required this.level,
    required this.callback,
    required this.valueHandler,
    required this.asset,
    this.tagPrefix = '',
  });

  @override
  Widget build(BuildContext context) {
    final tag = '${tagPrefix}controlCard$index';
    return SizedBox(
      width: UiDimens.controlTileWidth,
      height: UiDimens.controlTileHeight,
      child: Hero(
        tag: tag,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: UiDimens.c20),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => HeaterSliderControlScreen(
                    index: index,
                    callback: callback,
                    level: level,
                    tag: tag,
                    asset: asset,
                    valueHandler: valueHandler,
                  ),
                  opaque: false,
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
            },
            borderRadius: UiDimens.c20,
            child: ClipRRect(
              borderRadius: UiDimens.c20,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: UiDimens.c20,
                ),
                padding: UiDimens.a20,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        asset.replaceAll('{0}', '$level'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        index == 0 ? 'ALL' : '#$index',
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
