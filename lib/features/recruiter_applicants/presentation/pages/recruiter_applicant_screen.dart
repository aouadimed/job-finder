import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/pages/widgets/applicant_viewer.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/bloc/applicant_bloc/applicant_bloc.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/common_widget/loading_widget.dart';

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
  List<Application> _applicants = [];
  int _totalApplicants = 0;

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
      BlocProvider.of<ApplicantBloc>(context)
          .add(GetApplicantsEvent(page: _currentPage, id: widget.jobOfferId));
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
            _applicants.addAll(state.applicantModel.application!);
            _totalApplicants =
                state.applicantModel.totalApplicants!; // Set total applicants
          });
        }
      },
      child: BlocBuilder<ApplicantBloc, ApplicantState>(
        builder: (context, state) {
          return Scaffold(
            appBar: GeneralAppBar(titleText: "Applicants"),
            body: SafeArea(
              child: _applicants.isEmpty && state is ApplicantLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _applicants.isEmpty
                      ? Center(child: Text("No applicants found."))
                      : Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: CardSwiper(
                                    controller: _swiperController,
                                    cardsCount: _applicants.length,
                                    cardBuilder:
                                        (context, index, percentX, percentY) {
                                      if (_applicants[index].useProfile ==
                                          true) {
                                        _applicants[index].motivationLetter =
                                            "";
                                      }
                                      return ApplicantViewerCard(
                                        hasProfile:
                                            _applicants[index].useProfile!,
                                        name:
                                            "${_applicants[index].user!.firstName} ${_applicants[index].user!.lastName}",
                                        profileImageUrl: _applicants[index]
                                                .user!
                                                .profileImg ??
                                            '',
                                        resumeUrl:
                                            _applicants[index].cvUpload ?? '',
                                        onMessageSent: () {
                                          // Implement message sending logic
                                        },
                                        onAccept: () {
                                          // Implement accept logic
                                        },
                                        onReject: () {
                                          // Implement reject logic
                                        },
                                        motivationLetter: _applicants[index]
                                            .motivationLetter!,
                                      );
                                    },
                                    onSwipe: (previousIndex, currentIndex,
                                        direction) {
                                      // Start fetching more applicants when swiping near the end
                                      if (currentIndex ==
                                          _applicants.length - 2) {
                                        _fetchMoreApplicants();
                                      }
                                      return true;
                                    },
                                    numberOfCardsDisplayed: 3,
                                    backCardOffset: const Offset(40, 40),
                                    padding: const EdgeInsets.all(24.0),
                                  ),
                                ),
                                if (_isLoadingMore)
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                              ],
                            ),
                            if (_isLoadingMore)
                              Positioned(
                                bottom: 16,
                                left: 0,
                                right: 0,
                                child: LinearProgressIndicator(),
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
