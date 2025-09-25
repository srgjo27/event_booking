import 'package:flutter/material.dart';

class Category {
  final String name;
  final String icon;
  final Color color;

  Category({required this.name, required this.icon, required this.color});
}

class Event {
  final String id;
  final String title;
  final String address;
  final String eventDate;
  final String month;
  final String day;
  final String time;
  final int attendeesCount;
  final String imageUrl;
  final String category;
  final double price;
  final bool isBookmarked;

  Event({
    required this.id,
    required this.title,
    required this.address,
    required this.eventDate,
    required this.month,
    required this.day,
    required this.time,
    required this.attendeesCount,
    required this.imageUrl,
    required this.category,
    required this.price,
    this.isBookmarked = false,
  });
}
