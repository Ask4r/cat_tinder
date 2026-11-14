import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/base/app_tooltip.dart';
import 'package:flutter/material.dart';

import '../../../../internal/constrained_preview.dart';

const tooltipMessage = 'This is a tooltip';
const tooltipSupportingText =
    'Tooltips provide extra information about the element they describe.';

String tooltipTargetId(TooltipArrow arrow, bool supporting) =>
    '${arrow.name}-${supporting ? "supporting" : "message"}';

/// Each viewport owns its real overlay so neighboring examples cannot collide.
class TooltipViewport extends StatelessWidget {
  const TooltipViewport({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      ConstrainedPreview(child: Overlay.wrap(child: child));
}

class TooltipSheet extends StatelessWidget {
  const TooltipSheet({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.ui.colors.bgPrimary,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Table(
        defaultColumnWidth: const FixedColumnWidth(840),
        children: [
          for (final arrow in TooltipArrow.values)
            TableRow(
              children: [
                for (final supporting in [false, true])
                  SizedBox(
                    height: 320,
                    child: TooltipViewport(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 12,
                            left: 16,
                            child: Text(
                              '${arrow.name} / ${supporting ? "supporting text" : "message only"}',
                              style: context.ui.text.textXs.copyWith(
                                color: context.ui.colors.textTertiary,
                              ),
                            ),
                          ),
                          Center(
                            child: AppTooltip(
                              message: tooltipMessage,
                              supportingText: supporting
                                  ? tooltipSupportingText
                                  : null,
                              arrow: arrow,
                              child: Container(
                                key: ValueKey(
                                  tooltipTargetId(arrow, supporting),
                                ),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: context.ui.colors.bgSecondary,
                                  borderRadius: BorderRadius.circular(
                                    context.ui.radii.sm,
                                  ),
                                ),
                                child: const Text('Hover / hold'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    ),
  );
}
