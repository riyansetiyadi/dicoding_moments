import 'package:dicoding_moments/common.dart';
import 'package:flutter/cupertino.dart';

class DateTimeHelper {
  String getTimeDifference(DateTime createdAtDateTime, BuildContext context) {
    Duration difference = DateTime.now().difference(createdAtDateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${AppLocalizations.of(context)?.storyDaysTimeCreatedText}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${AppLocalizations.of(context)?.storyHoursTimeCreatedText}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${AppLocalizations.of(context)?.storyMinutesTimeCreatedText}';
    } else {
      return AppLocalizations.of(context)?.storyNowTimeCreatedText ?? 'null';
    }
  }
}
