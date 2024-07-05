import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/global/common_widget/single_select.dart';

class SelectionAssoSheet extends StatelessWidget {
  final void Function(String id, String item) onSelect;
  final String? selectedId;
  final List<String> list;
  final List<String?> ids;

  const SelectionAssoSheet({
    Key? key,
    required this.onSelect,
    required this.selectedId,
    required this.list,
    required this.ids,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: 80,
            height: 8,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          ...List.generate(list.length, (index) {
            return SingleSelect(
              isSelected: selectedId == ids[index],
              text: list[index],
              onPressed: () {
                onSelect(ids[index]!, list[index]);
              },
            );
          }),
        ],
      ),
    );
  }
}
