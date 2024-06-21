import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class WorkExperience extends StatefulWidget {
  final VoidCallback? iconOnPressed;
  final List<WorkExperiencesModel> experiences;
  final Function(String) editIconOnPressed;

  const WorkExperience({
    Key? key,
    required this.iconOnPressed,
    required this.experiences,
    required this.editIconOnPressed,
  }) : super(key: key);
  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    bool hasExperiences = widget.experiences.isNotEmpty;
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.4, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (int index, bool isExpanded) {
          if (hasExperiences) {
            setState(() {
              _isExpanded = !isExpanded;
            });
          }
        },
        children: [
          ExpansionPanel(
            hasIcon: false,
            backgroundColor: Colors.white,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return InkWell(
                onTap: () {
                  if (hasExperiences) {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  }
                },
                child: Container(
                  height: 56, // Set a fixed height for the header
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(Icons.work, color: primaryColor),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          "Work Experience",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: hasExperiences,
                        child: Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: greyColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: primaryColor,
                        ),
                        onPressed: widget.iconOnPressed,
                      ),
                    ],
                  ),
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: widget.experiences.map((experience) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                experience.jobTitle!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                experience.companyName!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                experience.duration!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.edit, color: primaryColor),
                            onPressed: () {
                              widget.editIconOnPressed(
                                  experience.id!); // Pass the ID here
                            }),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            isExpanded: _isExpanded,
            canTapOnHeader: true,
          ),
        ],
      ),
    );
  }
}
