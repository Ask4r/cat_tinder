import 'package:flutter/widgets.dart';

@immutable
class TabItem<T> {
  const TabItem({
    required this.value,
    required this.label,
    this.enabled = true,
    this.leading,
    this.badge,
    this.tooltip,
    this.semanticIdentifier,
  });

  final T value;
  final String label;
  final bool enabled;
  final Widget? leading;
  final Widget? badge;
  final String? tooltip;
  final String? semanticIdentifier;
}
