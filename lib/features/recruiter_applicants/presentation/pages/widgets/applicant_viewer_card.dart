import 'package:cv_frontend/features/recruiter_applicants/data/models/profil_details.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/pages/widgets/applicant_profil.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';

class ApplicantViewerCard extends StatefulWidget {
  final ProfileDetails? profileDetails;
  final String name;
  final String profileImageUrl;
  final String resumeUrl;
  final String motivationLetter;
  final VoidCallback? onSeeDetailsPressed;
  final bool hasProfile;

  const ApplicantViewerCard({
    Key? key,
    required this.name,
    required this.profileImageUrl,
    required this.resumeUrl,
    required this.motivationLetter,
    this.onSeeDetailsPressed,
    this.hasProfile = true,
    required this.profileDetails,
  }) : super(key: key);

  @override
  State<ApplicantViewerCard> createState() => _ApplicantViewerCardState();
}

class _ApplicantViewerCardState extends State<ApplicantViewerCard>
    with AutomaticKeepAliveClientMixin {
  int _totalPages = 0;
  int _currentPage = 0;
  PDFViewController? _embeddedPdfController;
  PDFViewController? _fullScreenPdfController;
  bool _isFullScreenOpened = false;

  void _navigateToPage(int page) async {
    if (page >= 0 && page < _totalPages) {
      await _embeddedPdfController?.setPage(page);
      await _fullScreenPdfController?.setPage(page);
      setState(() {
        _currentPage = page;
      });
    }
  }

  Future<void> _openFullScreenPDF() async {
    _isFullScreenOpened = true;
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return Scaffold(
          appBar: const GeneralAppBar(
            closeicon: true,
            titleText: "Resume",
          ),
          body: SafeArea(
            child: Stack(
              children: [
                PDFView(
                  key: PageStorageKey('${widget.resumeUrl}_fullscreen'),
                  filePath: widget.resumeUrl,
                  autoSpacing: true,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  pageSnap: true,
                  defaultPage: _currentPage,
                  onRender: (pages) {
                    setState(() {
                      _totalPages = pages ?? 0;
                    });
                  },
                  onViewCreated: (PDFViewController controller) {
                    setState(() {
                      _fullScreenPdfController?.setPage(_currentPage);
                    });
                    _fullScreenPdfController = controller;
                  },
                  onPageChanged: (page, total) {
                    setState(() {
                      _currentPage = page ?? 0;
                      _embeddedPdfController?.setPage(_currentPage);
                    });
                  },
                  onError: (error) {
                    showSnackBar(
                        context: context, message: "Failed to load PDF");
                  },
                ),
                Positioned(
                  bottom: 15,
                  left: 10,
                  child: Text(
                    'Page ${_currentPage + 1} of $_totalPages',
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                if (_totalPages > 1)
                  Positioned(
                    bottom: 8,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (_currentPage > 0)
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () => _navigateToPage(
                              _currentPage - 1,
                            ),
                          ),
                        if (_currentPage < _totalPages - 1)
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            onPressed: () => _navigateToPage(
                              _currentPage + 1,
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Card(
      key: widget.key,
      color: widget.hasProfile ? whiteColor : lightprimaryColor,
      elevation: widget.hasProfile ? 1.0 : 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          if (!widget.hasProfile) ...[
            Expanded(
              child: Stack(
                children: [
                  PDFView(
                    key: PageStorageKey(widget.resumeUrl),
                    filePath: widget.resumeUrl,
                    autoSpacing: true,
                    enableSwipe: true,
                    swipeHorizontal: false,
                    pageSnap: true,
                    onRender: (pages) {
                      if (_totalPages != pages) {
                        setState(() {
                          _totalPages = pages ?? 0;
                        });
                      }
                    },
                    onViewCreated: (PDFViewController controller) {
                      _embeddedPdfController = controller;
                      _embeddedPdfController?.setPage(_currentPage);
                    },
                    onPageChanged: (page, total) {
                      setState(() {
                        _currentPage = page ?? 0;
                        if (!_isFullScreenOpened) {
                          _fullScreenPdfController?.setPage(_currentPage);
                        }
                      });
                    },
                    onError: (error) {
                      showSnackBar(
                          context: context, message: "Failed to load PDF");
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      'Page ${_currentPage + 1} of $_totalPages',
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                  if (_totalPages > 1)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (_currentPage >= 1)
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new_sharp),
                              onPressed: () => _navigateToPage(
                                _currentPage - 1,
                              ),
                            ),
                          if (_currentPage < _totalPages - 1)
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: () => _navigateToPage(
                                _currentPage + 1,
                              ),
                            ),
                        ],
                      ),
                    ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      iconSize: 40,
                      icon: Icon(
                        Icons.fullscreen,
                        color: primaryColor,
                      ),
                      onPressed: _openFullScreenPDF,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  if (widget.profileImageUrl != "null")
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(widget.profileImageUrl),
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  if (widget.motivationLetter.isNotEmpty)
                    IconButton(
                      icon: Icon(
                        Icons.email,
                        color: primaryColor,
                      ),
                      onPressed: _openFullScreenMotivationLetter,
                    ),
                ],
              ),
            ),
          ] else
            Expanded(
                child: ApplicantProfil(
              profileDetails: widget.profileDetails!,
            )),
        ],
      ),
    );
  }

  void _openFullScreenMotivationLetter() {
    showDialog(
      context: context,
      builder: (context) => Scaffold(
        appBar: const GeneralAppBar(
          closeicon: true,
          titleText: "Motivation Letter",
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.motivationLetter,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
