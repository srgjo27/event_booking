import 'package:flutter/material.dart';
import 'package:event_booking/ui/common/app_colors.dart';

/// Utility class for category-related helper functions
class CategoryUtils {
  /// Private constructor to prevent instantiation
  CategoryUtils._();

  /// Returns the appropriate color for a given category
  ///
  /// [category] - The category name (case insensitive)
  /// Returns a color with reduced opacity for better visual appearance
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'sports':
        return AppColors.terracotta.withAlpha(51);
      case 'music':
        return AppColors.vibrantRed.withAlpha(51);
      case 'food':
        return AppColors.mintGreen.withAlpha(51);
      case 'art':
        return AppColors.skyBlue.withAlpha(51);
      default:
        return AppColors.primary.withAlpha(51);
    }
  }
}
