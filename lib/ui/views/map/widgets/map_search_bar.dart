import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_booking/ui/views/map/map_viewmodel.dart';

class MapSearchBar extends StatelessWidget {
  final MapViewmodel viewModel;

  const MapSearchBar({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16.h,
      left: 16.w,
      right: 16.w,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
}
