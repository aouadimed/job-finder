  import 'package:cv_frontend/global/utils/country_code_data.dart';
import 'package:cv_frontend/global/utils/job_category_data.dart';

String countryCodeFromCountryName(String countryName) {
    String? countryCode = countryNameToCode[countryName];
    return countryCode ?? '';
  }



List<Map<String, int>> findMatchingSubcategories(String query, List<JobCategory> jobCategories) {
  List<Map<String, int>> matches = [];
  final lowerCaseQuery = query.toLowerCase();

  for (int categoryIndex = 0; categoryIndex < jobCategories.length; categoryIndex++) {
    final category = jobCategories[categoryIndex];
    for (int subcategoryIndex = 0; subcategoryIndex < category.subcategories.length; subcategoryIndex++) {
      final subcategory = category.subcategories[subcategoryIndex].toLowerCase();
      if (subcategory.contains(lowerCaseQuery)) {
        matches.add({
          'categoryIndex': categoryIndex,
          'subcategoryIndex': subcategoryIndex
        });
      }
    }
  }
  return matches;
}

