
import 'package:flutter/material.dart';

void scrollToSection(BuildContext context, ScrollController scrollController, GlobalKey key) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final renderObject = key.currentContext?.findRenderObject();
    if (renderObject is RenderBox) {
      final RenderBox box = renderObject;
      final Offset position = box.localToGlobal(Offset.zero);
      final double offset = position.dy;
      final double screenHeight = MediaQuery.of(context).size.height;
      final double itemHeight = box.size.height;

      if (offset + itemHeight > screenHeight) {
        scrollController.animateTo(
          scrollController.offset +
              (offset + itemHeight - screenHeight + 16),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        scrollController.animateTo(
          scrollController.offset + offset - 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  });
}
