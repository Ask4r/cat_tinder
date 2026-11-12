import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Preserve normal column layout, but paint the moving card over the page copy.
class CardForegroundColumn extends Column {
  const CardForegroundColumn({
    super.key,
    required this.cardIndex,
    required super.children,
  }) : super(crossAxisAlignment: CrossAxisAlignment.stretch);

  final int cardIndex;

  @override
  RenderFlex createRenderObject(BuildContext context) => _CardForegroundFlex(
    cardIndex: cardIndex,
    textDirection: Directionality.of(context),
  );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderFlex renderObject,
  ) {
    super.updateRenderObject(context, renderObject);
    (renderObject as _CardForegroundFlex).cardIndex = cardIndex;
  }
}

class _CardForegroundFlex extends RenderFlex {
  _CardForegroundFlex({required this.cardIndex, required super.textDirection})
    : super(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
      );

  int cardIndex;

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? card;
    var index = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      final data = child.parentData! as FlexParentData;
      if (index == cardIndex) {
        card = child;
      } else {
        context.paintChild(child, offset + data.offset);
      }
      child = data.nextSibling;
      index++;
    }
    if (card != null) {
      context.paintChild(
        card,
        offset + (card.parentData! as FlexParentData).offset,
      );
    }
  }
}
