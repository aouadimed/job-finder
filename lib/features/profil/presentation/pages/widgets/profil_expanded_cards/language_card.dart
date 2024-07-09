import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/comman_expandable.dart';
import 'package:cv_frontend/global/utils/languages_data.dart';
import 'package:cv_frontend/global/utils/proficiencies_data.dart';
import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  final List<LanguageModel> language;
  final VoidCallback onAddPressed;
  final Function(String) onEditPressed;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;
    final GlobalKey sectionKey; 

  const LanguageCard(
      {super.key,
      required this.onAddPressed,
      required this.onEditPressed,
      required this.language,
      required this.isExpanded,
      required this.onExpansionChanged, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return CommonExpandableList<LanguageModel>(
      iconOnPressed: onAddPressed,
      items: language,
      headerTitle: "Languages",
      headerIcon: Icons.language,
      editIconOnPressed: onEditPressed,
      itemBuilder: (language) {
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languages[language.language!],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  (language.proficiencyIndex != 0)
                      ? Text(
                          proficiencies[language.proficiencyIndex!],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: primaryColor),
              onPressed: () {
                onEditPressed(language.id!); // Pass the ID here
              },
            ),
          ],
        );
      },
      isExpanded: isExpanded,
      onExpansionChanged: onExpansionChanged, sectionKey: sectionKey,
    );
  }
}
