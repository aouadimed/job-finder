import 'package:cv_frontend/global/common_widget/single_select.dart';
import 'package:cv_frontend/global/utils/country_data.dart';
import 'package:flutter/material.dart';

class CountryList extends StatefulWidget {
  final TextEditingController? searchController;

  const CountryList({Key? key, this.searchController}) : super(key: key);

  @override
  _CountryListState createState() => _CountryListState();

  String getSelectedCountry() {
    return _CountryListState.selectedCountry;
  }
}

class _CountryListState extends State<CountryList> {
  final List<String> _allCountries = allCountries;
  static late String selectedCountry;

  List<String> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    _filteredCountries = _allCountries;
    selectedCountry = '';
    widget.searchController?.addListener(_searchCountries);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _filteredCountries.length,
      itemBuilder: (context, index) {
        final country = _filteredCountries[index];
        return SingleSelect(
          isSelected: country == selectedCountry,
          text: country,
          onPressed: () {
            setState(() {
              selectedCountry = country;
            });
          },
        );
      },
    );
  }

  void _searchCountries() {
    final query = widget.searchController?.text.toLowerCase() ?? '';
    setState(() {
      _filteredCountries = _allCountries
          .where((country) => country.toLowerCase().contains(query))
          .toList();
    });
  }
}
