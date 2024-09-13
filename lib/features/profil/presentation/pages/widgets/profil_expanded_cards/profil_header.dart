import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/profil_header_model.dart';
import 'package:flutter/material.dart';

class MainProfileHeader extends StatelessWidget {
  final ProfilHeaderModel profileHeader;
  final VoidCallback onEdit;

  const MainProfileHeader({
    Key? key,
    required this.profileHeader,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: profileHeader.profilImg != "undefined"
                ? NetworkImage(profileHeader.profilImg)
                : null,
            backgroundColor: profileHeader.profilImg == "undefined"
                ? primaryColor.withOpacity(0.8)
                : Colors.transparent,
            child: profileHeader.profilImg == "undefined"
                ? Center(
                    child: Text(
                      "${profileHeader.firstName[0].toUpperCase()}  ${profileHeader.lastName[0].toUpperCase()}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${profileHeader.firstName} ${profileHeader.lastName}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onEdit,
            child: Icon(Icons.edit, color: primaryColor),
          ),
        ],
      ),
    );
  }
}
