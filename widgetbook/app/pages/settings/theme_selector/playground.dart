import 'package:cat_tinder/app/pages/settings/theme_selector.dart';
import 'package:cat_tinder/state/appearance.dart';
import 'package:cat_tinder/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../internal/focus_preview.dart';

Widget buildThemeSelectorPlayground(BuildContext context) {
  final knobs = context.knobs;
  return _ThemePreview(
    initialValue: knobs.object.dropdown(
      label: 'value',
      options: Appearance.values,
      initialOption: Appearance.system,
      labelBuilder: (value) => value.name,
      description: 'Starting value when the preview rebuilds. Clicks update local selection.',
    ),
    updateSelection: knobs.boolean(
      label: 'onChanged: update selection',
      initialValue: true,
      description:
          'Off supplies a no-op callback; the control stays interactive.',
    ),
    systemBrightness: knobs.object.dropdown(
      label: 'System brightness',
      options: const ['Device', 'Light', 'Dark'],
      initialOption: 'Device',
      description: 'Host simulation used only when System is selected.',
    ),
    width: knobs.double.slider(
      label: 'Preview width',
      initialValue: 400,
      min: 240,
      max: 640,
    ),
    reducedMotion: knobs.boolean(label: 'Reduced motion'),
  );
}

class _ThemePreview extends StatefulWidget {
  const _ThemePreview({
    required this.initialValue,
    required this.updateSelection,
    required this.systemBrightness,
    required this.width,
    required this.reducedMotion,
  });

  final Appearance initialValue;
  final bool updateSelection, reducedMotion;
  final String systemBrightness;
  final double width;

  @override
  State<_ThemePreview> createState() => _ThemePreviewState();
}

class _ThemePreviewState extends State<_ThemePreview> {
  late Appearance value = widget.initialValue;

  @override
  void didUpdateWidget(_ThemePreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      value = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final systemBrightness = switch (widget.systemBrightness) {
      'Light' => Brightness.light,
      'Dark' => Brightness.dark,
      _ => media.platformBrightness,
    };
    final dark = switch (value) {
      Appearance.light => false,
      Appearance.dark => true,
      Appearance.system => systemBrightness == Brightness.dark,
    };
    final reducedMotion = widget.reducedMotion || media.disableAnimations;
    return MediaQuery(
      data: media.copyWith(disableAnimations: reducedMotion),
      child: AnimatedTheme(
        // Match MaterialApp's default theme transition without app startup.
        duration: reducedMotion ? Duration.zero : kThemeAnimationDuration,
        data: appTheme(
          variables: UiVariables(colors: UiColors(dark: dark)),
        ),
        child: Builder(
          builder: (context) => Material(
            color: context.ui.colors.bgPrimary,
            animationDuration: Duration.zero,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: widget.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Selected: ${value.name} · Theme: ${dark ? "dark" : "light"}',
                      ),
                      const SizedBox(height: 16),
                      FocusPreview(
                        child: ThemeSelector(
                          value: value,
                          onChanged: (next) {
                            if (widget.updateSelection) {
                              setState(() => value = next);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
