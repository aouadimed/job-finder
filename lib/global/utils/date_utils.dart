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
