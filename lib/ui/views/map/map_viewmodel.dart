import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:event_booking/models/map_models.dart';
import 'package:event_booking/app/app.locator.dart';
import 'package:event_booking/app/app.bottomsheets.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:event_booking/utils/utils.dart';

class MapViewmodel extends BaseViewModel {
  final MapController _mapController = MapController();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  MapController get mapController => _mapController;

  List<Marker> _markers = [];
  final LatLng _currentLocation = MapConfig.defaultLocation;
  bool _isListView = false;
  String _searchQuery = '';
  double _currentZoom = MapConfig.defaultZoom;
  bool _isInitialized = false;

  List<Marker> get markers => _markers;
  LatLng get currentLocation => _currentLocation;
  bool get isListView => _isListView;
  String get searchQuery => _searchQuery;
  double get currentZoom => _currentZoom;

  void initialise() {
    if (_isInitialized) return;

    _loadEventMarkers();
    _isInitialized = true;
    notifyListeners();
  }

  void _loadEventMarkers() {
    _markers = MapConfig.sampleEventLocations.map((eventData) {
      return Marker(
        width: 40.0,
        height: 40.0,
        point: eventData['position'],
        child: GestureDetector(
          onTap: () => _onMarkerTapped(eventData),
          child: Container(
            decoration: BoxDecoration(
              color: eventData['color'],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              eventData['icon'],
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );
    }).toList();
  }

  void _onMarkerTapped(Map<String, dynamic> eventData) {
    final selectedEvent = SelectedEvent(
      title: eventData['title'],
      location: eventData['location'],
      date: 'Oct 25, 2024',
      description: 'Join us for an amazing ${eventData['category']} event!',
      imageUrl: '',
    );

    _showEventBottomSheet(selectedEvent);
  }

  void _showEventBottomSheet(SelectedEvent event) {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.eventDetail,
      title: event.title,
      description: event.description,
      data: event,
    );
  }

  void onSearchChanged(String query) {
    _searchQuery = query;
    _filterMarkers();
    notifyListeners();
  }

  void onFilterPressed() {
    // TODO: Show filter dialog
    debugPrint('Filter pressed');
  }

  void onZoomIn() {
    _currentZoom = (_currentZoom + 1).clamp(1.0, 18.0);
    _mapController.move(_mapController.camera.center, _currentZoom);
  }

  void onZoomOut() {
    _currentZoom = (_currentZoom - 1).clamp(1.0, 18.0);
    _mapController.move(_mapController.camera.center, _currentZoom);
  }

  void onCurrentLocationPressed() {
    _mapController.move(_currentLocation, _currentZoom);
  }

  void onToggleMapType() {
    _isListView = !_isListView;
    notifyListeners();
  }

  void onEventMarkerTapped(EventMarker marker) {
    // This method is kept for backward compatibility with the old UI
    // but now we use Flutter Map markers
  }

  void onDirectionsPressed() {
    // TODO: Show directions bottom sheet or navigate to directions
    debugPrint('Getting directions');
  }

  void onViewEventPressed() {
    // TODO: Navigate to event details page
    debugPrint('Viewing event details');
  }

  void _filterMarkers() {
    if (_searchQuery.isEmpty) {
      _loadEventMarkers();
      return;
    }

    final filteredEvents = MapConfig.sampleEventLocations.where((eventData) {
      return eventData['title']
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          eventData['location']
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          eventData['category']
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
    }).toList();

    _markers = filteredEvents.map((eventData) {
      return Marker(
        width: 40.0,
        height: 40.0,
        point: eventData['position'],
        child: GestureDetector(
          onTap: () => _onMarkerTapped(eventData),
          child: Container(
            decoration: BoxDecoration(
              color: eventData['color'],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              eventData['icon'],
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );
    }).toList();
  }
}
