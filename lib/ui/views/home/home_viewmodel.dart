import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/common/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Category {
  final String name;
  final String icon;
  final Color color;

  Category({required this.name, required this.icon, required this.color});
}

class HomeViewModel extends BaseViewModel {
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
        name: 'Sports', icon: AppIcons.icSport, color: AppColors.kcSportsColor),
    Category(
        name: 'Music', icon: AppIcons.icMusic, color: AppColors.kcMusicColor),
    Category(name: 'Food', icon: AppIcons.icFood, color: AppColors.kcFoodColor),
    Category(name: 'Art', icon: AppIcons.icArt, color: AppColors.kcArtColor),
  ];
}
