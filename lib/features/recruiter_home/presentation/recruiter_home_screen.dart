import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:flutter/material.dart';

class RecruiterHomeScreen extends StatefulWidget {
  const RecruiterHomeScreen({super.key});

  @override
  State<RecruiterHomeScreen> createState() => _RecruiterApplicantScreenState();
}

class _RecruiterApplicantScreenState extends State<RecruiterHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final String companyName = "Medianet";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        logo: const AssetImage("assets/images/logo.webp"),
        titleText: 'Welcome ,$companyName !',
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            const SizedBox(height: 10),
            InputField(
              controller: _searchController,
              hint: "Search",
              prefixIcon: Icon(Icons.search, color: greyColor),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: greyColor),
                      onPressed: () {
                        _searchController.clear();
                        //  _handleSearch(''); // Clear search query
                      },
                    )
                  : null,
              textInputType: TextInputType.text,
              onChanged: (value) {},
            )
          ]),
        ),
      )),
    );
  }
}
