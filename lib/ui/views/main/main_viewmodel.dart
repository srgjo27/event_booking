import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:event_booking/ui/views/home/home_view.dart';
import 'package:event_booking/ui/views/events/events_view.dart';
import 'package:event_booking/ui/views/map/map_view.dart';
import 'package:event_booking/ui/views/profile/profile_view.dart';

class MainViewModel extends BaseViewModel {
  late PageController _pageController;
  PageController get pageController => _pageController;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  MainViewModel() {
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();

      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onPageChanged(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const EventsView();
      case 2:
        return const MapView();
      case 3:
        return const ProfileView();
      default:
        return const HomeView();
    }
  }
}
