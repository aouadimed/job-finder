import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/global/common_widget/single_select.dart';

class SelectionSheet extends StatelessWidget {
  final void Function(String, int) onSelect;
  final int selectedIndex;
  final List<String> list;
  const SelectionSheet(
      {Key? key,
      required this.onSelect,
      required this.selectedIndex,
      required this.list})
      : super(key: key);

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
              isSelected: selectedIndex == index,
              text: list[index],
              onPressed: () {
                onSelect(list[index], index);
              },
            );
          }),
        ],
      ),
    );
  }
}
