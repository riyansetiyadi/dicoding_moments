import 'package:dicoding_moments/common.dart';
import 'package:flutter/cupertino.dart';

class DateTimeHelper {
  String getTimeDifference(DateTime createdAtDateTime, BuildContext context) {
    Duration difference = DateTime.now().difference(createdAtDateTime);

    if (yearsDifference(createdAtDateTime, DateTime.now()) > 0) {
      return '${difference.inDays} ${AppLocalizations.of(context)?.storyYearsTimeCreatedText}';
    } else if (monthsDifference(createdAtDateTime, DateTime.now()) > 0) {
      return '${difference.inDays} ${AppLocalizations.of(context)?.storyMonthTimeCreatedText}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${AppLocalizations.of(context)?.storyDaysTimeCreatedText}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${AppLocalizations.of(context)?.storyHoursTimeCreatedText}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${AppLocalizations.of(context)?.storyMinutesTimeCreatedText}';
    } else {
      return AppLocalizations.of(context)?.storyNowTimeCreatedText ?? 'null';
    }
  }

  int monthsDifference(DateTime startDate, DateTime endDate) {
    int yearDiff = endDate.year - startDate.year;
    int monthDiff = endDate.month - startDate.month;
    return yearDiff * 12 + monthDiff;
  }

  int yearsDifference(DateTime startDate, DateTime endDate) {
    return endDate.year - startDate.year;
  }
}
