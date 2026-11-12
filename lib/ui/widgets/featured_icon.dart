import 'package:flutter/material.dart';

import '../theme.dart';
import 'app_icon.dart';

enum FeaturedIconSize { sm, md, lg, xl }

enum FeaturedIconColor { gray, brand, success, warning, error }

enum FeaturedIconStyle { light, dark, modern }

class FeaturedIcon extends StatelessWidget {
  const FeaturedIcon(
    this.icon, {
    super.key,
    this.size = FeaturedIconSize.lg,
    this.color = FeaturedIconColor.gray,
    this.style = FeaturedIconStyle.modern,
  }) : assert(
         style != FeaturedIconStyle.modern || color == FeaturedIconColor.gray,
       );

  final String icon;
  final FeaturedIconSize size;
  final FeaturedIconColor color;
  final FeaturedIconStyle style;

  @override
  Widget build(BuildContext context) {
    final v = context.ui;
    final c = v.colors;
    final dimension = 32.0 + size.index * 8;
    final radius = switch (size) {
      FeaturedIconSize.sm => v.radii.sm,
      FeaturedIconSize.md => v.radii.md,
      FeaturedIconSize.lg => v.radii.lg,
      FeaturedIconSize.xl => v.radii.xl,
    };
    final modern = style == FeaturedIconStyle.modern;
    final dark = style == FeaturedIconStyle.dark;
    final background = modern
        ? c.bgPrimary
        : switch (color) {
            FeaturedIconColor.gray => dark ? c.bgSecondarySolid : c.bgTertiary,
            FeaturedIconColor.brand =>
              dark ? c.bgBrandSolid : c.bgBrandSecondary,
            FeaturedIconColor.success =>
              dark ? c.bgSuccessSolid : c.bgSuccessSecondary,
            FeaturedIconColor.warning =>
              dark ? c.bgWarningSolid : c.bgWarningSecondary,
            FeaturedIconColor.error =>
              dark ? c.bgErrorSolid : c.bgErrorSecondary,
          };
    final foreground = modern
        ? c.fgSecondary
        : dark
        ? c.fgWhite
        : switch (color) {
            FeaturedIconColor.gray => c.neutral500,
            FeaturedIconColor.brand => c.fgBrandPrimary,
            FeaturedIconColor.success => c.fgSuccessPrimary,
            FeaturedIconColor.warning => c.fgWarningPrimary,
            FeaturedIconColor.error => c.fgErrorPrimary,
          };
    final framedIcon = Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        color: background,
        border: modern ? Border.all(color: c.borderPrimary) : null,
        boxShadow: modern ? [v.effects.shadowXs] : null,
        borderRadius: BorderRadius.circular(
          style == FeaturedIconStyle.light ? dimension / 2 : radius,
        ),
      ),
      foregroundDecoration: modern
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border(bottom: v.effects.skeuomorphic.bottom),
            )
          : null,
      child: Center(
        child: AppIcon(icon, size: dimension / 2, color: foreground),
      ),
    );
    if (!modern) return framedIcon;
    return Stack(
      children: [
        framedIcon,
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                border: Border.fromBorderSide(v.effects.skeuomorphic.outline),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
