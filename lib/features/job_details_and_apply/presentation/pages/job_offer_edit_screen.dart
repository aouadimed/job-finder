import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/models/job_offer_details.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/bloc/job_detail_bloc/job_detail_bloc.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/job_description_form.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/job_details_form.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/loading_widget.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/utils/emploments_type_data.dart';
import 'package:cv_frontend/global/utils/location_type_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobOfferEditScreen extends StatefulWidget {
  final String jobId; // Accept job ID to fetch details

  const JobOfferEditScreen({super.key, required this.jobId});

  @override
  State<JobOfferEditScreen> createState() => _JobOfferEditScreenState();
}

class _JobOfferEditScreenState extends State<JobOfferEditScreen> {
  final PageController _pageController = PageController();
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

  String _selectedSubcategoryIndex = "";
  int _selectedEmploymentTypeIndex = -1;
  int _selectedLocationTypeIndex = -1;
  String _selectedCategoryIndex = "";
  List<String> _initialSkills = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _fetchJobOfferDetails();
  }

  void _fetchJobOfferDetails() {
    context.read<JobDetailBloc>().add(GetJobDetailEvent(id: widget.jobId));
  }

  void _populateFields(JobOfferDetailsModel jobOffer) {
    setState(() {
      _jobTitleController.text = jobOffer.subcategoryName;
      _empTypeTextFieldController.text =
          employmentTypes[jobOffer.employmentTypeIndex];
      _locationTypeTextFieldController.text =
          locationTypes[jobOffer.locationTypeIndex];
      _jobDescriptionController.text = jobOffer.jobDescription;
      _minimumQualificationsController.text = jobOffer.minimumQualifications;
      _requiredSkillsController.text = jobOffer.requiredSkills.join(', ');
      _selectedSubcategoryIndex = jobOffer.subcategoryId;
      _selectedEmploymentTypeIndex = jobOffer.employmentTypeIndex;
      _selectedLocationTypeIndex = jobOffer.locationTypeIndex;
      _selectedCategoryIndex = jobOffer.categoryId;
      _initialSkills = jobOffer.requiredSkills;
    });
  }

  void _goToNextPage() {
    if (_currentPage == 0) {
      if (_jobDetailsFormKey.currentState?.validate() ?? false) {
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
      BlocProvider.of<JobDetailBloc>(context).add(
        EditJobOfferEvent(
          id: widget.jobId,
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

    _currentPage = 0;
    setState(() {});
  }

  bool _skillsAreValid() {
    return _requiredSkillsController.text.split(',').length >= 3;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobDetailBloc, JobDetailState>(
      listener: (context, state) {
        if (state is JobDetailFailure) {
          showSnackBar(context: context, message: state.message);
        } else if (state is JobDetailSuccess) {
          _populateFields(state.jobOfferDetailsModel);
        } else if (state is JobEditFailure) {
          showSnackBar(context: context, message: "Erreur");
        } else if (state is EditJobSuccess) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<JobDetailBloc, JobDetailState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const GeneralAppBar(titleText: 'Edit Job Offer'),
            body: state is JobDetailLoading
                ? const LoadingWidget()
                : state is! JobEditLoading
                    ? PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        children: [
                          JobDetailsPage(
                            selectedEmploymentTypeIndex:
                                _selectedEmploymentTypeIndex,
                            selectedLocationTypeIndex:
                                _selectedLocationTypeIndex,
                            selectedCategoryId: _selectedCategoryIndex,
                            selectedSubcategoryId: _selectedSubcategoryIndex,
                            formKey: _jobDetailsFormKey,
                            jobTitleController: _jobTitleController,
                            empTypeTextFieldController:
                                _empTypeTextFieldController,
                            locationTypeTextFieldController:
                                _locationTypeTextFieldController,
                            jobDescriptionController: _jobDescriptionController,
                            onCategorySelected:
                                (categoryIndex, subcategoryIndex) {
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
                      )
                    : const LoadingWidget(),
            bottomNavigationBar: state is JobDetailLoading
                ? null
                : state is JobEditLoading
                    ? null
                    : Padding(
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
