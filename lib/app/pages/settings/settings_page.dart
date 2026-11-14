import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cat_tinder/state/appearance.dart';
import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/application/page_header.dart';

import 'theme_selector.dart';

import '../../layouts/application_layout.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variables = context.ui;
    final appearance = ref.watch(appearanceProvider);
    final supporting = variables.text.textSm.copyWith(
      color: variables.colors.textTertiary,
    );
    final label = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'App theme',
          style: variables.text.textSm.copyWith(
            fontWeight: FontWeight.w600,
            color: variables.colors.textSecondary,
          ),
        ),
        SizedBox(height: variables.space(1)),
        Text('Select your preferred appearance.', style: supporting),
      ],
    );
    final selection = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ThemeSelector(
          value: appearance,
          onChanged: (value) =>
              ref.read(appearanceProvider.notifier).select(value),
        ),
        SizedBox(height: variables.space(2)),
        Text(
          'System follows your device’s appearance.\nChanges apply immediately.',
          style: supporting,
        ),
      ],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PageHeader(
          title: 'Settings',
          supportingText: 'Make Cat tinder feel right for you.',
        ),
        SizedBox(height: variables.space(6)),
        Container(
          padding: EdgeInsets.only(bottom: variables.space(5)),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: variables.colors.borderSecondary),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Appearance',
                style: variables.text.textLg.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: variables.space(1)),
              Text(
                'Choose how the app looks on your device.',
                style: supporting,
              ),
            ],
          ),
        ),
        SizedBox(height: variables.space(6)),
        LayoutBuilder(
          builder: (context, constraints) {
            final desktop =
                MediaQuery.sizeOf(context).width >=
                ApplicationLayout.desktopBreakpoint;
            if (desktop && MediaQuery.textScalerOf(context).scale(14) <= 21) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 280, child: label),
                  SizedBox(width: variables.space(8)),
                  Flexible(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: selection,
                    ),
                  ),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                label,
                SizedBox(height: variables.space(4)),
                selection,
              ],
            );
          },
        ),
      ],
    );
  }
}
