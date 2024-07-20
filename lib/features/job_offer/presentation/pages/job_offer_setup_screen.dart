import 'package:cv_frontend/features/job_offer/presentation/pages/widgets/job_description_form.dart';
import 'package:cv_frontend/features/job_offer/presentation/pages/widgets/job_details_form.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class JobOfferSetupScreen extends StatefulWidget {
  const JobOfferSetupScreen({super.key});

  @override
  State<JobOfferSetupScreen> createState() => _JobOfferSetupScreenState();
}

class _JobOfferSetupScreenState extends State<JobOfferSetupScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _empTypeTextFieldController =
      TextEditingController();
  final TextEditingController _locationTypeTextFieldController =
      TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  final TextEditingController _minimumQualificationsController =
      TextEditingController();
  final TextEditingController _requiredSkillsController =
      TextEditingController();

  final List<String> _initialSkills = [
    "Communication",
    "Teamwork",
    "Problem Solving"
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _jobTitleController.dispose();
    _empTypeTextFieldController.dispose();
    _locationTypeTextFieldController.dispose();
    _jobDescriptionController.dispose();
    _minimumQualificationsController.dispose();
    _requiredSkillsController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _saveJobOffer();
    }
  }

  void _goToPreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _saveJobOffer() {
    // Implement your save logic here
    print("Job offer saved!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        titleText: 'Step ${_currentPage + 1}',
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          JobDetailsPage(
            formKey: GlobalKey<FormState>(),
            jobTitleController: _jobTitleController,
            empTypeTextFieldController: _empTypeTextFieldController,
            locationTypeTextFieldController: _locationTypeTextFieldController,
            jobDescriptionController: _jobDescriptionController,
          ),
          JobDescriptionPage(
            formKey: GlobalKey<FormState>(),
            minimumQualificationsController: _minimumQualificationsController,
            requiredSkillsController: _requiredSkillsController,
            initialSkills: _initialSkills,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentPage != 0)
              Expanded(
                child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: _goToPreviousPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            if (_currentPage != 0) const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: _goToNextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    _currentPage < 1 ? 'Continue' : 'Save',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
