import 'package:event_booking/app/app.locator.dart';
import 'package:event_booking/app/app.router.dart';
import 'package:event_booking/models/event_models.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EventsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  List<Event> _allEvents = [];
  List<Event> _nowEvents = [];
  List<Event> _upcomingEvents = [];
  List<Event> _pastEvents = [];

  List<Event> get allEvents => _allEvents;
  List<Event> get nowEvents => _nowEvents;
  List<Event> get upcomingEvents => _upcomingEvents;
  List<Event> get pastEvents => _pastEvents;

  void onSearchPressed() {
    // TODO: Implement search functionality
  }

  void onMorePressed() {
    // TODO: Implement more options menu
  }

  void navigateToEventDetail(Event event) {
    _navigationService.navigateToEventDetailView(event: event);
  }

  void toggleEventBookmark(Event event) {
    final index = _allEvents.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      // In a real app, you would update this in a service or repository
      // For now, we'll just toggle the local state
      notifyListeners();
    }
  }

  void _loadSampleEvents() {
    _allEvents = [
      Event(
        id: 'event_001',
        title: 'International Band Music Concert',
        address: '36 Guild Street London, UK',
        eventDate: '2025-10-15',
        month: 'OCT',
        day: '15',
        time: '18:00',
        attendeesCount: 120,
        imageUrl: 'assets/images/event_music.jpg',
        category: 'Music',
        price: 25.0,
        isBookmarked: true,
      ),
      Event(
        id: 'event_002',
        title: 'Food Festival 2024',
        address: 'Central Park, New York',
        eventDate: '2024-09-30',
        month: 'SEP',
        day: '30',
        time: '12:00',
        attendeesCount: 85,
        imageUrl: 'assets/images/event_food.jpg',
        category: 'Food',
        price: 15.0,
        isBookmarked: false,
      ),
      Event(
        id: 'event_003',
        title: 'Art Exhibition Modern',
        address: 'Gallery District, Paris',
        eventDate: '2024-11-05',
        month: 'NOV',
        day: '05',
        time: '10:00',
        attendeesCount: 45,
        imageUrl: 'assets/images/event_art.jpg',
        category: 'Art',
        price: 0.0,
        isBookmarked: true,
      ),
      Event(
        id: 'event_004',
        title: 'Football Championship',
        address: 'Sports Arena, Madrid',
        eventDate: '2024-08-20',
        month: 'AUG',
        day: '20',
        time: '15:30',
        attendeesCount: 500,
        imageUrl: 'assets/images/event_sports.jpg',
        category: 'Sports',
        price: 35.0,
        isBookmarked: false,
      ),
      Event(
        id: 'event_005',
        title: 'Jazz Night Live',
        address: 'Blue Note Club, Tokyo',
        eventDate: '2024-09-28',
        month: 'SEP',
        day: '28',
        time: '20:00',
        attendeesCount: 80,
        imageUrl: 'assets/images/event_jazz.jpg',
        category: 'Music',
        price: 30.0,
        isBookmarked: true,
      ),
      Event(
        id: 'event_006',
        title: 'Tech Conference 2024',
        address: 'Convention Center, San Francisco',
        eventDate: '2024-12-10',
        month: 'DEC',
        day: '10',
        time: '09:00',
        attendeesCount: 250,
        imageUrl: 'assets/images/event_tech.jpg',
        category: 'Technology',
        price: 50.0,
        isBookmarked: false,
      ),
    ];
  }

  void _categorizeEvents() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    _nowEvents = [];
    _upcomingEvents = [];
    _pastEvents = [];

    for (final event in _allEvents) {
      try {
        final eventDate = DateTime.parse(event.eventDate);
        final eventDay =
            DateTime(eventDate.year, eventDate.month, eventDate.day);

        if (eventDay.isAtSameMomentAs(today)) {
          _nowEvents.add(event);
        } else if (eventDay.isAfter(today)) {
          _upcomingEvents.add(event);
        } else {
          _pastEvents.add(event);
        }
      } catch (e) {
        // If date parsing fails, add to past events as fallback
        _pastEvents.add(event);
      }
    }

    // Sort events by date
    _nowEvents.sort((a, b) => a.time.compareTo(b.time));
    _upcomingEvents.sort((a, b) => a.eventDate.compareTo(b.eventDate));
    _pastEvents.sort((a, b) => b.eventDate.compareTo(a.eventDate));
  }

  void loadEvents() {
    setBusy(true);

    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      _loadSampleEvents();
      _categorizeEvents();
      setBusy(false);
      notifyListeners();
    });
  }

  void initialise() {
    loadEvents();
  }
}
