import 'package:stacked/stacked.dart';

class EventsViewModel extends BaseViewModel {
  bool _hasNowEvents = false;
  bool _hasUpcomingEvents = false;
  bool _hasPastEvents = false;

  bool get hasNowEvents => _hasNowEvents;
  bool get hasUpcomingEvents => _hasUpcomingEvents;
  bool get hasPastEvents => _hasPastEvents;

  void onSearchPressed() {
    // TODO: Implement search functionality
  }

  void onMorePressed() {
    // TODO: Implement more options menu
  }

  void loadNowEvents() {
    setBusy(true);
    // TODO: Implement now events loading logic
    // For now, simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      _hasNowEvents = false;
      setBusy(false);
      notifyListeners();
    });
  }

  void loadUpcomingEvents() {
    setBusy(true);
    // TODO: Implement upcoming events loading logic
    // For now, simulate loading
    _hasUpcomingEvents = false;
    notifyListeners();
  }

  void loadPastEvents() {
    // TODO: Implement past events loading logic
    // For now, simulate that there are no past events
    _hasPastEvents = false;
    notifyListeners();
  }

  void loadEvents() {
    loadNowEvents();
    loadUpcomingEvents();
    loadPastEvents();
  }

  void initialise() {
    loadEvents();
  }
}
