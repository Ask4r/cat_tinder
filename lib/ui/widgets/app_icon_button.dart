import 'package:flutter/material.dart';

import 'app_button.dart';

/// The square icon-button family shares the native button recipe.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.label,
    this.hierarchy = AppButtonHierarchy.secondary,
    this.size = AppButtonSize.md,
    this.onPressed,
    this.loading = false,
  }) : assert(
         hierarchy != AppButtonHierarchy.linkColor &&
             hierarchy != AppButtonHierarchy.linkGray,
       );

  final String icon;
  final String label;
  final AppButtonHierarchy hierarchy;
  final AppButtonSize size;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) => AppButton(
    label: label,
    icon: icon,
    iconOnly: true,
    hierarchy: hierarchy,
    size: size,
    onPressed: onPressed,
    loading: loading,
  );
}
