import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'internal/catalog_theme.dart';
import 'ui/widgets/assets/app_icon/playground.dart';
import 'ui/widgets/base/app_button/sheet.dart';
import 'ui/widgets/base/app_button/playground.dart';
import 'ui/widgets/application/empty_state/sheet.dart';
import 'ui/widgets/application/empty_state/playground.dart';
import 'ui/widgets/assets/featured_icon/sheet.dart';
import 'ui/widgets/assets/featured_icon/playground.dart';
import 'ui/widgets/base/app_tooltip/sheet.dart';
import 'ui/widgets/base/app_tooltip/playground.dart';

import 'ui/widgets/application/horizontal_tabs/sheet.dart';
import 'ui/widgets/application/horizontal_tabs/playground.dart';
import 'app/pages/settings/theme_selector/playground.dart';

import 'ui/widgets/assets/loading_indicator/playground.dart';
import 'ui/widgets/application/loading_state/sheet.dart';
import 'ui/widgets/application/loading_state/playground.dart';

void main() => runApp(const ComponentCatalog());

class ComponentCatalog extends StatelessWidget {
  const ComponentCatalog({super.key});

  @override
  Widget build(BuildContext context) => Widgetbook.material(
    directories: [
      WidgetbookFolder(
        isInitiallyExpanded: false,
        name: 'base',
        children: [
          WidgetbookComponent(
            isInitiallyExpanded: false,
            name: 'AppButton',
            useCases: [
              for (final iconButtons in [false, true])
                ..._sheetUseCases(
                  sheet: ButtonSheet(iconButtons: iconButtons),
                  name: iconButtons ? 'Icon-only variants' : 'All variants',
                ),
              WidgetbookUseCase(
                name: 'Playground',
                builder: buildButtonPlayground,
              ),
            ],
          ),
          _component(
            name: 'AppTooltip',
            sheet: const TooltipSheet(),
            playground: buildTooltipPlayground,
          ),
        ],
      ),
      WidgetbookFolder(
        isInitiallyExpanded: false,
        name: 'application',
        children: [
          _component(
            name: 'EmptyState',
            sheet: const EmptyStateSheet(),
            playground: buildEmptyStatePlayground,
          ),
          _component(
            name: 'HorizontalTabs',
            sheet: const HorizontalTabsSheet(),
            playground: buildHorizontalTabsPlayground,
          ),
          _component(
            name: 'ThemeSelector',
            playground: buildThemeSelectorPlayground,
          ),
          _component(
            name: 'LoadingState',
            sheet: const LoadingStateSheet(),
            playground: buildLoadingStatePlayground,
          ),
        ],
      ),
      WidgetbookFolder(
        isInitiallyExpanded: false,
        name: 'assets',
        children: [
          _component(name: 'AppIcon', playground: buildAppIconPlayground),
          _component(
            name: 'FeaturedIcon',
            sheet: const FeaturedIconSheet(),
            playground: buildFeaturedIconPlayground,
          ),
          _component(
            name: 'LoadingIndicator',
            playground: buildLoadingIndicatorPlayground,
          ),
        ],
      ),
    ],
  );
}

WidgetbookComponent _component({
  required String name,
  Widget? sheet,
  required WidgetBuilder playground,
}) => WidgetbookComponent(
  isInitiallyExpanded: false,
  name: name,
  useCases: [
    if (sheet != null) ..._sheetUseCases(sheet: sheet),
    WidgetbookUseCase(name: 'Playground', builder: playground),
  ],
);

List<WidgetbookUseCase> _sheetUseCases({
  required Widget sheet,
  String name = 'All variants',
}) => [
  for (final dark in [false, true])
    WidgetbookUseCase(
      name: '$name — ${dark ? "dark" : "light"}',
      builder: (_) => buildCatalogTheme(
        dark: dark,
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: sheet,
          ),
        ),
      ),
    ),
];
