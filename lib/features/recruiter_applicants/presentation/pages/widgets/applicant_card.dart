import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/profil_details.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/pages/widgets/applicant_profil.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';

class ApplicantInfoDialog extends StatefulWidget {
  final ProfileDetails? profileDetails;
  final String name;
  final String profileImageUrl;
  final String resumeUrl;
  final String motivationLetter;
  final bool hasProfile;
  final Function()? swipeLeft;
  final Function()? swipeRight;
  final bool? recruiterHome;

  const ApplicantInfoDialog({
    Key? key,
    required this.name,
    required this.profileImageUrl,
    required this.resumeUrl,
    required this.motivationLetter,
    this.hasProfile = true,
    required this.profileDetails,
    this.swipeLeft,
    this.swipeRight,
    this.recruiterHome = false,
  }) : super(key: key);

  @override
  State<ApplicantInfoDialog> createState() => _ApplicantInfoDialogState();
}

class _ApplicantInfoDialogState extends State<ApplicantInfoDialog> {
  int _totalPages = 0;
  int _currentPage = 0;
  PDFViewController? _pdfController;

  void _navigateToPage(int page) async {
    if (page >= 0 && page < _totalPages) {
      await _pdfController?.setPage(page);
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Scaffold(
        appBar: GeneralAppBar(
          titleText: widget.name,
          closeicon: true,
        ),
        body: widget.hasProfile
            ? ApplicantProfil(profileDetails: widget.profileDetails!)
            : _buildResumeView(),
        bottomNavigationBar: (widget.recruiterHome == true)
            ? Container(
                color: lightprimaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: widget.swipeLeft,
                      iconSize: 40,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: widget.swipeRight,
                      iconSize: 40,
                    )
                  ],
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildResumeView() {
    return Stack(
      children: [
        PDFView(
          key: PageStorageKey(widget.resumeUrl),
          filePath: widget.resumeUrl,
          autoSpacing: true,
          enableSwipe: true,
          swipeHorizontal: true,
          onRender: (pages) {
            setState(() {
              _totalPages = pages ?? 0;
            });
          },
          onViewCreated: (PDFViewController controller) {
            _pdfController = controller;
            _pdfController?.setPage(_currentPage);
          },
          onPageChanged: (page, total) {
            setState(() {
              _currentPage = page ?? 0;
            });
          },
          onError: (error) {
            showSnackBar(context: context, message: "Failed to load PDF");
          },
        ),
        if (_totalPages > 1)
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: [
                if (_currentPage > 0)
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => _navigateToPage(_currentPage - 1),
                  ),
                if (_currentPage < _totalPages - 1)
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () => _navigateToPage(_currentPage + 1),
                  ),
              ],
            ),
          ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Text(
            'Page ${_currentPage + 1} of $_totalPages',
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
