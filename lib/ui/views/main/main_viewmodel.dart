import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
}
