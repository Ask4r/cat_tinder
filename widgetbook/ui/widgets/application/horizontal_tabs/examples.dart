import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/assets/app_icon.dart';
import 'package:cat_tinder/ui/widgets/application/tab_item.dart';
import 'package:flutter/material.dart';

/// Sample unmanaged slot content, not another production badge component.
class CatalogTabBadge extends StatelessWidget {
  const CatalogTabBadge(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: context.ui.colors.bgSecondary,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: context.ui.colors.borderSecondary),
    ),
    child: Text(
      text,
      style: context.ui.text.textXs.copyWith(
        color: context.ui.colors.textSecondary,
      ),
    ),
  );
}

List<TabItem<String>> catalogTabItems({
  bool slots = false,
  bool overflow = false,
}) => [
  for (var i = 0; i < 3; i++)
    TabItem(
      value: 'item-$i',
      label: overflow
          ? [
              'Account overview',
              'Notification preferences',
              'Connected applications',
            ][i]
          : ['Overview', 'Details', 'Activity'][i],
      enabled: i != 2,
      leading: slots ? const AppIcon('placeholder') : null,
      badge: slots ? CatalogTabBadge('${i + 2}') : null,
      tooltip: i == 2 ? 'This tab is unavailable.' : null,
      semanticIdentifier: 'catalog-tab-$i',
    ),
];
