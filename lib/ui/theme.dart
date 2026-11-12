import 'dart:ui' show ColorSpace;

import 'package:flutter/material.dart';

import 'styles/variables.dart';

export 'styles/variables.dart';

/// Bridges shared variables into Flutter's native inherited defaults.
ThemeData appTheme({UiVariables variables = const UiVariables()}) {
  final colors = variables.colors;
  final typography = variables.text;
  final brightness = colors.dark ? Brightness.dark : Brightness.light;
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    // Flutter's legacy primary-color luminance calculation requires sRGB.
    primaryColor: (colors.dark ? colors.bgPrimary : colors.bgBrandSolid)
        .withValues(colorSpace: ColorSpace.sRGB),
    extensions: [variables],
    scaffoldBackgroundColor: colors.bgPrimary,
    // Flutter role names are restricted to this platform adapter.
    textTheme: TextTheme(
      bodySmall: typography.textXs,
      bodyMedium: typography.textSm,
      bodyLarge: typography.textMd,
      titleSmall: typography.textLg.copyWith(fontWeight: FontWeight.w600),
      titleMedium: typography.textXl.copyWith(fontWeight: FontWeight.w600),
      titleLarge: typography.displayXs.copyWith(fontWeight: FontWeight.w600),
      labelSmall: typography.textXs.copyWith(fontWeight: FontWeight.w600),
      labelMedium: typography.textSm.copyWith(fontWeight: FontWeight.w600),
      labelLarge: typography.textMd.copyWith(fontWeight: FontWeight.w600),
      headlineSmall: typography.displaySm,
      headlineMedium: typography.displayMd,
      headlineLarge: typography.displayLg,
      displaySmall: typography.displayLg,
      displayMedium: typography.displayXl,
      displayLarge: typography.display2xl,
    ),
    iconTheme: IconThemeData(color: colors.fgTertiary),
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: colors.bgBrandSolid,
          brightness: brightness,
        ).copyWith(
          primary: colors.bgBrandSolid,
          onPrimary: colors.textWhite,
          surface: colors.bgPrimary,
          onSurface: colors.textPrimary,
          outline: colors.borderPrimary,
          outlineVariant: colors.borderSecondary,
        ),
    dividerColor: colors.borderSecondary,
  );
}
