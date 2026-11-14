import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/application/horizontal_tabs.dart';
import 'package:flutter/material.dart';

import 'examples.dart';

/// Desktop tab compositions; incomplete native select variants are excluded.
class HorizontalTabsSheet extends StatelessWidget {
  const HorizontalTabsSheet({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.ui.colors.bgPrimary,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Table(
        defaultColumnWidth: const FixedColumnWidth(560),
        children: [
          for (final style in HorizontalTabsStyle.values)
            for (final size in TabSize.values)
              TableRow(
                children: [
                  for (final example in [_Example.intrinsic, _Example.expanded])
                    _SheetExample(style: style, size: size, example: example),
                ],
              ),
          const TableRow(
            children: [
              _SheetExample(
                style: HorizontalTabsStyle.underline,
                size: TabSize.sm,
                example: _Example.overflowing,
              ),
              _SheetExample(
                style: HorizontalTabsStyle.minimal,
                size: TabSize.md,
                example: _Example.overflowing,
              ),
            ],
          ),
          const TableRow(
            children: [
              _SheetExample(
                style: HorizontalTabsStyle.border,
                size: TabSize.md,
                example: _Example.overflowing,
              ),
              _SheetExample(
                style: HorizontalTabsStyle.brand,
                size: TabSize.sm,
                example: _Example.overflowing,
              ),
            ],
          ),
          const TableRow(
            children: [
              _SheetExample(
                style: HorizontalTabsStyle.underline,
                size: TabSize.sm,
                example: _Example.disabled,
              ),
              _SheetExample(
                style: HorizontalTabsStyle.gray,
                size: TabSize.md,
                example: _Example.disabled,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

enum _Example {
  intrinsic('Intrinsic'),
  expanded('Full width + slots', fullWidth: true, slots: true),
  overflowing('Overflow', width: 240, overflow: true),
  disabled('Disabled', enabled: false);

  const _Example(
    this.label, {
    this.width = 528,
    this.fullWidth = false,
    this.slots = false,
    this.overflow = false,
    this.enabled = true,
  });

  final String label;
  final double width;
  final bool fullWidth, slots, overflow, enabled;
}

class _SheetExample extends StatefulWidget {
  const _SheetExample({
    this.style = HorizontalTabsStyle.underline,
    required this.size,
    required this.example,
  });
  final HorizontalTabsStyle style;
  final TabSize size;
  final _Example example;
  @override
  State<_SheetExample> createState() => _SheetExampleState();
}

class _SheetExampleState extends State<_SheetExample> {
  String value = 'item-0';
  @override
  Widget build(BuildContext context) => ClipRect(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${widget.style.name} / ${widget.size.name} / ${widget.example.label}',
            style: context.ui.text.textXs.copyWith(
              color: context.ui.colors.textTertiary,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: widget.example.width,
            child: HorizontalTabs<String>(
              style: widget.style,
              size: widget.size,
              fullWidth: widget.example.fullWidth,
              value: value,
              items: catalogTabItems(
                slots: widget.example.slots,
                overflow: widget.example.overflow,
              ),
              onChanged: widget.example.enabled
                  ? (next) => setState(() => value = next)
                  : null,
            ),
          ),
        ],
      ),
    ),
  );
}
