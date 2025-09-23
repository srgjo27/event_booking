import 'package:intl/intl.dart';

mixin DateTimeMixin {
  /// Format date to readable string (dd MMM yyyy)
  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Format date with time (dd MMM yyyy, HH:mm)
  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
  }

  /// Format time only (HH:mm)
  String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  /// Get relative time (e.g., "2 hours ago", "Yesterday")
  String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return formatDate(dateTime);
    } else if (difference.inDays >= 1) {
      return difference.inDays == 1
          ? 'Kemarin'
          : '${difference.inDays} hari lalu';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} menit lalu';
    } else {
      return 'Baru saja';
    }
  }

  /// Check if date is today
  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  /// Check if date is tomorrow
  bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.day == tomorrow.day &&
        date.month == tomorrow.month &&
        date.year == tomorrow.year;
  }

  /// Check if event is upcoming (future date)
  bool isUpcoming(DateTime eventDate) {
    return eventDate.isAfter(DateTime.now());
  }

  /// Check if event is past
  bool isPast(DateTime eventDate) {
    return eventDate.isBefore(DateTime.now());
  }
}
