import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/pages/widgets/applicant_card.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';

class SwipedApplicantsView extends StatefulWidget {
  final List<Application> pendingApplicants;
  final Function(String) onSelectApplicant;
  final Function(Set<String>) onSelectApplicants;

  const SwipedApplicantsView({
    Key? key,
    required this.pendingApplicants,
    required this.onSelectApplicant,
    required this.onSelectApplicants,
  }) : super(key: key);

  @override
  State<SwipedApplicantsView> createState() => _SwipedApplicantsViewState();
}

class _SwipedApplicantsViewState extends State<SwipedApplicantsView> {
  final Set<String> _selectedApplicants = {};

  void _toggleSelection(String applicantId) {
    setState(() {
      if (_selectedApplicants.contains(applicantId)) {
        _selectedApplicants.remove(applicantId);
      } else {
        _selectedApplicants.add(applicantId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.pendingApplicants.isNotEmpty) ...[
            Text(
              "Potential Applicants",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Select the best candidates to send them a message and initiate a conversation to discuss further. Tap on an applicant to view more details, or press and hold to mark them for messaging.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.pendingApplicants.length,
                itemBuilder: (context, index) {
                  final applicant = widget.pendingApplicants[index];
                  final isSelected = _selectedApplicants.contains(applicant.id);

                  return GestureDetector(
                    onTap: () {
                      widget.onSelectApplicant(applicant.id!);
                    },
                    onLongPress: () {
                      _toggleSelection(applicant.id!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                isSelected ? primaryColor : lightprimaryColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(
                            "${applicant.user!.firstName} ${applicant.user!.lastName}",
                          ),
                          subtitle: const Text("Status: Pending"),
                          leading: CircleAvatar(
                            radius: 35,
                            backgroundImage: applicant.user!.profileImg != "null"
                                ? NetworkImage(applicant.user!.profileImg ?? "")
                                : null,
                            backgroundColor: applicant.user!.profileImg == "null"
                                ? primaryColor.withOpacity(0.8)
                                : Colors.transparent,
                            child: applicant.user!.profileImg == "null"
                                ? Center(
                                    child: Text(
                                      "${applicant.user!.firstName![0].toUpperCase()} ${applicant.user!.lastName![0].toUpperCase()}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          onTap: () => {
                            showDialog(
                              context: context,
                              builder: (context) => ApplicantInfoDialog(
                                name:
                                    "${applicant.user!.firstName} ${applicant.user!.lastName}",
                                profileImageUrl:
                                    applicant.user!.profileImg ?? "",
                                resumeUrl: applicant.pdfPath ?? "",
                                motivationLetter:
                                    applicant.motivationLetter ?? "",
                                hasProfile: applicant.useProfile ?? false,
                                profileDetails: applicant.profileDetails,
                              ),
                            )
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            if (_selectedApplicants.isNotEmpty)
              Center(
                child: BigButton(
                  text: "Send Message",
                  onPressed: () {
                    widget.onSelectApplicants(_selectedApplicants);
                  },
                ),
              ),
          ],
          if (widget.pendingApplicants.isEmpty)
            const Center(
              child: Text("No applicants were chosen."),
            ),
        ],
      ),
    );
  }
}
