import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/home/presentation/pages/widgets/job_card.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar (),
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              const Expanded(
                  child: Text(
                "Recommendation",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )),
              InkWell(
                onTap: () => {},
                child: Text(
                  "See All",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600),
                ),
              )
            ]),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                JobCard(
                    companyName: 'Google LLC',
                    jobTitle: 'UI/UX Designer',
                    location: 'California, United States',
                    jobType: 'Full Time',
                    workType: 'Onsite',
                    companyLogoUrl:
                        'https://logo.clearbit.com/google.com', // Corrected logo URL
                    onSave: () {
                      print('Job saved');
                      // Implement your save logic here
                    }), JobCard(
                    companyName: 'Google LLC',
                    jobTitle: 'UI/UX Designer',
                    location: 'California, United States',
                    jobType: 'Full Time',
                    workType: 'Onsite',
                    companyLogoUrl:
                        'https://logo.clearbit.com/google.com', // Corrected logo URL
                    onSave: () {
                      print('Job saved');
                      // Implement your save logic here
                    }),
              ],
            ),
          ),
                   Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              const Expanded(
                  child: Text(
                "Recent Jobs",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )),
              InkWell(
                onTap: () => {},
                child: Text(
                  "See All",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600),
                ),
              )
            ]),
          ),
              
        ],
      )),
    );
  }
}
