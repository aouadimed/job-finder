import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class ChipSelection extends StatefulWidget {
  final List<String> selectOptions;
  final ValueChanged<int> onSelected;
  final int initialSelectedIndex;

  const ChipSelection({
    Key? key,
    required this.selectOptions,
    required this.onSelected,
    this.initialSelectedIndex = 0,
  }) : super(key: key);

  @override
  State<ChipSelection> createState() => _ChipSelectionState();
}

class _ChipSelectionState extends State<ChipSelection> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: List<Widget>.generate(widget.selectOptions.length, (index) {
        final bool isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onSelected(index);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : whiteColor,
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.selectOptions[index],
              style: TextStyle(
                color: isSelected ? Colors.white : primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }),
    );
  }
}
