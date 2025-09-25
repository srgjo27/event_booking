import 'package:event_booking/models/event_models.dart';
import 'package:stacked/stacked.dart';

class EventDetailViewModel extends BaseViewModel {
  Event? event;

  EventDetailViewModel({
    required Event initialEvent,
  }) {
    event = initialEvent;
  }
}
