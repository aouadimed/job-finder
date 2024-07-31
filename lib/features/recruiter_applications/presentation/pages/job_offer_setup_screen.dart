import 'package:cv_frontend/features/recruiter_applications/presentation/bloc/job_offer_bloc/job_offer_bloc.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/job_description_form.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/job_details_form.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/loading_widget.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  String _selectedSubcategoryIndex = "";
  int _selectedEmploymentTypeIndex = -1;
  int _selectedLocationTypeIndex = -1;
  String _selectedCategoryIndex = "";

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
      final requiredSkills = _requiredSkillsController.text
          .split(',')
          .map((s) => s.trim())
          .toList();

      BlocProvider.of<JobOfferBloc>(context).add(
        AddJobOfferEvent(
          subcategoryIndex: _selectedSubcategoryIndex,
          employmentTypeIndex: _selectedEmploymentTypeIndex,
          locationTypeIndex: _selectedLocationTypeIndex,
          jobDescription: _jobDescriptionController.text,
          minimumQualifications: _minimumQualificationsController.text,
          requiredSkills: requiredSkills,
          categoryIndex: _selectedCategoryIndex,
        ),
      );
    }
  }

void _resetForm() {
  _jobTitleController.clear();
  _empTypeTextFieldController.clear();
  _locationTypeTextFieldController.clear();
  _jobDescriptionController.clear();
  _minimumQualificationsController.clear();
  _requiredSkillsController.clear();

  setState(() {
    _selectedSubcategoryIndex = "";
    _selectedEmploymentTypeIndex = -1;
    _selectedLocationTypeIndex = -1;
    _selectedCategoryIndex = "";
    _currentPage = 0; 
  });

  _pageController.jumpToPage(0);

  setState(() {
    _currentPage = 0; 
  });
}


  bool _skillsAreValid() {
    if (_requiredSkillsController.text.split(',').length >= 3) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobOfferBloc, JobOfferState>(
      listener: (context, state) {
        if (state is JobOfferFailure) {
          showSnackBar(context: context, message: state.message);
        } else if (state is JobOfferSuccess) {
          showSnackBar(
              context: context,
              message: "Job Offer saved successfully",
              backgroundColor: greenColor);
          _resetForm();
        }
      },
      child: BlocBuilder<JobOfferBloc, JobOfferState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const GeneralAppBar(
              titleText: 'Job Offer',
            ),
            body: state is JobOfferLoading
                ? const LoadingWidget()
                : PageView(
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
                        locationTypeTextFieldController:
                            _locationTypeTextFieldController,
                        jobDescriptionController: _jobDescriptionController,
                        onCategorySelected: (categoryIndex, subcategoryIndex) {
                          setState(() {
                            _selectedCategoryIndex = categoryIndex;
                            _selectedSubcategoryIndex = subcategoryIndex;
                          });
                        },
                        onEmploymentTypeSelected: (index) {
                          setState(() {
                            _selectedEmploymentTypeIndex = index;
                          });
                        },
                        onLocationTypeSelected: (index) {
                          setState(() {
                            _selectedLocationTypeIndex = index;
                          });
                        },
                      ),
                      JobDescriptionPage(
                        formKey: _jobDescriptionFormKey,
                        minimumQualificationsController:
                            _minimumQualificationsController,
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
        },
      ),
    );
  }
}
