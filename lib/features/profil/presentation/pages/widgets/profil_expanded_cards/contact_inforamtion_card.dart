import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/contact_info_model.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/comman_expandable.dart';
import 'package:flutter/material.dart';

class ContactInformationCard extends StatelessWidget {
  final VoidCallback? iconOnPressed;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;
  final GlobalKey sectionKey;
  final ContactInfoModel contactInfo;

  const ContactInformationCard({
    Key? key,
    required this.iconOnPressed,
    required this.isExpanded,
    required this.onExpansionChanged,
    required this.sectionKey,
    required this.contactInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonExpandableList<Widget>(
       icon: Icons.edit,
      iconOnPressed: iconOnPressed,
      items: [
        _buildContactInfoRow(
          context,
          icon: Icons.location_on,
          label: contactInfo.address!,
        ),
        _buildContactInfoRow(
          context,
          icon: Icons.phone,
          label: contactInfo.phone!,
        ),
        _buildContactInfoRow(
          context,
          icon: Icons.email,
          label: contactInfo.email!,
        ),
      ],
      headerTitle: "Contact Information",
      headerIcon: Icons.person,
      itemBuilder: (item) => item,
      isExpanded: isExpanded,
      onExpansionChanged: onExpansionChanged,
      sectionKey: sectionKey,
    );
  }

  Widget _buildContactInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    TextStyle? textStyle,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Icon(icon, color: greyColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: textStyle ?? const TextStyle(fontSize: 14, color: Colors.black),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 4),
          trailing,
        ],
      ],
    );
  }
}
