import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/extension/context_extension.dart';
import 'package:cv_frontend/features/onboarding/presentation/utils/on_boarding_utils.dart';
import 'package:flutter/material.dart';

class OnBoardingItem extends StatelessWidget {
  final OnBoardingModel onBoardingModel;

  const OnBoardingItem({
    super.key,
    required this.onBoardingModel,
  });

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context);
    return Column(
      children: [
        SizedBox(
          height: context.height * .45,
          child: Image.asset(onBoardingModel.imagePath,fit: BoxFit.cover),
        ),
       
        Padding(
         padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Text(
            onBoardingModel.title,
            textAlign: TextAlign.center,
            style: context.theme.textTheme.displaySmall?.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            onBoardingModel.description,
            textAlign: TextAlign.justify,
            style: context.theme.textTheme.labelLarge?.copyWith(
              letterSpacing: 1.15,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
