import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/categorie_selection_model.dart';

class ChipWidgetCategorySelection extends StatelessWidget {
  final List<CategorySelectionModel> items;
  final Function(String? categoryId) onSelected;
  final String? selectedCategoryId;

  const ChipWidgetCategorySelection({
    Key? key,
    required this.items,
    required this.onSelected,
    required this.selectedCategoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: _buildChips(),
    );
  }

  List<Widget> _buildChips() {
    List<Widget> chips = [
      _buildChip('All', "", true),
    ];
    chips.addAll(items.map((item) {
      return _buildChip(item.categoryName ?? 'Unknown', item.categoryId, false);
    }).toList());
    return chips;
  }

  Widget _buildChip(String label, String? id, bool all) {
    final bool isSelected = id == selectedCategoryId;
    return GestureDetector(
      onTap: () {
        if (label != 'All') {
          onSelected(id);
        }
      },
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: all
                ? Colors.white
                : isSelected
                    ? Colors.white
                    : primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: all
            ? primaryColor
            : isSelected
                ? primaryColor
                : whiteColor,
        side: BorderSide(color: primaryColor, width: 2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
