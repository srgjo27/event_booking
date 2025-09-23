import 'package:flutter/material.dart';

class EventMarker {
  final String id;
  final String title;
  final String location;
  final String date;
  final Offset position;
  final Color color;
  final IconData icon;
  final String category;

  EventMarker({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.position,
    required this.color,
    required this.icon,
    required this.category,
  });
}

class SelectedEvent {
  final String title;
  final String location;
  final String date;
  final String description;
  final String imageUrl;

  SelectedEvent({
    required this.title,
    required this.location,
    required this.date,
    required this.description,
    required this.imageUrl,
  });
}
