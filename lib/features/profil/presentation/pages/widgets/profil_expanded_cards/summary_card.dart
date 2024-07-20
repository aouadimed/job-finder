import 'package:flutter/material.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/comman_expandable.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class SummaryCard extends StatelessWidget {
  final VoidCallback? iconOnPressed;
  final String summaryDescription;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;
  final GlobalKey sectionKey;

  const SummaryCard({
    Key? key,
    required this.iconOnPressed,
    required this.summaryDescription,
    required this.isExpanded,
    required this.onExpansionChanged,
    required this.sectionKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasDescription = summaryDescription.isNotEmpty;

    return CommonExpandableList<String>(
      icon: hasDescription ? Icons.edit : Icons.add,
      iconOnPressed: iconOnPressed,
      items: hasDescription ? [summaryDescription] : [],
      headerTitle: "Summary",
      itemBuilder: (item) {
        return Text(
          item ,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        );
      },
      headerIcon: Icons.summarize_rounded,
      isExpanded: isExpanded,
      onExpansionChanged: onExpansionChanged,
      sectionKey: sectionKey,
    );
  }
}
