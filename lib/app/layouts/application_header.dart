import 'package:flutter/material.dart';

import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/app_icon.dart';

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
              AppIcon('paw', size: 24, color: context.ui.colors.textTertiary),
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
