import 'package:stacked/stacked.dart';

class EventsViewModel extends BaseViewModel {
  bool _hasEvents = false;
  bool get hasEvents => _hasEvents;

  void onSearchPressed() {
    // TODO: Implement search functionality
  }

  void onMorePressed() {
    // TODO: Implement more options menu
  }

  void loadEvents() {
    setBusy(true);
    // TODO: Implement event loading logic
    // For now, simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      _hasEvents = false;
      setBusy(false);
      notifyListeners();
    });
  }

  void initialise() {
    loadEvents();
  }
}
