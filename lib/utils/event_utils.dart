import 'package:event_booking/ui/common/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/common/app_strings.dart';

/// Utility class for event-related helper functions
class EventUtils {
  /// Private constructor to prevent instantiation
  EventUtils._();

  /// Returns the appropriate color for a given event category
  ///
  /// [category] - The category name (case insensitive)
  /// Returns a color with reduced opacity for better visual appearance
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case CategoryConstants.sports:
        return AppColors.terracotta.withAlpha(51);
      case CategoryConstants.music:
        return AppColors.vibrantRed.withAlpha(51);
      case CategoryConstants.food:
        return AppColors.mintGreen.withAlpha(51);
      case CategoryConstants.art:
        return AppColors.skyBlue.withAlpha(51);
      default:
        return AppColors.primary.withAlpha(51);
    }
  }

  static String getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'music':
        return AppIcons.icMusic;
      case 'sports':
        return AppIcons.icSport;
      case 'food':
        return AppIcons.icFood;
      case 'art':
        return AppIcons.icArt;
      case 'technology':
        return '';
      default:
        return '';
    }
  }
}
