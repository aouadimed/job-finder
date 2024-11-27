import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/bloc/applicant_bloc/applicant_bloc.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/pages/widgets/applicant_card.dart';
import 'package:cv_frontend/features/recruiter_home/presentation/pages/widget/applicant_widget.dart';
import 'package:cv_frontend/features/recruiter_home/presentation/pages/widget/applicant_widget_skeleton.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/recruiter_home/presentation/bloc/recruiter_home_bloc.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';

class RecruiterHomeScreen extends StatefulWidget {
  const RecruiterHomeScreen({super.key});

  @override
  State<RecruiterHomeScreen> createState() => _RecruiterHomeScreenState();
}

class _RecruiterHomeScreenState extends State<RecruiterHomeScreen> {
  late ScrollController _scrollController;
  final TextEditingController _searchController = TextEditingController();
  final List<Application> _applicants = [];
  int _currentPage = 1;
  int? _totalPages;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  String _searchQuery = '';

  final Map<int, bool> _isFading = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fetchApplicants();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.9 &&
          !_isLoadingMore &&
          _currentPage < (_totalPages ?? 1)) {
        _loadMoreApplicants();
      }
    });
  }

  void _fetchApplicants() {
    setState(() {
      _isLoading = true;
      if (_currentPage == 1) {
        _applicants.clear();
      }
    });
    context.read<RecruiterHomeBloc>().add(
          FetchRecentApplicantsEvent(
            searchQuery: _searchQuery,
            page: _currentPage,
          ),
        );
  }

  void _loadMoreApplicants() {
    setState(() {
      _isLoadingMore = true;
      _currentPage++;
    });
    context.read<RecruiterHomeBloc>().add(
          FetchRecentApplicantsEvent(
            searchQuery: _searchQuery,
            page: _currentPage,
          ),
        );
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query.trim();
      _currentPage = 1;
      _isLoadingMore = false;
      _fetchApplicants();
    });
  }

  void _removeApplicantWithFade(int index) {
    setState(() {
      _isFading[index] = true;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _applicants.removeAt(index);
        _isFading.remove(index);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecruiterHomeBloc, RecruiterHomeState>(
      listener: (context, state) {
        if (state is RecruiterHomeFailure) {
          setState(() {
            _isLoading = false;
            _isLoadingMore = false;
          });
          showSnackBar(context: context, message: state.message);
        } else if (state is RecruiterHomeSuccess) {
          setState(() {
            _isLoading = false;
            _isLoadingMore = false;
            _totalPages = state.applicantModel.totalPages;
            if (_currentPage == 1) {
              _applicants.clear();
            }
            _applicants.addAll(state.applicantModel.application!);
          });
        }
      },
      child: Scaffold(
        appBar: const GeneralAppBar(
          logo: AssetImage("assets/images/logo.webp"),
          titleText: 'Job Finder',
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InputField(
                  controller: _searchController,
                  hint: "Search",
                  prefixIcon: Icon(Icons.search, color: greyColor),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: greyColor),
                          onPressed: () {
                            _searchController.clear();
                            FocusScope.of(context).unfocus();
                            _handleSearch('');
                          },
                        )
                      : null,
                  onChanged: (value) {
                    _handleSearch(value);
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recent People Applied",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _isLoading
                    ? ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) =>
                            const ShimmerApplicantsCard(),
                      )
                    : _applicants.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      size: 100,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "No applicants found.",
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
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                _applicants.length + (_isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == _applicants.length) {
                                return const ShimmerApplicantsCard();
                              }
                              final applicant = _applicants[index];
                              return AnimatedOpacity(
                                opacity: _isFading[index] == true ? 0.0 : 1.0,
                                duration: const Duration(milliseconds: 300),
                                child: ApplicantsCard(
                                  name:
                                      "${applicant.user?.firstName} ${applicant.user?.lastName}",
                                  profileImageUrl:
                                      applicant.user?.profileImg ?? '',
                                  jobTitle: applicant.job ?? 'N/A',
                                  sentMessage: () {
                                    showSnackBar(
                                      context: context,
                                      message:
                                          "Message sent to ${applicant.user?.firstName}",
                                    );
                                  },
                                  onSeeDetailsPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => BlocProvider(
                                        create: (context) =>
                                            sl<ApplicantBloc>(),
                                        child: BlocConsumer<ApplicantBloc,
                                            ApplicantState>(
                                          listener: (context, state) {
                                            // Listener logic here
                                          },
                                          builder: (context, state) {
                                            return ApplicantInfoDialog(
                                              recruiterHome: true,
                                              name:
                                                  "${applicant.user!.firstName} ${applicant.user!.lastName}",
                                              profileImageUrl:
                                                  applicant.user!.profileImg ??
                                                      "",
                                              resumeUrl:
                                                  applicant.pdfPath ?? "",
                                              motivationLetter:
                                                  applicant.motivationLetter ??
                                                      "",
                                              hasProfile:
                                                  applicant.useProfile ?? false,
                                              profileDetails:
                                                  applicant.profileDetails,
                                              swipeRight: () {
                                                context
                                                    .read<ApplicantBloc>()
                                                    .add(
                                                      UpdateApplicantStatusEvent(
                                                        id: applicant.id!,
                                                        status: 'pending',
                                                      ),
                                                    );
                                                context.read<ApplicantBloc>().add(
                                                    SendMessageToApplicantEvent(
                                                        id: applicant.id!));
                                                Navigator.pop(context);
                                                _removeApplicantWithFade(index);
                                              },
                                              swipeLeft: () {
                                                context
                                                    .read<ApplicantBloc>()
                                                    .add(
                                                      UpdateApplicantStatusEvent(
                                                        id: applicant.id!,
                                                        status: 'rejected',
                                                      ),
                                                    );
                                                Navigator.pop(context);
                                                _removeApplicantWithFade(index);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToJobOfferScreen(BuildContext context) async {
    await Navigator.pushNamed(context, jobOfferSetup);
  }
}
