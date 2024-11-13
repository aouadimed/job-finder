import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/bloc/applicant_bloc/applicant_bloc.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/pages/recruiter_applicant_screen.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/job_offer_model.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/bloc/job_offer_bloc/job_offer_bloc.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/selection_sheet.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/vacancies_card.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/vacancies_card_skeleton.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/emploments_type_data.dart';
import 'package:cv_frontend/global/utils/location_type_data.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  late TextEditingController _searchController;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  List<JobOffer> _jobOffers = [];
  String _searchQuery = '';
  int _selectedFilterIndex = 0;
  int totalPages = 1;
  List<String> selectOptions = ['All vacancies', 'Active', 'Inactive'];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _fetchJobOffers();
    _scrollController.addListener(_handleScroll);

    // Add a listener to refresh data when this screen regains focus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModalRoute.of(context)!.addScopedWillPopCallback(() async {
        _refreshJobOffers();
        return true;
      });
    });
  }

  void _handleScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.9 &&
        !_isLoadingMore &&
        _currentPage < totalPages) {
      _fetchMoreJobOffers();
    }
  }

  // Force refresh job offers when returning to this screen
  void _refreshJobOffers() {
    setState(() {
      _isLoading = true;
      _jobOffers.clear();
      _currentPage = 1;
    });
    BlocProvider.of<JobOfferBloc>(context).add(GetJobOffersEvent(
      page: _currentPage,
      searchQuery: _searchQuery,
      filterIndex: _selectedFilterIndex,
    ));
  }

  void _fetchJobOffers() {
    setState(() {
      _isLoading = true;
      _currentPage =
          1; // Reset page only for a fresh load (e.g., on search or filter change)
    });
    BlocProvider.of<JobOfferBloc>(context).add(GetJobOffersEvent(
      page: _currentPage,
      searchQuery: _searchQuery,
      filterIndex: _selectedFilterIndex,
    ));
  }

  void _fetchMoreJobOffers() {
    setState(() {
      _isLoadingMore = true;
      _currentPage++;
    });

    BlocProvider.of<JobOfferBloc>(context).add(GetJobOffersEvent(
      page: _currentPage,
      searchQuery: _searchQuery,
      filterIndex: _selectedFilterIndex,
    ));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(
        _handleScroll); // Remove listener to prevent duplication
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobOfferBloc, JobOfferState>(
      listener: (context, state) {
        if (state is JobOfferFailure) {
          showSnackBar(context: context, message: state.message);
          setState(() {
            _isLoading = false;
            _isLoadingMore = false;
          });
        } else if (state is JobOffersLoaded) {
          setState(() {
            _isLoading = false;
            _isLoadingMore = false;
            totalPages = state.jobOffersModel.totalPages!;

            // Only add unique job offers to avoid duplicates
            if (_currentPage == 1) {
              _jobOffers = state.jobOffersModel.jobOffers!;
            } else {
              final newJobOffers = state.jobOffersModel.jobOffers!;
              _jobOffers.addAll(newJobOffers.where((newJob) => !_jobOffers
                  .any((existingJob) => existingJob.id == newJob.id)));
            }
          });
        } else if (state is JobOfferSuccess) {
          setState(() {});
        }
      },
      child: BlocBuilder<JobOfferBloc, JobOfferState>(
        builder: (context, state) {
          return Scaffold(
            appBar: GeneralAppBar(
              titleText: "Applications",
              rightIcon: Icons.add,
              rightIconColor: primaryColor,
              logo: const AssetImage("assets/images/logo.webp"),
              rightIconOnPressed: () {
                goToJobOfferScreen(context);
              },
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
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
                                _handleSearch(''); // Clear search query
                              },
                            )
                          : null,
                      textInputType: TextInputType.text,
                      onChanged: (value) {
                        _handleSearch(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    ChipSelection(
                      selectOptions: selectOptions,
                      onSelected: (selectedIndex) {
                        _selectedFilterIndex = selectedIndex;
                        _fetchJobOffers(); // Reload offers on filter change
                      },
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: _isLoading
                          ? ListView.builder(
                              controller: _scrollController,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return const VacanciesCardSkeleton(
                                  showCount: true,
                                );
                              },
                            )
                          : _jobOffers.isEmpty
                              ? Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          size: 100,
                                          color: Colors.grey[400],
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "No applications found.",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[500],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Create a job vacancy for your company and start\n'
                                          'finding new high-quality employees.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        BigButton(
                                          text: 'Create Vacancies Now',
                                          onPressed: () {
                                            goToJobOfferScreen(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  controller: _scrollController,
                                  itemCount: _jobOffers.length +
                                      (_isLoadingMore ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index == _jobOffers.length) {
                                      return const VacanciesCardSkeleton(
                                        showCount: true,
                                      );
                                    }
                                    final jobOffer = _jobOffers[index];
                                    List<String> jobDetails = [
                                      jobOffer.employmentTypeIndex != null
                                          ? employmentTypes[
                                              jobOffer.employmentTypeIndex!]
                                          : 'Unknown Employment Type',
                                      jobOffer.locationTypeIndex != null
                                          ? locationTypes[
                                              jobOffer.locationTypeIndex!]
                                          : 'Unknown Location Type',
                                    ];
                                    return VacanciesCard(
                                      categoryName: jobOffer.categoryName!,
                                      jobTitle: jobOffer.subcategoryName!,
                                      jobDetails: jobDetails,
                                      isActive: jobOffer.active!,
                                      applicantsCount: jobOffer.applicantCount!,
                                      onToggleStatus: () {
                                        BlocProvider.of<JobOfferBloc>(context)
                                            .add(ToggleStatusEvent(
                                                id: jobOffer.id!));
                                        if (jobOffer.active == true) {
                                          jobOffer.active = false;
                                        } else {
                                          jobOffer.active = true;
                                        }
                                      },
                                      onTap: () {
                                        if (jobOffer.applicantCount != 0) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                create: (context) =>
                                                    sl<ApplicantBloc>()
                                                      ..add(GetApplicantsEvent(
                                                          id: jobOffer.id!)),
                                                child: RecruiterApplicantScreen(
                                                  jobOfferId: jobOffer.id!,
                                                ),
                                              ),
                                            ),
                                          ).then((_) {
                                            // Refresh data on return
                                            _refreshJobOffers();
                                          });
                                        } else {
                                          showSnackBar(
                                              context: context,
                                              message: "No applicants found");
                                        }
                                      },
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleSearch(String value) {
    _searchQuery = value.toLowerCase().trim();
    _fetchJobOffers();
  }

  void goToJobOfferScreen(BuildContext context) async {
    await Navigator.pushNamed(context, jobOfferSetup).then((_) {
      _refreshJobOffers();
    });
  }
}
