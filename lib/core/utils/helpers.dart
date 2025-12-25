import 'package:intl/intl.dart';

class TimeHelper {
  static const String _outputFormat = 'MMM d, yyyy, h:mm a';

  static String safeUtc(String utcTimeString) {
    return utcTimeString.endsWith('Z') ? utcTimeString : '${utcTimeString}Z';
  }

  static DateTime utcToLocalDateTime(String utcTimeString) {
    final utcDateTime = DateTime.parse(safeUtc(utcTimeString));
    final localDateTime = utcDateTime.toLocal();

    return localDateTime;
  }

  static String formatUtcToLocal(String utcTimeString) {
    if (utcTimeString.isEmpty) {
      return 'N/A';
    }

    try {
      // final normalized = utcTimeString.endsWith('Z')
      //     ? utcTimeString
      //     : '${utcTimeString}Z';

      final utcDateTime = DateTime.parse(safeUtc(utcTimeString));
      final localDateTime = utcDateTime.toLocal();

      final formatter = DateFormat(_outputFormat, Intl.systemLocale);

      return formatter.format(localDateTime);
    } catch (e) {
      print('Error parsing date string: $utcTimeString. Error: $e');
      return 'Invalid Date';
    }
  }

  static String formatUtcToLocalDate(String utcTimeString) {
    if (utcTimeString.isEmpty) {
      return 'N/A';
    }

    try {
      final utcDateTime = DateTime.parse(safeUtc(utcTimeString));
      final localDateTime = utcDateTime.toLocal();

      final formatter = DateFormat('MMM d, yyyy', Intl.systemLocale);

      return formatter.format(localDateTime);
    } catch (e) {
      print('Error parsing date string: $utcTimeString. Error: $e');
      return 'Invalid Date';
    }
  }

  static String formatUtcToLocalMonth(String utcTimeString) {
    if (utcTimeString.isEmpty) {
      return 'N/A';
    }

    try {
      final utcDateTime = DateTime.parse(safeUtc(utcTimeString));
      final localDateTime = utcDateTime.toLocal();

      final formatter = DateFormat('MMM, yyyy', Intl.systemLocale);

      return formatter.format(localDateTime);
    } catch (e) {
      print('Error parsing date string: $utcTimeString. Error: $e');
      return 'Invalid Date';
    }
  }

  static bool isUtcTimeExpired(String utcTimeString) {
    if (utcTimeString.isEmpty) {
      return true;
    }

    try {
      // final normalized = utcTimeString.endsWith('Z')
      //     ? utcTimeString
      //     : '${utcTimeString}Z';

      final utcDateTime = DateTime.parse(safeUtc(utcTimeString));
      final localDateTime = utcDateTime.toLocal();

      return localDateTime.isBefore(DateTime.now());
    } catch (e) {
      print('Error parsing date string: $utcTimeString. Error: $e');
      return false;
    }
  }

  static String formatRelativeTime(String dateTimeString) {
    final now = DateTime.now().toLocal();
    final difference = now.difference(utcToLocalDateTime(dateTimeString));

    const int minute = 60;
    const int hour = minute * 60;
    const int day = hour * 24;
    const int week = day * 7;
    const int month = day * 30;
    const int year = day * 365;

    final int seconds = difference.inSeconds;

    if (seconds < minute) {
      return 'just now';
    } else if (seconds < hour) {
      final minutes = difference.inMinutes;
      return '$minutes minute${minutes > 1 ? 's' : ''} ago';
    } else if (seconds < day) {
      final hours = difference.inHours;
      return '$hours hour${hours > 1 ? 's' : ''} ago';
    } else if (seconds < day * 2) {
      return 'yesterday';
    } else if (seconds < week) {
      final days = difference.inDays;
      return '$days day${days > 1 ? 's' : ''} ago';
    } else if (seconds < month) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (seconds < year) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }
}
