import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/job_category_data.dart';
import 'package:flutter/material.dart';

class JobCategorySelectionSheet extends StatefulWidget {
  final void Function(String, int, int) onSelect;
  final List<JobCategory> list;
  final int selectedCategoryIndex;
  final int selectedSubcategoryIndex;

  const JobCategorySelectionSheet({
    Key? key,
    required this.onSelect,
    required this.list,
    required this.selectedCategoryIndex,
    required this.selectedSubcategoryIndex,
  }) : super(key: key);

  @override
  State<JobCategorySelectionSheet> createState() =>
      _JobCategorySelectionSheetState();
}

class _JobCategorySelectionSheetState extends State<JobCategorySelectionSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<MapEntry<String, List<int>>> _filteredSubcategories = [];

  @override
  void initState() {
    super.initState();
    _filteredSubcategories = _getAllSubcategories(widget.list);
    _searchController.addListener(() {
      setState(() {
        _filteredSubcategories = _getAllSubcategories(widget.list)
            .where((subcategory) => subcategory.key
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  List<MapEntry<String, List<int>>> _getAllSubcategories(
      List<JobCategory> categories) {
    List<MapEntry<String, List<int>>> subcategories = [];
    for (int categoryIndex = 0;
        categoryIndex < categories.length;
        categoryIndex++) {
      for (int subcategoryIndex = 0;
          subcategoryIndex < categories[categoryIndex].subcategories.length;
          subcategoryIndex++) {
        String subcategory =
            categories[categoryIndex].subcategories[subcategoryIndex];
        subcategories
            .add(MapEntry(subcategory, [categoryIndex, subcategoryIndex]));
      }
    }
    return subcategories;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, List<int>>> sortedSubcategories =
        _filteredSubcategories;
    if (widget.selectedCategoryIndex >= 0 &&
        widget.selectedSubcategoryIndex >= 0) {
      final selectedSubcategory = sortedSubcategories.firstWhere(
        (subcategory) =>
            subcategory.value[0] == widget.selectedCategoryIndex &&
            subcategory.value[1] == widget.selectedSubcategoryIndex,
        orElse: () => MapEntry('', [-1, -1]),
      );
      sortedSubcategories = [
        if (selectedSubcategory.key.isNotEmpty) selectedSubcategory,
        ...sortedSubcategories.where(
          (subcategory) =>
              !(subcategory.value[0] == widget.selectedCategoryIndex &&
                  subcategory.value[1] == widget.selectedSubcategoryIndex),
        ),
      ];
    }

    return Scaffold(
      appBar: const GeneralAppBar(
        titleText: "Select Job Category",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputField(
                controller: _searchController,
                hint: "Search",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                textInputType: TextInputType.text,
                autofocus: true,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: sortedSubcategories.length,
                  itemBuilder: (context, index) {
                    final subcategory = sortedSubcategories[index].key;
                    final categoryIndex = sortedSubcategories[index].value[0];
                    final subcategoryIndex =
                        sortedSubcategories[index].value[1];
                    final isSelected =
                        categoryIndex == widget.selectedCategoryIndex &&
                            subcategoryIndex == widget.selectedSubcategoryIndex;
                    return ListTile(
                      title: Text(
                        subcategory,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                        ),
                      ),
                      leading: isSelected
                          ? Icon(Icons.check,
                              color: Theme.of(context).primaryColor)
                          : null,
                      onTap: () {
                        widget.onSelect(
                            subcategory, categoryIndex, subcategoryIndex);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
