class FormatHelpers {
  /// Formats price value. Returns 'Free' for 0, otherwise returns formatted price
  static String formatPrice(double price) {
    if (price == 0) {
      return 'Free';
    }
    return '\$${price.toStringAsFixed(0)}';
  }

  /// Formats attendees count. Returns 'XK+ Going' for 1000+, otherwise 'X Going'
  static String formatAttendeesCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(0)}K+ Going';
    }
    return '$count Going';
  }
}
