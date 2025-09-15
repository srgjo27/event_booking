import 'package:event_booking/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:event_booking/app/app.locator.dart';

import 'package:event_booking/ui/common/app_images.dart';

class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final PageController pageController = PageController();

  int _currentPage = 0;
  int get currentPage => _currentPage;

  final List<OnboardingContent> contents = [
    OnboardingContent(
      image: AppImages.illustrationOnboarding1,
      title: 'Explore Upcoming and\nNearby Events',
      description:
          'In publishing and graphic design, Lorem is a placeholder text commonly',
    ),
    OnboardingContent(
      image: AppImages.illustrationOnboarding2,
      title: 'Web Have Modern Events\nCalendar Feature',
      description:
          'In publishing and graphic design, Lorem is a placeholder text commonly',
    ),
    OnboardingContent(
      image: AppImages.illustrationOnboarding3,
      title: 'To Look Up More Events or\nActivities Nearby By Map',
      description:
          'In publishing and graphic design, Lorem is a placeholder text commonly',
    ),
  ];

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void next() {
    if (_currentPage < contents.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _navigationService.replaceWithLoginView();
    }
  }

  void skip() {
    _navigationService.replaceWithLoginView();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
