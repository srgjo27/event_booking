import 'package:flutter/services.dart';

mixin DialogMixin {
  /// Show loading dialog
  void showLoadingDialog() {
    // Implementation will depend on your dialog service
    // This is a placeholder for the pattern
  }

  /// Hide loading dialog
  void hideLoadingDialog() {
    // Implementation will depend on your dialog service
  }

  /// Show success message
  void showSuccessMessage(String message) {
    // Implementation for success snackbar/dialog
  }

  /// Show error message
  void showErrorMessage(String message) {
    // Implementation for error snackbar/dialog
  }

  /// Show confirmation dialog
  Future<bool> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'Ya',
    String cancelText = 'Tidak',
  }) async {
    // Return true if confirmed, false if cancelled
    // Implementation will depend on your dialog service
    return false;
  }
}

mixin HapticMixin {
  /// Light haptic feedback
  void lightHaptic() {
    HapticFeedback.lightImpact();
  }

  /// Medium haptic feedback
  void mediumHaptic() {
    HapticFeedback.mediumImpact();
  }

  /// Heavy haptic feedback
  void heavyHaptic() {
    HapticFeedback.heavyImpact();
  }

  /// Selection haptic feedback
  void selectionHaptic() {
    HapticFeedback.selectionClick();
  }
}
