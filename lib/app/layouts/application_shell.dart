import 'package:flutter/material.dart';

import '../pages/settings/settings_page.dart';
import '../pages/discover/discover_page.dart';

import 'package:cat_tinder/ui/theme.dart';

import 'application_header.dart';
import 'application_layout.dart';

import 'package:cat_tinder/ui/widgets/application/horizontal_tabs.dart';

class ApplicationShell extends StatefulWidget {
  const ApplicationShell({
    super.key,
    required this.selected,
    required this.onSelected,
  });
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  State<ApplicationShell> createState() => _ApplicationShellState();
}

class _ApplicationShellState extends State<ApplicationShell> {
  // Preserve the strip and retained views when Flutter recreates the keyed
  // scrollable to restore the selected tab's PageStorage position.
  final _contentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final desktop =
        MediaQuery.sizeOf(context).width >= ApplicationLayout.desktopBreakpoint;
    return Scaffold(
      backgroundColor: context.ui.colors.bgPrimary,
      body: SafeArea(
        child: Column(
          children: [
            const ApplicationHeader(),
            Expanded(
              child: Overlay.wrap(
                child: SingleChildScrollView(
                  key: PageStorageKey('application-scroll-${widget.selected}'),
                  primary: false,
                  padding: EdgeInsets.only(
                    top: desktop ? context.ui.space(8) : context.ui.space(6),
                    bottom: context.ui.space(12),
                  ),
                  child: ApplicationFrame(
                    key: _contentKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HorizontalTabs<String>(
                          tooltipViewportPadding: EdgeInsets.all(
                            ApplicationLayout.containerPadding(context),
                          ),
                          tooltipViewportMaxWidth: ApplicationLayout.maxWidth,
                          value: widget.selected,
                          items: const [
                            TabItem(value: 'discover', label: 'Discover'),
                            TabItem(
                              value: 'breeds',
                              label: 'Breeds',
                              enabled: false,
                              tooltip: 'Breed browsing is not available yet.',
                              semanticIdentifier: 'breeds_tab',
                            ),
                            TabItem(
                              value: 'settings',
                              label: 'Settings',
                              semanticIdentifier: 'settings_tab',
                            ),
                          ],
                          onChanged: widget.onSelected,
                        ),
                        SizedBox(height: context.ui.space(6)),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            _TabView(
                              active: widget.selected == 'discover',
                              child: const DiscoverPage(),
                            ),
                            _TabView(
                              active: widget.selected == 'settings',
                              child: const SettingsPage(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabView extends StatelessWidget {
  const _TabView({required this.active, required this.child});
  final bool active;
  final Widget child;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: active ? 1 : 0, end: active ? 1 : 0),
    duration: MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 200),
    curve: Curves.easeInOut,
    builder: (context, opacity, child) => Offstage(
      offstage: !active && opacity == 0,
      child: Opacity(opacity: opacity, child: child),
    ),
    child: IgnorePointer(
      ignoring: !active,
      child: ExcludeSemantics(
        excluding: !active,
        child: ExcludeFocus(
          excluding: !active,
          child: TickerMode(enabled: active, child: child),
        ),
      ),
    ),
  );
}
