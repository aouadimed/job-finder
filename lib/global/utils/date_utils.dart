// date_utils.dart
import 'package:intl/intl.dart';

String getDuration({
  required DateTime startDate,
  required DateTime? endDate,
}) {
  final DateTime end = endDate ?? DateTime.now();
  int durationYears = end.year - startDate.year;
  int durationMonths = end.month - startDate.month;

  if (durationMonths < 0) {
    durationYears -= 1;
    durationMonths += 12;
  }

  if (durationYears == 0 && durationMonths == 0) {
    durationMonths = 1;
  }

  final String yearsText = durationYears > 0
      ? '$durationYears year${durationYears > 1 ? 's' : ''} '
      : '';
  final String monthsText = durationMonths > 0
      ? '$durationMonths month${durationMonths > 1 ? 's' : ''}'
      : '';

  final String duration = '$yearsText$monthsText'.trim();

  final DateFormat formatter = DateFormat('MMMM yyyy');
  final String startDateFormatted = formatter.format(startDate);
  final String endDateFormatted = endDate == null ? 'Present' : formatter.format(end);

  return '$startDateFormatted - $endDateFormatted ($duration)';
}


  String timeAgoFormessaging(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${difference.inDays ~/ 365}y ago';
    } else if (difference.inDays > 30) {
      return '${difference.inDays ~/ 30}m ago';
    } else if (difference.inDays > 7) {
      return '${difference.inDays ~/ 7}w ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'now';
    }
  }