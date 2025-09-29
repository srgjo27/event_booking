import 'package:event_booking/app/app.locator.dart';
import 'package:event_booking/app/app.bottomsheets.dart';
import 'package:event_booking/app/app.router.dart';
import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/common/app_icons.dart';
import 'package:event_booking/models/event_models.dart';
import 'package:event_booking/ui/common/app_images.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  final searchController = TextEditingController();
  late final FocusNode searchFocusNode;

  HomeViewModel() {
    searchFocusNode = FocusNode();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  void onTabTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void selectCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  final List<Category> categories = [
    Category(
        name: 'Sports', icon: AppIcons.icSport, color: AppColors.terracotta),
    Category(
        name: 'Music', icon: AppIcons.icMusic, color: AppColors.vibrantRed),
    Category(name: 'Food', icon: AppIcons.icFood, color: AppColors.mintGreen),
    Category(name: 'Art', icon: AppIcons.icArt, color: AppColors.skyBlue),
  ];

  final List<Event> events = [
    Event(
      id: 'event_001',
      title: 'International Band Music Concert',
      address: '36 Guild Street London, UK',
      eventDate: '2024-06-10',
      month: 'JUNE',
      day: '10',
      time: '18:00',
      attendeesCount: 120,
      imageUrl: AppImages.imgIllustrationMusicEvent,
      category: 'Music',
      price: 25.0,
      isBookmarked: true,
    ),
    Event(
      id: 'event_002',
      title: 'Football Championship 2024',
      address: 'Wembley Stadium, London, UK',
      eventDate: '2024-07-15',
      month: 'JULY',
      day: '15',
      time: '20:00',
      attendeesCount: 89000,
      imageUrl: null,
      category: 'Sports',
      price: 45.0,
      isBookmarked: false,
    ),
    Event(
      id: 'event_003',
      title: 'Gourmet Food Festival',
      address: 'Hyde Park, London, UK',
      eventDate: '2024-08-20',
      month: 'AUG',
      day: '20',
      time: '12:00',
      attendeesCount: 2500,
      imageUrl: null,
      category: 'Food',
      price: 15.0,
      isBookmarked: true,
    ),
    Event(
      id: 'event_004',
      title: 'Modern Art Exhibition',
      address: 'Tate Modern, London, UK',
      eventDate: '2024-09-05',
      month: 'SEP',
      day: '05',
      time: '10:00',
      attendeesCount: 350,
      imageUrl: null,
      category: 'Art',
      price: 12.0,
      isBookmarked: false,
    ),
    Event(
      id: 'event_005',
      title: 'Jazz Night Live',
      address: 'Royal Albert Hall, London, UK',
      eventDate: '2024-09-18',
      month: 'SEP',
      day: '18',
      time: '19:30',
      attendeesCount: 780,
      imageUrl: null,
      category: 'Music',
      price: 35.0,
      isBookmarked: true,
    ),
    Event(
      id: 'event_006',
      title: 'Marathon London 2024',
      address: 'The Mall, London, UK',
      eventDate: '2024-10-12',
      month: 'OCT',
      day: '12',
      time: '08:00',
      attendeesCount: 45000,
      imageUrl: null,
      category: 'Sports',
      price: 0.0,
      isBookmarked: false,
    ),
    Event(
      id: 'event_007',
      title: 'Street Food Market',
      address: 'Camden Market, London, UK',
      eventDate: '2024-10-25',
      month: 'OCT',
      day: '25',
      time: '11:00',
      attendeesCount: 1200,
      imageUrl: null,
      category: 'Food',
      price: 8.0,
      isBookmarked: true,
    ),
    Event(
      id: 'event_008',
      title: 'Photography Workshop',
      address: 'Somerset House, London, UK',
      eventDate: '2024-11-08',
      month: 'NOV',
      day: '08',
      time: '14:00',
      attendeesCount: 50,
      imageUrl: null,
      category: 'Art',
      price: 75.0,
      isBookmarked: false,
    ),
  ];

  List<Event> get upcomingEvents {
    if (_selectedCategory == null) {
      return events;
    }
    return getEventsByCategory(_selectedCategory!);
  }

  List<Event> getEventsByCategory(String category) {
    return events.where((event) => event.category == category).toList();
  }

  String formatAttendeesCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(0)}K+ Going';
    }
    return '$count Going';
  }

  Future<void> showFilterOptions() async {
    await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.base,
      isScrollControlled: true,
      title: 'Filter Options',
      description: 'Select your filter options below',
      mainButtonTitle: 'Ok',
      secondaryButtonTitle: 'Cancel',
    );
  }

  void navigateToEventDetail(Event event) {
    _navigationService.navigateTo(
      Routes.eventDetailView,
      arguments: EventDetailViewArguments(
        event: event,
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }
}
