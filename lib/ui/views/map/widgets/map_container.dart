import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:event_booking/ui/views/map/map_viewmodel.dart';
import 'package:event_booking/utils/map_config.dart';

class MapContainer extends StatelessWidget {
  final MapViewmodel viewModel;

  const MapContainer({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: viewModel.mapController,
      options: MapOptions(
        initialCenter: MapConfig.defaultLocation,
        initialZoom: MapConfig.defaultZoom,
        minZoom: 5.0,
        maxZoom: 18.0,
        onTap: (tapPosition, point) {
          if (viewModel.selectedEvent != null) {
            viewModel.closeEventDetails();
          }
        },
      ),
      children: [
        // OpenStreetMap tile layer (FREE!)
        TileLayer(
          urlTemplate: MapConfig.osmTileServer,
          userAgentPackageName: 'com.example.event_booking',
          maxZoom: 18,
        ),
        // Event markers layer
        MarkerLayer(
          markers: viewModel.markers,
        ),
        // Current location marker
        MarkerLayer(
          markers: [
            Marker(
              width: 20.0,
              height: 20.0,
              point: viewModel.currentLocation,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
