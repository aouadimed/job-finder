import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/features/onboarding/presentation/utils/on_boarding_utils.dart';
import 'package:cv_frontend/features/onboarding/presentation/widgets/on_boarding_item.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  int currentPage = 0;
  final onBoardingLength = OnBoardingUtils.onBoardingList.length;

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.toInt();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:const GeneralAppBar(haveReturn: false,),
        body: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: onBoardingLength,
              itemBuilder: (context, index) {
                return OnBoardingItem(
                  onBoardingModel: OnBoardingUtils.onBoardingList[index],
                );
              },
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onBoardingLength,
                          (index) => Container(
                            width: index == currentPage ? 29 : 12,
                            height: 10,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: index == currentPage
                                  ? primaryColor
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BigButton(
                      text: currentPage != onBoardingLength - 1
                          ? "Next"
                          : "Get Started",
                      onPressed: () {
                        if (currentPage < onBoardingLength - 1) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 10),
                            curve: Curves.linear,
                          );
                        } else {
                          TokenManager.token != null &&
                                  !TokenManager.isTokenExpired()
                              ? (TokenManager.role == 'recruiter'
                                  ? Navigator.pushReplacementNamed(
                                      context, recruiterNavBar)
                                  : Navigator.pushReplacementNamed(
                                      context, navBar))
                              : Navigator.pushReplacementNamed(
                                  context, loginScreen);
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
