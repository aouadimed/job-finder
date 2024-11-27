import 'package:cv_frontend/features/recruiter_applications/data/models/job_category_model.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/bloc/job_category_bloc/job_category_bloc.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/loading_widget.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobCategorySelectionSheet extends StatefulWidget {
  final void Function(String categoryId, String subcategoryId, String name)
      onSelect;
  final String selectedCategoryId;
  final String selectedSubcategoryId;

  const JobCategorySelectionSheet({
    Key? key,
    required this.onSelect,
    required this.selectedCategoryId,
    required this.selectedSubcategoryId,
  }) : super(key: key);

  @override
  State<JobCategorySelectionSheet> createState() =>
      _JobCategorySelectionSheetState();
}

class _JobCategorySelectionSheetState extends State<JobCategorySelectionSheet> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _fetchJobCategories();
  }

  void _fetchJobCategories() {
    context
        .read<JobCategoryBloc>()
        .add(const GetJobCategoryEvent(searshQuery: ''));
  }

  void _onSearchChanged() {
    context
        .read<JobCategoryBloc>()
        .add(GetJobCategoryEvent(searshQuery: _searchController.text));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: BlocBuilder<JobCategoryBloc, JobCategoryState>(
                  builder: (context, state) {
                    if (state is JobCategoryLoading) {
                      return const Center(child: LoadingWidget());
                    } else if (state is JobCategorySuccess) {
                      final jobCategories = state.jobCategoryModel;
                      final filteredCategories = _getFilteredCategories(
                          jobCategories, _searchController.text);

                      if (filteredCategories.isEmpty) {
                        return const Center(child: Text('No data available.'));
                      }

                      JobCategoryModel? selectedCategory;
                      Subcategory? selectedSubcategory;

                      if (widget.selectedCategoryId.isNotEmpty &&
                          widget.selectedSubcategoryId.isNotEmpty) {
                        selectedCategory = filteredCategories.firstWhere(
                          (category) => category.subcategories!.any(
                              (subcategory) =>
                                  subcategory.id ==
                                  widget.selectedSubcategoryId),
                          orElse: () =>
                              JobCategoryModel(name: '', subcategories: []),
                        );

                        selectedSubcategory = selectedCategory.subcategories!
                            .firstWhere(
                                (subcategory) =>
                                    subcategory.id ==
                                    widget.selectedSubcategoryId,
                                orElse: () => Subcategory(name: '', id: ''));
                      }

                      return ListView.builder(
                        itemCount: filteredCategories.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0 &&
                              selectedSubcategory != null &&
                              selectedSubcategory.id?.isNotEmpty == true) {
                            return ListTile(
                              title: Text(
                                selectedSubcategory.name ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              leading: Icon(Icons.check,
                                  color: Theme.of(context).primaryColor),
                              onTap: () {
                                final categoryId = selectedCategory?.id ?? '';
                                final subcategoryId =
                                    selectedSubcategory?.id ?? '';
                                final subcategoryName =
                                    selectedSubcategory?.name ?? '';

                                if (categoryId.isNotEmpty &&
                                    subcategoryId.isNotEmpty &&
                                    subcategoryName.isNotEmpty) {
                                  widget.onSelect(categoryId, subcategoryId,
                                      subcategoryName);
                                  Navigator.pop(context);
                                }
                              },
                            );
                          }

                          final categoryIndex =
                              selectedSubcategory == null ? index : index - 1;
                          if (categoryIndex < 0 ||
                              categoryIndex >= filteredCategories.length) {
                            return Container(); // Avoiding out-of-bound access
                          }

                          final category = filteredCategories[categoryIndex];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  category.name ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              ...category.subcategories!.map((subcategory) {
                                final isSelected = subcategory.id ==
                                    widget.selectedSubcategoryId;
                                return ListTile(
                                  title: Text(
                                    subcategory.name ?? '',
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
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
                                        category.id ?? '',
                                        subcategory.id ?? '',
                                        subcategory.name ?? '');
                                    Navigator.pop(context);
                                  },
                                );
                              }).toList(),
                            ],
                          );
                        },
                      );
                    } else if (state is JobCategoryFailure) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: Text('No data available.'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<JobCategoryModel> _getFilteredCategories(
      List<JobCategoryModel> categories, String query) {
    if (query.isEmpty) {
      return categories;
    }
    return categories
        .where((category) =>
            (category.name?.toLowerCase().contains(query.toLowerCase()) ??
                false) ||
            category.subcategories!.any((subcategory) =>
                subcategory.name?.toLowerCase().contains(query.toLowerCase()) ??
                false))
        .toList();
  }
}
