import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/pages/swiped_applicants_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/bloc/applicant_bloc/applicant_bloc.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/pages/widgets/applicant_viewer_card.dart';

class RecruiterApplicantScreen extends StatefulWidget {
  final String jobOfferId;

  const RecruiterApplicantScreen({super.key, required this.jobOfferId});

  @override
  State<RecruiterApplicantScreen> createState() =>
      _RecruiterApplicantScreenState();
}

class _RecruiterApplicantScreenState extends State<RecruiterApplicantScreen> {
  final CardSwiperController _swiperController = CardSwiperController();
  int _currentPage = 1;
  bool _isLoadingMore = false;
  final List<Application> _applicants = [];
  int _totalApplicants = 0;
  final List<Application> _lastRemovedApplicants = [];
  int _swipeCount = 0;
  int? _totalPages;
  final List<Application> _pendingApplicants = [];

  @override
  void initState() {
    super.initState();
    _fetchApplicants();
  }

  void _fetchApplicants() {
    BlocProvider.of<ApplicantBloc>(context)
        .add(GetApplicantsEvent(page: _currentPage, id: widget.jobOfferId));
  }

  void _fetchMoreApplicants() {
    if (!_isLoadingMore && _applicants.length < _totalApplicants) {
      setState(() {
        _isLoadingMore = true;
        _currentPage++;
      });
      _fetchApplicants();
    }
  }

  void _swipeLeft() {
    if (_applicants.isNotEmpty) {
      final applicant = _applicants.first;
      _pendingApplicants.removeWhere(
          (pendingApplicant) => pendingApplicant.id == applicant.id);

      _swiperController.swipe(CardSwiperDirection.left);
    }
  }

  void _swipeRight() {
    if (_applicants.isNotEmpty) {
      final applicant = _applicants.first;
      if (!_pendingApplicants.any((existing) => existing.id == applicant.id)) {
        _pendingApplicants.add(applicant);
      }
      _swiperController.swipe(CardSwiperDirection.right);
    }
  }

  void _reloadLastCard() {
    if (_lastRemovedApplicants.isNotEmpty) {
      _swipeCount--;
      setState(() {
        _applicants.insert(0, _lastRemovedApplicants.removeLast());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApplicantBloc, ApplicantState>(
        listener: (context, state) {
      if (state is ApplicantFailure) {
        showSnackBar(context: context, message: state.message);
      } else if (state is ApplicantSuccess) {
        setState(() {
          _isLoadingMore = false;
          _totalPages = state.applicantModel.totalPages;
          _totalApplicants = state.applicantModel.totalApplicants!;
          if (_currentPage == 1) {
            _applicants.clear();
          }
          _applicants.addAll(state.applicantModel.application!);
        });
      }
    }, child: BlocBuilder<ApplicantBloc, ApplicantState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const GeneralAppBar(titleText: "Applicants"),
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: _applicants.isEmpty && state is ApplicantLoading
                          ? const Center(child: CircularProgressIndicator())
                          : _applicants.isEmpty
                              ? SwipedApplicantsView(
                                  pendingApplicants: _pendingApplicants,
                                  onSelectApplicant: (String value) {},
                                  onSelectApplicants:
                                      (Set<String> selectedApplicants) {
                                    for (String id in selectedApplicants) {
                                      context.read<ApplicantBloc>().add(
                                            SendMessageToApplicantEvent(id: id),
                                          );
                                    }

                                    final unselectedApplicants =
                                        _pendingApplicants
                                            .where((applicant) =>
                                                !selectedApplicants
                                                    .contains(applicant.id))
                                            .toList();

                                    for (final unselectedApplicant
                                        in unselectedApplicants) {
                                      context.read<ApplicantBloc>().add(
                                            UpdateApplicantStatusEvent(
                                              id: unselectedApplicant.id!,
                                              status: 'rejected',
                                            ),
                                          );
                                    }
                                    _pendingApplicants.clear();
                                    Navigator.pop(context);
                                  },
                                )
                              : CardSwiper(
                                  isDisabled: false,
                                  isLoop: false,
                                  numberOfCardsDisplayed: _applicants.length,
                                  controller: _swiperController,
                                  cardsCount: _applicants.length,
                                  allowedSwipeDirection:
                                      const AllowedSwipeDirection.only(
                                          left: true, right: true),
                                  cardBuilder: (context, index, direction, __) {
                                    final applicant = _applicants[index];
                                    return ApplicantViewerCard(
                                      key: PageStorageKey(applicant.id),
                                      hasProfile: applicant.useProfile!,
                                      name:
                                          "${applicant.user!.firstName} ${applicant.user!.lastName}",
                                      profileImageUrl:
                                          applicant.user!.profileImg ?? '',
                                      resumeUrl: applicant.pdfPath ?? "",
                                      motivationLetter:
                                          applicant.motivationLetter ?? "",
                                      profileDetails: applicant.profileDetails,
                                    );
                                  },
                                  onSwipe:
                                      (previousIndex, currentIndex, direction) {
                                    final applicant =
                                        _applicants[previousIndex];

                                    if (direction == CardSwiperDirection.left) {
                                      context.read<ApplicantBloc>().add(
                                            UpdateApplicantStatusEvent(
                                              id: applicant.id!,
                                              status: 'rejected',
                                            ),
                                          );
                                      _pendingApplicants.removeWhere(
                                          (pendingApplicant) =>
                                              pendingApplicant.id ==
                                              applicant.id);
                                    } else if (direction ==
                                        CardSwiperDirection.right) {
                                      context.read<ApplicantBloc>().add(
                                            UpdateApplicantStatusEvent(
                                              id: applicant.id!,
                                              status: 'pending',
                                            ),
                                          );
                                      if (!_pendingApplicants
                                          .contains(applicant)) {
                                        _pendingApplicants.add(applicant);
                                      }
                                    }
                                    _swipeCount++;
                                    _lastRemovedApplicants.add(applicant);
                                    if (_swipeCount == _totalApplicants) {
                                      _applicants.clear();
                                    }

                                    if (_currentPage < _totalPages! &&
                                        currentIndex ==
                                            _applicants.length - 1) {
                                      _fetchMoreApplicants();
                                    }
                                    setState(() {});
                                    return true;
                                  },
                                  backCardOffset: const Offset(40, 40),
                                ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (_applicants.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: _swipeLeft,
                              iconSize: 40,
                            ),
                          if (_lastRemovedApplicants.isNotEmpty)
                            IconButton(
                              icon: Icon(Icons.refresh, color: primaryColor),
                              onPressed: _lastRemovedApplicants.isNotEmpty
                                  ? _reloadLastCard
                                  : null,
                              iconSize: 40,
                            ),
                          if (_applicants.isNotEmpty)
                            IconButton(
                              icon:
                                  const Icon(Icons.check, color: Colors.green),
                              onPressed: _swipeRight,
                              iconSize: 40,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_isLoadingMore)
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(),
                  ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
