import 'package:ezdu/data/models/enum.dart';

extension NotificationTypeExtension on NotificationType {
  String toDisplayString() {
    return toString().split('.').last;
  }

  static NotificationType fromString(String value) {
    return NotificationType.values.firstWhere(
          (e) => e.toString().split('.').last == value,
      orElse: () => NotificationType.notification,
    );
  }
}