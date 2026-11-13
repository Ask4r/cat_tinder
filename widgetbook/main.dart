import 'package:cat_tinder/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'button_sheet.dart';
import 'button_playground.dart';

void main() => runApp(const ButtonCatalog());

class ButtonCatalog extends StatelessWidget {
  const ButtonCatalog({super.key});

  @override
  Widget build(BuildContext context) => Widgetbook.material(
    directories: [
      WidgetbookComponent(
        name: 'AppButton',
        useCases: [
          for (final dark in [false, true])
            WidgetbookUseCase(
              name: dark ? 'All variants — dark' : 'All variants — light',
              builder: (_) => Theme(
                data: appTheme(
                  variables: UiVariables(colors: UiColors(dark: dark)),
                ),
                child: Material(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: const ButtonSheet(),
                    ),
                  ),
                ),
              ),
            ),
          WidgetbookUseCase(name: 'Playground', builder: buildButtonPlayground),
        ],
      ),
    ],
  );
}
