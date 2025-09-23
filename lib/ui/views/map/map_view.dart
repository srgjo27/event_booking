import 'package:event_booking/ui/views/map/map_viewmodel.dart';
import 'package:event_booking/utils/map_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_map/flutter_map.dart';

class MapView extends StackedView<MapViewmodel> {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, MapViewmodel viewModel, Widget? child) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildMapContainer(context, viewModel),
          _buildSearchBar(context, viewModel),
          _buildMapControls(context, viewModel),
          if (viewModel.selectedEvent != null) ...[
            _buildBackgroundOverlay(context, viewModel),
            _buildEventDetailsSheet(context, viewModel),
          ],
        ],
      ),
    );
  }

  Widget _buildMapContainer(BuildContext context, MapViewmodel viewModel) {
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
        TileLayer(
          urlTemplate: MapConfig.osmTileServer,
          userAgentPackageName: 'com.example.event_booking',
          maxZoom: 18,
        ),
        MarkerLayer(
          markers: viewModel.markers,
        ),
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
                      color: Colors.blue.withAlpha(76),
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

  Widget _buildSearchBar(BuildContext context, MapViewmodel viewModel) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16.h,
      left: 16.w,
      right: 16.w,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: TextField(
          onTapUpOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            hintText: 'Search events, locations...',
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 13.sp,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade500,
              size: 20.sp,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.filter_list,
                color: Colors.grey.shade500,
                size: 20.sp,
              ),
              onPressed: viewModel.onFilterPressed,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
          ),
          onChanged: viewModel.onSearchChanged,
        ),
      ),
    );
  }

  Widget _buildMapControls(BuildContext context, MapViewmodel viewModel) {
    return Positioned(
      right: 16.w,
      bottom: 120.h,
      child: Column(
        children: [
          _buildControlButton(
            icon: Icons.add,
            onPressed: viewModel.onZoomIn,
          ),
          SizedBox(height: 8.h),
          _buildControlButton(
            icon: Icons.remove,
            onPressed: viewModel.onZoomOut,
          ),
          SizedBox(height: 8.h),
          _buildControlButton(
            icon: Icons.my_location,
            onPressed: viewModel.onCurrentLocationPressed,
          ),
          SizedBox(height: 8.h),
          _buildControlButton(
            icon: viewModel.isListView ? Icons.map : Icons.list,
            onPressed: viewModel.onToggleMapType,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36.r),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: 20.sp,
        ),
        onPressed: onPressed,
      ),
    );
  }

  @override
  MapViewmodel viewModelBuilder(BuildContext context) {
    return MapViewmodel()..initialise();
  }
}

Widget _buildBackgroundOverlay(
  BuildContext context,
  MapViewmodel viewModel,
) {
  return Positioned.fill(
    child: GestureDetector(
      onTap: viewModel.closeEventDetails,
      child: Container(
        color: Colors.black.withAlpha(76),
      ),
    ),
  );
}

Widget _buildEventDetailsSheet(
  BuildContext context,
  MapViewmodel viewModel,
) {
  return AnimatedPositioned(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    bottom: 0,
    left: 0,
    right: 0,
    child: GestureDetector(
      onTap: () {},
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: viewModel.closeEventDetails,
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    viewModel.selectedEvent!.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  IconButton(
                    onPressed: viewModel.closeEventDetails,
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey.shade500,
                      size: 18.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey.shade600,
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      viewModel.selectedEvent!.location,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.grey.shade600,
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    viewModel.selectedEvent!.date,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: viewModel.onDirectionsPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                      ),
                      child: Text(
                        'Directions',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: viewModel.onViewEventPressed,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                      ),
                      child: Text(
                        'View Event',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
