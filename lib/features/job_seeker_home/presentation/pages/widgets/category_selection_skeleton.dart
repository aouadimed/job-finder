import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChipWidgetCategorySelectionSkeleton extends StatelessWidget {
  const ChipWidgetCategorySelectionSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: List.generate(5, (index) => _buildShimmerChip()),
    );
  }

  Widget _buildShimmerChip() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Chip(
        label: Container(
          width: 60,
          height: 16,
          color: Colors.grey,
        ),
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}
