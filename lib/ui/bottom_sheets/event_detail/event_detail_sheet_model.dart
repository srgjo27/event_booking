import 'package:stacked/stacked.dart';
import 'package:event_booking/models/map_models.dart';

class EventDetailSheetModel extends BaseViewModel {
  final SelectedEvent? _selectedEvent;
  SelectedEvent? get selectedEvent => _selectedEvent;

  EventDetailSheetModel(this._selectedEvent);

  void onSaveEvent() {
    // TODO: Implement save event functionality
    print('Save event: ${_selectedEvent?.title}');
  }

  void onViewDetails() {
    // TODO: Implement view details navigation
    print('View details: ${_selectedEvent?.title}');
  }
}
