import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/job_card.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/features/saved_jobs/data/models/saved_jobs_model.dart';

class RemoveSavedJobBottomSheet extends StatelessWidget {
  final SavedJob jobOffer;
  final Function() onConfirm;
  final List<String> item;

  const RemoveSavedJobBottomSheet({
    Key? key,
    required this.jobOffer,
    required this.onConfirm,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Remove from Saved?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          JobCard(
              companyName: jobOffer.companyName!,
              jobTitle: jobOffer.subcategoryName!,
              location: jobOffer.companyCountry!,
              items: item,
              companyLogoUrl: jobOffer.logoName!,
              onSave: () {},
              onTap: () {},
              isSaved: true),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: BigButton(
                      textColor: primaryColor,
                      color: lightprimaryColor,
                      text: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      })),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: BigButton(
                      text: "Yes, Remove",
                      onPressed: onConfirm)),
            ],
          ),
        ],
      ),
    );
  }
}
