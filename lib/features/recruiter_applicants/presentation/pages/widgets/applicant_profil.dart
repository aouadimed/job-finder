import 'package:cv_frontend/features/recruiter_applicants/data/models/profil_details.dart';
import 'package:cv_frontend/global/utils/date_utils.dart';
import 'package:cv_frontend/global/utils/languages_data.dart';
import 'package:cv_frontend/global/utils/proficiencies_data.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/chip_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicantProfil extends StatefulWidget {
  final ProfileDetails profileDetails;
  const ApplicantProfil({super.key, required this.profileDetails});

  @override
  State<ApplicantProfil> createState() => _ApplicantProfilState();
}

class _ApplicantProfilState extends State<ApplicantProfil> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Scrollbar(
        interactive: true,
        thumbVisibility: true,
        controller: _scrollController,
        thickness: 10,
        radius: const Radius.circular(5),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              if (widget.profileDetails.contactInfo != null)
                _buildContactInfo(),
              if (widget.profileDetails.summary?.description != null)
                _buildSectionContainer(
                  "Summary",
                  Text(
                    widget.profileDetails.summary!.description!,
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
              if (widget.profileDetails.skills != null &&
                  widget.profileDetails.skills!.isNotEmpty)
                _buildSectionContainer("Skills", _buildSkillsList()),
              if (widget.profileDetails.workExperience != null &&
                  widget.profileDetails.workExperience!.isNotEmpty)
                _buildSectionContainer(
                    "Work Experience", _buildWorkExperienceList()),
              if (widget.profileDetails.projects != null &&
                  widget.profileDetails.projects!.isNotEmpty)
                _buildSectionContainer("Projects", _buildProjectsList()),
              if (widget.profileDetails.education != null &&
                  widget.profileDetails.education!.isNotEmpty)
                _buildSectionContainer("Education", _buildEducationList()),
              if (widget.profileDetails.languages != null &&
                  widget.profileDetails.languages!.isNotEmpty)
                _buildSectionContainer("Languages", _buildLanguagesList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              widget.profileDetails.profileImg ?? '',
              fit: BoxFit.cover,
              width: 150.0,
              height: 150.0,
              errorBuilder: (context, error, stackTrace) => Container(),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "- ${widget.profileDetails.name ?? 'Anonymous'} -",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionContainer(String title, Widget content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(title),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    );
  }

  Widget _buildContactInfo() {
    final contact = widget.profileDetails.contactInfo;
    return _buildSectionContainer(
      "Contact Information",
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email: ${contact?.email ?? 'Not provided'}",
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          Text(
            "Phone: ${contact?.phone ?? 'Not provided'}",
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          Text(
            "Location: ${contact?.address ?? 'Not provided'}",
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsList() {
    final skills = widget.profileDetails.skills!
        .map((s) => s.skill)
        .where((skill) => skill != null)
        .cast<String>()
        .toList();
    return ChipWidget(items: skills, alignment: WrapAlignment.center);
  }

  Widget _buildWorkExperienceList() {
    final experiences = widget.profileDetails.workExperience ?? [];
    return Column(
      children: experiences.map((experience) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimelineDot(isLast: experiences.last == experience),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.jobTitle ?? "Unknown Position",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      experience.companyName ?? "Unknown Company",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      "${getDurationAsString(startDate: experience.startDate!, endDate: experience.endDate)} • "
                      "${experience.employmentType == 1 ? 'Full-Time' : 'Part-Time'} • "
                      "${experience.locationType == 0 ? 'Remote' : 'On-Site'}",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    if (experience.description != null &&
                        experience.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          experience.description!,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 14),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProjectsList() {
    final projects = widget.profileDetails.projects ?? [];
    return Column(
      children: projects.map((project) {
        final associatedWith =
            project.workExperience == "000000000000000000000000"
                ? "Independent Project"
                : "Associated with: ${project.workExperience}";
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimelineDot(isLast: projects.last == project),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.projectName ?? "Unnamed Project",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      associatedWith,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      getDurationAsString(
                          startDate: project.startDate!,
                          endDate: project.endDate),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    if (project.description != null &&
                        project.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          project.description!,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 14),
                        ),
                      ),
                    if (project.projectUrl != null &&
                        project.projectUrl!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: InkWell(
                         onTap: () async {
                          final url = Uri.parse(project.projectUrl!);
                          try {
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            } else {
                              throw 'Could not launch $url';
                            }
                          } catch (e) {
                            print('Error: $e');
                          }
                        },
                          child: Text(
                            project.projectUrl!,
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEducationList() {
    final education = widget.profileDetails.education ?? [];
    return Column(
      children: education.map((edu) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimelineDot(isLast: education.last == edu),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${edu.degree ?? ''} in ${edu.fieldOfStudy ?? ''}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      edu.school ?? "Unknown School",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      "${getDurationAsString(startDate: edu.startDate!, endDate: edu.endDate)}"
                      "${edu.grade != null ? ' • Grade: ${edu.grade}' : ''}",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    if (edu.activitiesAndSocieties != null &&
                        edu.activitiesAndSocieties!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "Activities: ${edu.activitiesAndSocieties!}",
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 14),
                        ),
                      ),
                    if (edu.description != null && edu.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          edu.description!,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 14),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLanguagesList() {
    final language = widget.profileDetails.languages ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: language.map((lang) {
        return Text(
          "${languages[lang.language!]} - ${proficiencies[lang.language!]}",
          style: const TextStyle(color: Colors.black54, fontSize: 14),
        );
      }).toList(),
    );
  }

  Widget _buildTimelineDot({required bool isLast}) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
        if (!isLast)
          Container(
            width: 2,
            height: 60,
            color: Colors.grey[300],
          ),
      ],
    );
  }
}
