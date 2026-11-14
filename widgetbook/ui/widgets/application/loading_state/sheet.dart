import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/application/loading_state.dart';
import 'package:flutter/material.dart';

class LoadingStateSheet extends StatelessWidget {
  const LoadingStateSheet({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.ui.colors.bgPrimary,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 32,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final example in [
            (
              label: 'Default content / 400px',
              width: 400.0,
              text: 'Loading...',
              size: LoadingStateSize.md,
            ),
            (
              label: 'Long content / 400px',
              width: 400.0,
              text: 'We are preparing the next photograph. This message demonstrates how longer supporting text wraps within the available width.',
              size: LoadingStateSize.md,
            ),
            (
              label: 'Narrow / 200px',
              width: 200.0,
              text: 'Loading...',
              size: LoadingStateSize.sm,
            ),
          ])
            SizedBox(
              width: example.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    example.label,
                    style: context.ui.text.textXs.copyWith(
                      color: context.ui.colors.textTertiary,
                    ),
                  ),
                  LoadingState(size: example.size, text: example.text),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
