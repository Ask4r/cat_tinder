import 'package:flutter/material.dart';

import 'package:cat_tinder/ui/theme.dart';

// Application layout choices, not shared atomic UI measurements.
abstract final class ApplicationLayout {
  static const desktopBreakpoint = 768.0;
  static const maxWidth = 1280.0;
}

/// The desktop frame includes its 32px gutters in the 1280px maximum.
class ApplicationFrame extends StatelessWidget {
  const ApplicationFrame({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: ApplicationLayout.maxWidth),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.sizeOf(context).width >=
                    ApplicationLayout.desktopBreakpoint
                ? context.ui.space(8)
                : context.ui.space(4),
          ),
          child: child,
        ),
      ),
    ),
  );
}
