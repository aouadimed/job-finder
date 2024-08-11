import 'package:cv_frontend/features/job_details_and_apply/presentation/bloc/job_detail_bloc/job_detail_bloc.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/job_details_screen.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/job_card.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/job_card_skeleton.dart';
import 'package:cv_frontend/features/saved_jobs/data/models/saved_jobs_model.dart';
import 'package:cv_frontend/features/saved_jobs/presentation/pages/widgets/remove_saved_job_sheet.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/emploments_type_data.dart';
import 'package:cv_frontend/global/utils/location_type_data.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/saved_jobs/presentation/bloc/saved_jobs_bloc.dart';
import 'dart:async';

class SavedJobScreen extends StatefulWidget {
  const SavedJobScreen({super.key});

  @override
  State<SavedJobScreen> createState() => _SavedJobScreenState();
}

class _SavedJobScreenState extends State<SavedJobScreen> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;
  int _currentPage = 1;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  List<SavedJob> _savedJobs = [];
  String _searchQuery = '';
  int totalPages = 1;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    _fetchSavedJobs();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.9 &&
          !_isLoadingMore &&
          _currentPage < totalPages) {
        _loadMoreSavedJobs();
      }
    });
  }

  void _fetchSavedJobs() {
    setState(() {
      _isLoading = true;
      if (_currentPage == 1) {
        _savedJobs.clear(); // Clear the list when fetching new results
      }
    });
    context
        .read<SavedJobsBloc>()
        .add(GetSavedJobsEvent(page: _currentPage, searchQuery: _searchQuery));
  }

  void _loadMoreSavedJobs() {
    setState(() {
      _isLoadingMore = true;
      _currentPage++;
    });

    context
        .read<SavedJobsBloc>()
        .add(GetSavedJobsEvent(page: _currentPage, searchQuery: _searchQuery));
  }

  void _handleSearch(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchQuery = query.toLowerCase().trim();
        _currentPage = 1;
        _isLoadingMore = false;
        _fetchSavedJobs();
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocListener<SavedJobsBloc, SavedJobsState>(
      listener: (context, state) {
        if (state is SavedJobsFailure) {
          setState(() {
            _isLoading = false;
            _isLoadingMore = false;
          });
        } else if (state is SavedJobsSuccess) {
          setState(() {
            _isLoading = false;
            _isLoadingMore = false;
            totalPages = state.savedJobsModel.totalPages!;
            if (_currentPage == 1 &&
                state.savedJobsModel.savedJobs!.isEmpty) {
              _savedJobs.clear();
            } else if (_currentPage == 1) {
              _savedJobs = state.savedJobsModel.savedJobs!;
            } else {
              _savedJobs.addAll(state.savedJobsModel.savedJobs!);
            }
          });
        }
      },
      child: BlocBuilder<SavedJobsBloc, SavedJobsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const GeneralAppBar(
              titleText: "Saved Jobs",
              logo: AssetImage('assets/images/logo.webp'),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InputField(
                      controller: _searchController,
                      hint: "Search Saved Jobs",
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon:
                                  const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                _searchController.clear();
                                _handleSearch('');
                              },
                            )
                          : null,
                      onChanged: _handleSearch,
                    ),
                  ),
                  Flexible(
                    child: _isLoading
                        ? ListView.builder(
                            controller: _scrollController,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return const JobCardSkeleton();
                            },
                          )
                        : _savedJobs.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: mediaQuery.size.width * 0.1,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 100,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "No saved jobs found.",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Try saving some jobs to see them here.",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[500],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                controller: _scrollController,
                                itemCount: _savedJobs.length +
                                    (_isLoadingMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == _savedJobs.length) {
                                    return const JobCardSkeleton();
                                  }

                                  final jobOffer = _savedJobs[index];
                                  List<String> items = [
                                    jobOffer.employmentTypeIndex != null
                                        ? employmentTypes[
                                            jobOffer.employmentTypeIndex!]
                                        : 'Unknown Employment Type',
                                    jobOffer.locationTypeIndex != null
                                        ? locationTypes[
                                            jobOffer.locationTypeIndex!]
                                        : 'Unknown Location Type',
                                  ];
                                  return JobCard(
                                    companyName: jobOffer.companyName!,
                                    jobTitle: jobOffer.subcategoryName!,
                                    location: jobOffer.companyCountry!,
                                    items: items,
                                    companyLogoUrl: jobOffer.logoName!,
                                    onSave: () async {
                                      final savedJobsBloc =
                                          BlocProvider.of<SavedJobsBloc>(
                                              context);

                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return BlocProvider.value(
                                            value: savedJobsBloc,
                                            child: RemoveSavedJobBottomSheet(
                                              jobOffer: jobOffer,
                                              onConfirm: () {
                                                savedJobsBloc
                                                    .add(RemoveSavedJobsEvent(
                                                  id: jobOffer.jobOfferId!,
                                                ));

                                                setState(() {
                                                  _savedJobs.removeAt(index);
                                                });

                                                Navigator.pop(context);
                                              },
                                              item: items,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) =>
                                                sl<JobDetailBloc>()
                                                  ..add(GetJobDetailEvent(
                                                      id: jobOffer
                                                          .jobOfferId!)),
                                            child: const JobDetailsScreen(),
                                          ),
                                        ),
                                      );
                                    },
                                    isSaved: true,
                                  );
                                },
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
