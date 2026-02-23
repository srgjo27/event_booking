import 'package:event_booking/app/app.locator.dart';
import 'package:event_booking/models/event_models.dart';
import 'package:event_booking/utils/format_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EventDetailViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Event? event;
  bool _isBookmarked = false;

  EventDetailViewModel({
    required Event initialEvent,
  }) {
    event = initialEvent;
    _isBookmarked = initialEvent.isBookmarked;
  }

  bool get isBookmarked => _isBookmarked;

  void goBack() {
    _navigationService.back();
  }

  void toggleBookmark() {
    _isBookmarked = !_isBookmarked;
    notifyListeners();
  }

  void bookEvent() {
    // TODO: Implement booking logic
    // This could navigate to a booking/payment screen
    // For now, just show a simple feedback
    setBusy(true);

    // Simulate booking process
    Future.delayed(const Duration(seconds: 1), () {
      setBusy(false);
      // Could show success dialog or navigate to booking confirmation
    });
  }

  String formatPrice(double price) => FormatHelpers.formatPrice(price);

  String formatAttendeesCount(int count) =>
      FormatHelpers.formatAttendeesCount(count);
}
