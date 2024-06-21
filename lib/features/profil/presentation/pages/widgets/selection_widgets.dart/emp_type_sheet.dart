import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/utils/emploments_type_data.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/global/common_widget/single_select.dart';

class EmpTypeSheet extends StatelessWidget {
  final void Function(String, int) onSelect;
  final int selectedIndex;
  const EmpTypeSheet({
    Key? key, 
    required this.onSelect, 
    required this.selectedIndex
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
          ...List.generate(employmentTypes.length, (index) {
            return SingleSelect(
              isSelected: selectedIndex == index,
              text: employmentTypes[index],
              onPressed: () {
                onSelect(employmentTypes[index], index);
              },
            );
          }),
        ],
      ),
    );
  }
}