import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import 'color_definitions.dart';

export 'color_definitions.dart';

@immutable
class UiRadii {
  const UiRadii({
    this.xs = 4,
    this.sm = 6,
    this.md = 8,
    this.lg = 10,
    this.xl = 12,
  });
  final double xs, sm, md, lg, xl;
  UiRadii copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) => UiRadii(
    xs: xs ?? this.xs,
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
  );
  UiRadii lerp(UiRadii other, double t) => UiRadii(
    xs: lerpDouble(xs, other.xs, t)!,
    sm: lerpDouble(sm, other.sm, t)!,
    md: lerpDouble(md, other.md, t)!,
    lg: lerpDouble(lg, other.lg, t)!,
    xl: lerpDouble(xl, other.xl, t)!,
  );
}

/// A complete inset effect, independent of the component that paints it.
@immutable
class InsetEffect {
  const InsetEffect({
    this.outline = const BorderSide(color: Color(0x2E000000)),
    this.bottom = const BorderSide(color: Color(0x0D000000), width: 2),
    this.highlight = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0x1FFFFFFF), Colors.transparent],
    ),
  });
  final BorderSide outline, bottom;
  final LinearGradient highlight;
  InsetEffect lerp(InsetEffect other, double t) => InsetEffect(
    outline: BorderSide.lerp(outline, other.outline, t),
    bottom: BorderSide.lerp(bottom, other.bottom, t),
    highlight: LinearGradient.lerp(highlight, other.highlight, t)!,
  );
}

@immutable
class UiEffects {
  const UiEffects({
    this.shadowXs = const BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
    this.shadowSecondaryXs = const BoxShadow(
      color: Color(0x0D0A0D12),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
    this.shadowSm = const [
      BoxShadow(
        color: Color(0x1A000000),
        offset: Offset(0, 1),
        blurRadius: 2,
        spreadRadius: -1,
      ),
      BoxShadow(color: Color(0x1A000000), offset: Offset(0, 1), blurRadius: 3),
    ],
    this.shadowLg = const [
      BoxShadow(
        color: Color(0x0A000000),
        offset: Offset(0, 2),
        blurRadius: 2,
        spreadRadius: -1,
      ),
      BoxShadow(
        color: Color(0x08000000),
        offset: Offset(0, 4),
        blurRadius: 6,
        spreadRadius: -2,
      ),
      BoxShadow(
        color: Color(0x14000000),
        offset: Offset(0, 12),
        blurRadius: 16,
        spreadRadius: -4,
      ),
    ],
    this.skeuomorphic = const InsetEffect(),
  });
  final BoxShadow shadowXs, shadowSecondaryXs;
  final List<BoxShadow> shadowSm, shadowLg;
  final InsetEffect skeuomorphic;
  UiEffects copyWith({
    BoxShadow? shadowXs,
    BoxShadow? shadowSecondaryXs,
    List<BoxShadow>? shadowSm,
    List<BoxShadow>? shadowLg,
    InsetEffect? skeuomorphic,
  }) => UiEffects(
    shadowXs: shadowXs ?? this.shadowXs,
    shadowSecondaryXs: shadowSecondaryXs ?? this.shadowSecondaryXs,
    shadowSm: shadowSm ?? this.shadowSm,
    shadowLg: shadowLg ?? this.shadowLg,
    skeuomorphic: skeuomorphic ?? this.skeuomorphic,
  );
  UiEffects lerp(UiEffects other, double t) => UiEffects(
    shadowXs: BoxShadow.lerp(shadowXs, other.shadowXs, t)!,
    shadowSecondaryXs: BoxShadow.lerp(
      shadowSecondaryXs,
      other.shadowSecondaryXs,
      t,
    )!,
    shadowSm: BoxShadow.lerpList(shadowSm, other.shadowSm, t)!,
    shadowLg: BoxShadow.lerpList(shadowLg, other.shadowLg, t)!,
    skeuomorphic: skeuomorphic.lerp(other.skeuomorphic, t),
  );
}

/// Size/line-height scale from text-* and display-* CSS variables.
/// Weight and semantic usage are selected by the consuming component.
@immutable
class UiTypography {
  const UiTypography({
    this.textXs = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      height: 18 / 12,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    this.textSm = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    this.textMd = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    this.textLg = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 18,
      height: 28 / 18,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    this.textXl = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 20,
      height: 30 / 20,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    this.displayXs = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 24,
      height: 32 / 24,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    this.displaySm = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 30,
      height: 38 / 30,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    this.displayMd = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 36,
      height: 44 / 36,
      letterSpacing: -0.72,
      fontWeight: FontWeight.w400,
    ),
    this.displayLg = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 48,
      height: 60 / 48,
      letterSpacing: -0.96,
      fontWeight: FontWeight.w400,
    ),
    this.displayXl = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 60,
      height: 72 / 60,
      letterSpacing: -1.2,
      fontWeight: FontWeight.w400,
    ),
    this.display2xl = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 72,
      height: 90 / 72,
      letterSpacing: -1.44,
      fontWeight: FontWeight.w400,
    ),
  });
  final TextStyle textXs;
  final TextStyle textSm;
  final TextStyle textMd;
  final TextStyle textLg;
  final TextStyle textXl;
  final TextStyle displayXs;
  final TextStyle displaySm;
  final TextStyle displayMd;
  final TextStyle displayLg;
  final TextStyle displayXl;
  final TextStyle display2xl;
  UiTypography copyWith({
    TextStyle? textXs,
    TextStyle? textSm,
    TextStyle? textMd,
    TextStyle? textLg,
    TextStyle? textXl,
    TextStyle? displayXs,
    TextStyle? displaySm,
    TextStyle? displayMd,
    TextStyle? displayLg,
    TextStyle? displayXl,
    TextStyle? display2xl,
  }) => UiTypography(
    textXs: textXs ?? this.textXs,
    textSm: textSm ?? this.textSm,
    textMd: textMd ?? this.textMd,
    textLg: textLg ?? this.textLg,
    textXl: textXl ?? this.textXl,
    displayXs: displayXs ?? this.displayXs,
    displaySm: displaySm ?? this.displaySm,
    displayMd: displayMd ?? this.displayMd,
    displayLg: displayLg ?? this.displayLg,
    displayXl: displayXl ?? this.displayXl,
    display2xl: display2xl ?? this.display2xl,
  );
  UiTypography withColor(Color color) => UiTypography(
    textXs: textXs.copyWith(color: color),
    textSm: textSm.copyWith(color: color),
    textMd: textMd.copyWith(color: color),
    textLg: textLg.copyWith(color: color),
    textXl: textXl.copyWith(color: color),
    displayXs: displayXs.copyWith(color: color),
    displaySm: displaySm.copyWith(color: color),
    displayMd: displayMd.copyWith(color: color),
    displayLg: displayLg.copyWith(color: color),
    displayXl: displayXl.copyWith(color: color),
    display2xl: display2xl.copyWith(color: color),
  );
  UiTypography lerp(UiTypography other, double t) => UiTypography(
    textXs: TextStyle.lerp(textXs, other.textXs, t)!,
    textSm: TextStyle.lerp(textSm, other.textSm, t)!,
    textMd: TextStyle.lerp(textMd, other.textMd, t)!,
    textLg: TextStyle.lerp(textLg, other.textLg, t)!,
    textXl: TextStyle.lerp(textXl, other.textXl, t)!,
    displayXs: TextStyle.lerp(displayXs, other.displayXs, t)!,
    displaySm: TextStyle.lerp(displaySm, other.displaySm, t)!,
    displayMd: TextStyle.lerp(displayMd, other.displayMd, t)!,
    displayLg: TextStyle.lerp(displayLg, other.displayLg, t)!,
    displayXl: TextStyle.lerp(displayXl, other.displayXl, t)!,
    display2xl: TextStyle.lerp(display2xl, other.display2xl, t)!,
  );
}

/// Inherited styling variables. Override through Theme, globally or in a subtree.
@immutable
class UiVariables extends ThemeExtension<UiVariables> {
  const UiVariables({
    this.colors = const UiColors(),
    this.spacingUnit = 4,
    this.radii = const UiRadii(),
    this.effects = const UiEffects(),
    this.typography = const UiTypography(),
  });
  final UiColors colors;
  final double spacingUnit;
  final UiRadii radii;
  final UiEffects effects;
  final UiTypography typography;
  double space(double units) => spacingUnit * units;
  UiTypography get text => typography.withColor(colors.textPrimary);

  @override
  UiVariables copyWith({
    UiColors? colors,
    double? spacingUnit,
    UiRadii? radii,
    UiEffects? effects,
    UiTypography? typography,
  }) => UiVariables(
    colors: colors ?? this.colors,
    spacingUnit: spacingUnit ?? this.spacingUnit,
    radii: radii ?? this.radii,
    effects: effects ?? this.effects,
    typography: typography ?? this.typography,
  );
  @override
  UiVariables lerp(covariant UiVariables? other, double t) => other == null
      ? this
      : UiVariables(
          colors: colors.lerp(other.colors, t),
          spacingUnit: lerpDouble(spacingUnit, other.spacingUnit, t)!,
          radii: radii.lerp(other.radii, t),
          effects: effects.lerp(other.effects, t),
          typography: typography.lerp(other.typography, t),
        );
}

extension UiContext on BuildContext {
  UiVariables get ui =>
      Theme.of(this).extension<UiVariables>() ?? const UiVariables();
}
