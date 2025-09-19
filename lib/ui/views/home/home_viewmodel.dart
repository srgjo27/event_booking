import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/common/app_icons.dart';
import 'package:event_booking/models/models.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  // final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  final searchController = TextEditingController();

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
      title: 'International Band Music Concert',
      address: '36 Guild Street London, UK',
      eventDate: '2024-06-10',
      month: 'JUNE',
      day: '10',
      time: '18:00',
      attendeesCount: 120,
      imageUrl: 'assets/images/event_music.jpg',
      category: 'Music',
      price: 25.0,
      isBookmarked: true,
    ),
    Event(
      title: 'Football Championship 2024',
      address: 'Wembley Stadium, London, UK',
      eventDate: '2024-07-15',
      month: 'JULY',
      day: '15',
      time: '20:00',
      attendeesCount: 89000,
      imageUrl: 'assets/images/event_sports.jpg',
      category: 'Sports',
      price: 45.0,
      isBookmarked: false,
    ),
    Event(
      title: 'Gourmet Food Festival',
      address: 'Hyde Park, London, UK',
      eventDate: '2024-08-20',
      month: 'AUG',
      day: '20',
      time: '12:00',
      attendeesCount: 2500,
      imageUrl: 'assets/images/event_food.jpg',
      category: 'Food',
      price: 15.0,
      isBookmarked: true,
    ),
    Event(
      title: 'Modern Art Exhibition',
      address: 'Tate Modern, London, UK',
      eventDate: '2024-09-05',
      month: 'SEP',
      day: '05',
      time: '10:00',
      attendeesCount: 350,
      imageUrl: 'assets/images/event_art.jpg',
      category: 'Art',
      price: 12.0,
      isBookmarked: false,
    ),
    Event(
      title: 'Jazz Night Live',
      address: 'Royal Albert Hall, London, UK',
      eventDate: '2024-09-18',
      month: 'SEP',
      day: '18',
      time: '19:30',
      attendeesCount: 780,
      imageUrl: 'assets/images/event_jazz.jpg',
      category: 'Music',
      price: 35.0,
      isBookmarked: true,
    ),
    Event(
      title: 'Marathon London 2024',
      address: 'The Mall, London, UK',
      eventDate: '2024-10-12',
      month: 'OCT',
      day: '12',
      time: '08:00',
      attendeesCount: 45000,
      imageUrl: 'assets/images/event_marathon.jpg',
      category: 'Sports',
      price: 0.0,
      isBookmarked: false,
    ),
    Event(
      title: 'Street Food Market',
      address: 'Camden Market, London, UK',
      eventDate: '2024-10-25',
      month: 'OCT',
      day: '25',
      time: '11:00',
      attendeesCount: 1200,
      imageUrl: 'assets/images/event_street_food.jpg',
      category: 'Food',
      price: 8.0,
      isBookmarked: true,
    ),
    Event(
      title: 'Photography Workshop',
      address: 'Somerset House, London, UK',
      eventDate: '2024-11-08',
      month: 'NOV',
      day: '08',
      time: '14:00',
      attendeesCount: 50,
      imageUrl: 'assets/images/event_photography.jpg',
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

  void toggleBookmark(int eventIndex) {
    notifyListeners();
  }

  List<Event> get bookmarkedEvents {
    return events.where((event) => event.isBookmarked).toList();
  }

  String formatEventPrice(double price) {
    if (price == 0.0) {
      return 'Free';
    }
    return '\$${price.toStringAsFixed(0)}';
  }

  String formatAttendeesCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(0)}K+ Going';
    }
    return '$count Going';
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
