import 'package:flutter/material.dart';

import 'package:cat_tinder/ui/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'application_layout.dart' show ApplicationFrame, ApplicationLayout;

/// Application header with desktop and mobile sizing.
class ApplicationHeader extends StatelessWidget {
  const ApplicationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final desktop =
        MediaQuery.sizeOf(context).width >= ApplicationLayout.desktopBreakpoint;
    return Container(
      constraints: BoxConstraints(minHeight: desktop ? 64 : 56),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.ui.colors.borderSecondary),
        ),
      ),
      child: ApplicationFrame(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: desktop ? context.ui.space(4) : context.ui.space(3),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/app-logo.svg',
                width: 24,
                height: 24,
                excludeFromSemantics: true,
                colorMapper: _BrandColors(context.ui.colors),
              ),
              SizedBox(width: context.ui.space(2)),
              Expanded(
                child: Text(
                  'Cat tinder',
                  style: context.ui.text.textXl.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandColors extends ColorMapper {
  const _BrandColors(this.colors);
  final UiColors colors;

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) => switch (color.toARGB32()) {
    0xFFFBBF24 => colors.brand400,
    0xFFD97706 => colors.brand600,
    0xFFF59E0B => colors.brand500,
    0xFFFDE68A => colors.brand200,
    0xFF92400E => colors.brand800,
    _ => color,
  };

  @override
  bool operator ==(Object other) =>
      other is _BrandColors && colors == other.colors;

  @override
  int get hashCode => colors.hashCode;
}
