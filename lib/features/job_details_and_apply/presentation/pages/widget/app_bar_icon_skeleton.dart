import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GeneralAppBarIconSkeleton extends StatelessWidget {
  const GeneralAppBarIconSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: const Icon(Icons.bookmark_border, color: Colors.grey),
    );
  }
}
