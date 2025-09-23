import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_booking/ui/views/map/map_viewmodel.dart';

class MapControls extends StatelessWidget {
  final MapViewmodel viewModel;

  const MapControls({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16.w,
      bottom: 120.h,
      child: Column(
        children: [
          // Zoom In
          _MapControlButton(
            icon: Icons.add,
            onPressed: viewModel.onZoomIn,
          ),
          SizedBox(height: 8.h),

          // Zoom Out
          _MapControlButton(
            icon: Icons.remove,
            onPressed: viewModel.onZoomOut,
          ),
          SizedBox(height: 8.h),

          // Current Location
          _MapControlButton(
            icon: Icons.my_location,
            onPressed: viewModel.onCurrentLocationPressed,
          ),
          SizedBox(height: 8.h),

          // Map Type Toggle
          _MapControlButton(
            icon: viewModel.isListView ? Icons.map : Icons.list,
            onPressed: viewModel.onToggleMapType,
          ),
        ],
      ),
    );
  }
}

class _MapControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _MapControlButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.black87,
          size: 24.sp,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
