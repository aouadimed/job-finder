import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/job_offer_model.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/bloc/job_offer_bloc/job_offer_bloc.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/selection_sheep.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/vacancies_card.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/loading_widget.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/emploments_type_data.dart';
import 'package:cv_frontend/global/utils/location_type_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  late TextEditingController _searchController;
  late JobOffersModel jobOffersModel;
  List<String> selectOptions = ['All vacancies', 'Active', 'Inactive'];
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  List<JobOffer> _jobOffers = [];
  String _searchQuery = '';
  int _selectedFilterIndex = 0;
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _fetchJobOffers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoadingMore &&
          _currentPage < totalPages) {
        _fetchMoreJobOffers();
      }
    });
  }

  void _fetchJobOffers() {
    setState(() {
      _isLoading = true;
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
            if (_currentPage == 1) {
              _jobOffers = state.jobOffersModel.jobOffers!;
            } else {
              _jobOffers.addAll(state.jobOffersModel.jobOffers!);
            }
          });
        }
      },
      child: BlocBuilder<JobOfferBloc, JobOfferState>(
        builder: (context, state) {
          return Scaffold(
            appBar: GeneralAppBar(
              titleText: "Applications",
              rightIcon: Icons.add,
              rightIconColor: primaryColor,
              logo: const AssetImage("assets/icons/application_icon.webp"),
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
                        _currentPage = 1;
                        _fetchJobOffers();
                      },
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: _isLoading
                          ? Skeletonizer(
                              enabled: true,
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  );
                                },
                              ),
                            )
                          : _jobOffers.isEmpty
                              ? Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/empty_state.png',
                                          width: 200,
                                          height: 200,
                                        ),
                                        const SizedBox(height: 60),
                                        Text(
                                          'Empty',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Create a job vacancy for your company and start\n'
                                          'find new high quality employee.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 20),
                                        BigButton(
                                            text: 'Create Vacancies Now',
                                            onPressed: () {
                                              goToJobOfferScreen(context);
                                            }),
                                      ],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  controller: _scrollController,
                                  itemCount: _jobOffers.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == _jobOffers.length) {
                                      return _isLoadingMore
                                          ? Skeletonizer(
                                              enabled: true,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            )
                                          : const SizedBox();
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
    _currentPage = 1;
    _fetchJobOffers();
  }

  void goToJobOfferScreen(BuildContext context) async {
    await Navigator.pushNamed(context, jobOfferSetup).then(
      (_) {
        if (context.mounted) {
          BlocProvider.of<JobOfferBloc>(context).add(const GetJobOffersEvent());
        }
      },
    );
  }
}
