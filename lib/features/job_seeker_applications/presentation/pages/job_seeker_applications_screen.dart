import 'package:cv_frontend/features/job_seeker_applications/presentation/bloc/seeker_application_bloc.dart';
import 'package:cv_frontend/features/job_seeker_applications/presentation/pages/widgets/application_card.dart';
import 'package:cv_frontend/features/job_seeker_applications/presentation/pages/widgets/application_card_skeleton.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class JobSeekerApplications extends StatefulWidget {
  const JobSeekerApplications({super.key});

  @override
  State<JobSeekerApplications> createState() => _JobSeekerApplicationsState();
}

class _JobSeekerApplicationsState extends State<JobSeekerApplications> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;
  int _currentPage = 1;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  List<ApplicationCard> _applications = [];
  String _searchQuery = '';
  int totalPages = 1;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    _fetchApplications();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.9 &&
          !_isLoadingMore &&
          _currentPage < totalPages) {
        _loadMoreApplications();
      }
    });
  }

  void _fetchApplications() {
    setState(() {
      _isLoading = true;
      if (_currentPage == 1) {
        _applications.clear();
      }
    });
    context.read<SeekerApplicationBloc>().add(GetSeekerApplicationsEvent(
          page: _currentPage,
          searchQuery: _searchQuery,
        ));
  }

  void _loadMoreApplications() {
    setState(() {
      _isLoadingMore = true;
      _currentPage++;
    });

    context.read<SeekerApplicationBloc>().add(GetSeekerApplicationsEvent(
          page: _currentPage,
          searchQuery: _searchQuery,
        ));
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
        _fetchApplications();
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
    return BlocListener<SeekerApplicationBloc, SeekerApplicationState>(
      listener: (context, state) {
        if (state is SeekerApplicationFailure) {
          setState(() {
            _isLoading = false;
            _isLoadingMore = false;
          });
        } else if (state is SeekerApplicationSuccess) {
          setState(() {
            _isLoading = false;
            _isLoadingMore = false;
            totalPages = state.jobSeekerApplicationModel.totalPages;
            if (_currentPage == 1 && state.jobSeekerApplicationModel.jobApplications.isEmpty) {
              _applications.clear();
            } else if (_currentPage == 1) {
              _applications = state.jobSeekerApplicationModel.jobApplications.map((application) {
                return ApplicationCard(
              logo: application.logoName,
                  jobTitle: application.subcategoryName,
                  companyName: application.companyName,
                  status: application.applicationStatus,
                );
              }).toList();
            } else {
              _applications.addAll(state.jobSeekerApplicationModel.jobApplications.map((application) {
                return ApplicationCard(
                  logo: application.logoName,
                  jobTitle: application.subcategoryName,
                  companyName: application.companyName,
                  status: application.applicationStatus,
                );
              }));
            }
          });
        }
      },
      child: BlocBuilder<SeekerApplicationBloc, SeekerApplicationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const GeneralAppBar(
              titleText: "Applications",
              logo: AssetImage('assets/images/logo.webp'),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InputField(
                      controller: _searchController,
                      hint: "Search Applications",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                   FocusScope.of(context).unfocus();
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
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: ApplicationCardSkeleton(),
                              );
                            },
                          )
                        : _applications.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: mediaQuery.size.width * 0.1,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        "No applications found.",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Try searching for different applications.",
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
                                itemCount: _applications.length +
                                    (_isLoadingMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == _applications.length) {
                                    return const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: ApplicationCardSkeleton(),
                                    );
                                  }
                                  return _applications[index];
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
