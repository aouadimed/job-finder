  import 'package:cv_frontend/global/utils/country_code_data.dart';

String countryCodeFromCountryName(String countryName) {
    String? countryCode = countryNameToCode[countryName];
    return countryCode ?? '';
  }

  String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${difference.inDays ~/ 365} year(s) ago';
    } else if (difference.inDays > 30) {
      return '${difference.inDays ~/ 30} month(s) ago';
    } else if (difference.inDays > 7) {
      return '${difference.inDays ~/ 7} week(s) ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day(s) ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour(s) ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute(s) ago';
    } else {
      return 'just now';
    }
  }

  List<String> formatBulletPoints(String text) {
    return text.split('\n').map((line) => '• $line').toList();
  }


