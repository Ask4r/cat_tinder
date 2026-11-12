import 'package:flutter/material.dart';

import '../theme.dart';
import 'app_icon.dart';
import 'tab_item.dart';
import 'tab_button.dart';

/// Native selection and keyboard handling for the mobile horizontal-tabs variant.
class TabsSelect<T> extends StatelessWidget {
  const TabsSelect({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.size = TabSize.sm,
  });

  final List<TabItem<T>> items;
  final T value;
  final ValueChanged<T>? onChanged;
  final TabSize size;

  @override
  Widget build(BuildContext context) {
    final v = context.ui;
    final md = size == TabSize.md;
    return Container(
      constraints: BoxConstraints(minHeight: md ? 44 : 36),
      padding: EdgeInsets.symmetric(horizontal: v.space(3)),
      decoration: BoxDecoration(
        color: v.colors.bgPrimary,
        border: Border.all(color: v.colors.borderPrimary),
        borderRadius: BorderRadius.circular(v.radii.md),
        boxShadow: [v.effects.shadowXs],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          isDense: true,
          borderRadius: BorderRadius.circular(v.radii.md),
          dropdownColor: v.colors.bgPrimary,
          style: (md ? v.text.textMd : v.text.textSm).copyWith(
            color: v.colors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          icon: AppIcon('chevron-down', color: v.colors.fgQuaternary),
          onChanged: onChanged == null
              ? null
              : (next) {
                  if (next != null && next != value) onChanged!(next);
                },
          items: [
            for (final item in items)
              DropdownMenuItem(
                value: item.value,
                enabled: item.enabled,
                child: Text(item.label),
              ),
          ],
        ),
      ),
    );
  }
}
