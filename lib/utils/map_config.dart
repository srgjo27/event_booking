import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

/// Configuration for Free OpenStreetMap
class MapConfig {
  MapConfig._();

  // Default location (Jakarta, Indonesia)
  static const LatLng defaultLocation = LatLng(-6.21295, 106.8226);

  // Default zoom level
  static const double defaultZoom = 14.0;

  // Primary tile server - CartoDB (more reliable than OSM)
  static const String primaryTileServer =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png';

  // Tile layer configuration
  static const List<String> tileSubdomains = ['a', 'b', 'c'];
  static const String userAgentPackageName = 'com.event_booking';
  static const double maxZoom = 18.0;
  static const double minZoom = 5.0;

  // Sample event locations in Jakarta
  static List<Map<String, dynamic>> sampleEventLocations = [
    {
      'id': '1',
      'title': 'Music Festival 2024',
      'location': 'Central Park Mall',
      'position': const LatLng(-6.2088, 106.8456),
      'category': 'music',
      'color': Colors.red,
      'icon': Icons.music_note,
    },
    {
      'id': '2',
      'title': 'Food Carnival',
      'location': 'Grand Indonesia',
      'position': const LatLng(-6.1944, 106.8229),
      'category': 'food',
      'color': Colors.green,
      'icon': Icons.restaurant,
    },
    {
      'id': '3',
      'title': 'Art Exhibition',
      'location': 'National Gallery',
      'position': const LatLng(-6.1781, 106.8186),
      'category': 'art',
      'color': Colors.purple,
      'icon': Icons.palette,
    },
    {
      'id': '4',
      'title': 'Sports Tournament',
      'location': 'Gelora Bung Karno',
      'position': const LatLng(-6.2182, 106.8019),
      'category': 'sports',
      'color': Colors.orange,
      'icon': Icons.sports_soccer,
    },
  ];
}
