import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../theme.dart';

enum TooltipArrow {
  none,
  topCenter,
  bottomCenter,
  bottomLeft,
  bottomRight,
  left,
  right,
}

/// Figma styling; Forui owns gestures, overlay geometry and arrow adjustment.
class AppTooltip extends StatelessWidget {
  const AppTooltip({
    super.key,
    required this.message,
    required this.child,
    this.supportingText,
    this.arrow = TooltipArrow.topCenter,
  });

  final String message;
  final String? supportingText;
  final TooltipArrow arrow;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final v = context.ui;
    final supporting = supportingText;
    final (tipAnchor, childAnchor) = switch (arrow) {
      TooltipArrow.none ||
      TooltipArrow.topCenter => (Alignment.topCenter, Alignment.bottomCenter),
      TooltipArrow.bottomCenter => (
        Alignment.bottomCenter,
        Alignment.topCenter,
      ),
      TooltipArrow.bottomLeft => (Alignment.bottomLeft, Alignment.topCenter),
      TooltipArrow.bottomRight => (Alignment.bottomRight, Alignment.topCenter),
      TooltipArrow.left => (Alignment.centerLeft, Alignment.centerRight),
      TooltipArrow.right => (Alignment.centerRight, Alignment.centerLeft),
    };
    final hasArrow = arrow != TooltipArrow.none;
    final corner =
        arrow == TooltipArrow.bottomLeft || arrow == TooltipArrow.bottomRight;
    final style = v.text.textXs.copyWith(
      color: v.colors.textWhite,
      fontWeight: FontWeight.w600,
    );
    final reducedMotion = MediaQuery.disableAnimationsOf(context);
    return FAccessibilityScope(
      child: Semantics(
        tooltip: supporting == null ? message : '$message\n$supporting',
        child: FTooltip(
          tipAnchor: tipAnchor,
          childAnchor: childAnchor,
          spacing: _TooltipSpacing(
            v.space(2) + (hasArrow ? 6 : 0),
            cornerInset: corner ? 20 : 0,
          ),
          arrow: hasArrow ? FPortalArrowAlignment.childCenter : null,
          overflow: FPortalOverflow.flip,
          hover: true,
          longPress: true,
          style: FTooltipStyle(
            decoration: ShapeDecoration(
              color: v.colors.bgPrimarySolid,
              shadows: v.effects.shadowLg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(v.radii.md),
              ),
            ),
            textStyle: style,
            hapticFeedback: () => Feedback.forLongPress(context),
            padding: EdgeInsets.symmetric(
              horizontal: v.space(3),
              vertical: v.space(supporting == null ? 2 : 3),
            ),
            constraints: supporting == null
                ? const BoxConstraints()
                : const BoxConstraints(maxWidth: 320),
            arrowStyle: const FPortalArrowStyle(
              width: 16,
              height: 6,
              baseRadius: 0,
              tipRadius: 0,
            ),
            hoverEnterDuration:
                TooltipTheme.of(context).waitDuration ??
                const Duration(milliseconds: 500),
            longPressExitDuration:
                TooltipTheme.of(context).showDuration ??
                const Duration(milliseconds: 1500),
            motion: FTooltipMotion(
              entranceDuration: reducedMotion
                  ? Duration.zero
                  : const Duration(milliseconds: 150),
              exitDuration: reducedMotion
                  ? Duration.zero
                  : const Duration(milliseconds: 75),
              scaleTween: const FImmutableTween(begin: 1, end: 1),
            ),
          ),
          tipBuilder: (_, _) => supporting == null
              ? Text(message)
              : SizedBox(
                  width: 296,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(message),
                      SizedBox(height: v.space(.5)),
                      Text(
                        supporting,
                        style: v.text.textXs.copyWith(
                          color: v.colors.tooltipSupportingText,
                        ),
                      ),
                    ],
                  ),
                ),
          child: child,
        ),
      ),
    );
  }
}

/// Fixed design offsets applied before Forui's collision handling.
class _TooltipSpacing implements FPortalSpacing {
  const _TooltipSpacing(this.gap, {this.cornerInset = 0});

  final double gap;
  final double cornerInset;

  @override
  Offset call(Alignment child, Alignment portal) =>
      FPortalSpacing(gap)(child, portal) + Offset(portal.x * cornerInset, 0);
}
