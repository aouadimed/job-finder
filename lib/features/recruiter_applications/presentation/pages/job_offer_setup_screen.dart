import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/job_description_form.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/job_details_form.dart';
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

  final GlobalKey<FormState> _jobDetailsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _jobDescriptionFormKey = GlobalKey<FormState>();

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

  final List<String> _initialSkills = [];

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
    if (_currentPage == 0) {
      if (_jobDetailsFormKey.currentState!.validate()) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
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
    if (_jobDescriptionFormKey.currentState!.validate() && _skillsAreValid()) {
      print("Job offer saved!");
      // Implement your save logic here
    }
  }

  bool _skillsAreValid() {
    if (_requiredSkillsController.text.split(',').length >= 3) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        titleText: 'Job Offer',
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
            formKey: _jobDetailsFormKey,
            jobTitleController: _jobTitleController,
            empTypeTextFieldController: _empTypeTextFieldController,
            locationTypeTextFieldController: _locationTypeTextFieldController,
            jobDescriptionController: _jobDescriptionController,
          ),
          JobDescriptionPage(
            formKey: _jobDescriptionFormKey,
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
