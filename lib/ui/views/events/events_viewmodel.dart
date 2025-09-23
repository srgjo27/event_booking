import 'package:stacked/stacked.dart';

class EventsViewModel extends BaseViewModel {
  bool _hasUpcomingEvents = false;
  bool _hasPastEvents = false;

  bool get hasUpcomingEvents => _hasUpcomingEvents;
  bool get hasPastEvents => _hasPastEvents;

  void onSearchPressed() {
    // TODO: Implement search functionality
  }

  void onMorePressed() {
    // TODO: Implement more options menu
  }

  void loadUpcomingEvents() {
    setBusy(true);
    // TODO: Implement upcoming events loading logic
    // For now, simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      _hasUpcomingEvents = false; // Set to true when you have actual data
      setBusy(false);
      notifyListeners();
    });
  }

  void loadPastEvents() {
    // TODO: Implement past events loading logic
    // For now, simulate that there are no past events
    _hasPastEvents = false; // Set to true when you have actual data
    notifyListeners();
  }

  void loadEvents() {
    loadUpcomingEvents();
    loadPastEvents();
  }

  void initialise() {
    loadEvents();
  }
}
