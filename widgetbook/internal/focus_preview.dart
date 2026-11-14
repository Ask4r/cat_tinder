import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Catalog controls live outside the preview's native traversal loop.
class FocusPreview extends StatefulWidget {
  const FocusPreview({super.key, required this.child, this.canFocus = true});

  final Widget child;
  final bool canFocus;

  @override
  State<FocusPreview> createState() => _FocusPreviewState();
}

class _FocusPreviewState extends State<FocusPreview> {
  final _entry = FocusNode(debugLabel: 'Catalog focus preview action');
  final _preview = FocusScopeNode(
    debugLabel: 'Catalog preview',
    traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
  );

  @override
  void dispose() {
    _preview.dispose();
    _entry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextButton(
        focusNode: _entry,
        onPressed: () {
          if (widget.canFocus) _preview.nextFocus();
        },
        child: const Text('Focus preview'),
      ),
      Text(
        widget.canFocus
            ? 'Tab / Shift+Tab: traverse preview · Escape: return to catalog'
            : 'Enable a focusable control in the preview to use keyboard traversal.',
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 24),
      FocusScope(
        node: _preview,
        onKeyEvent: (_, event) {
          if (event.logicalKey == LogicalKeyboardKey.escape) {
            if (event is KeyDownEvent) _entry.requestFocus();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: widget.child,
      ),
    ],
  );
}
