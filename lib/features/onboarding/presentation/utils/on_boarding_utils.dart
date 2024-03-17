import 'package:cv_frontend/core/constants/image_res.dart';
import 'package:equatable/equatable.dart';

abstract class OnBoardingUtils {
  const OnBoardingUtils._();

  static List<OnBoardingModel> onBoardingList = const [
    OnBoardingModel(
      imagePath: onBoardingImage1,
      title: "We Are the best job portal platform",
      description: "Lorem Ipsum is simply dummy text of the printing and "
          "typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
    ),
    OnBoardingModel(
      imagePath: onBoardingImage1,
      title: "The place where work finds you",
      description: "Lorem Ipsum is simply dummy text of the printing and "
          "typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
    ),
    OnBoardingModel(
      imagePath: onBoardingImage1,
      title: "Let's start your career with us now !",
      description: "Lorem Ipsum is simply dummy text of the printing and "
          "typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
    ),
  ];
}

class OnBoardingModel extends Equatable {
  final String imagePath;
  final String title;
  final String description;

  const OnBoardingModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  List<String> get props => [imagePath, title, description];
}
