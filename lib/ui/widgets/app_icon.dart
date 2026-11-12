import '../theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Original vectors exported from the Figma component library.
class AppIcon extends StatelessWidget {
  const AppIcon(this.name, {super.key, this.size = 20, this.color});
  static Future<void> precache(
    Iterable<String> names, {
    AssetBundle? bundle,
  }) async {
    await Future.wait(
      names.map(
        (name) => SvgAssetLoader(
          'assets/icons/$name.svg',
          assetBundle: bundle,
        ).loadBytes(null),
      ),
    );
  }

  final String name;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    'assets/icons/$name.svg',
    width: size,
    height: size,
    excludeFromSemantics: true,
    colorFilter: ColorFilter.mode(
      color ?? IconTheme.of(context).color ?? context.ui.colors.fgTertiary,
      BlendMode.srcIn,
    ),
  );
}
