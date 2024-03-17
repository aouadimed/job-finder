import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'widgets/country_list.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  late TextEditingController _searchController;
  late CountryList _countryList;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _countryList = CountryList(searchController: _searchController);
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenearalAppBar(titleText: "Your country"),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InputField(
                controller: _searchController,
                hint: "Search",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                textInputType: TextInputType.text,
              ),
            ),
            Expanded(
              child: CountryList(
                searchController: _searchController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BigButton(
                text: 'Continue',
                onPressed: () {
                  if (_countryList.getSelectedCountry().isNotEmpty) {
                    print(_countryList.getSelectedCountry());
                  } else {
                    showSnackBar(
                      context: context,
                      message: 'Select a country '
                          'first !',
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
