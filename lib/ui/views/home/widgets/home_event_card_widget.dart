import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_booking/models/models.dart';
import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/utils/utils.dart';
import '../home_viewmodel.dart';

/// Event card widget for displaying individual event information
class HomeEventCardWidget extends StatelessWidget {
  final Event event;
  final HomeViewModel viewModel;

  const HomeEventCardWidget({
    Key? key,
    required this.event,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 232.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.grey.shade200, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventImage(context),
          Expanded(
            child: _buildEventDetails(context),
          )
        ],
      ),
    );
  }

  Widget _buildEventImage(BuildContext context) {
    return Container(
      height: 120.h,
      margin: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0),
      decoration: BoxDecoration(
        color: CategoryUtils.getCategoryColor(event.category),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.image,
              size: 60.w,
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 8.h,
            left: 8.w,
            child: _buildDateContainer(context),
          ),
          Positioned(
            top: 8.h,
            right: 8.w,
            child: _buildBookmarkButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            event.day,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.vibrantRed,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            event.month,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.vibrantRed,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkButton() {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(event.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          color: const Color(0xFFF0635A), size: 20.sp),
    );
  }

  Widget _buildEventDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            event.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          _buildAttendeesRow(),
          _buildLocationRow(context),
        ],
      ),
    );
  }

  Widget _buildAttendeesRow() {
    return Row(
      children: [
        SizedBox(
          width: 55.w,
          height: 26.h,
          child: Stack(
            children: List.generate(3, (index) {
              return Positioned(
                left: (index * 15).w,
                child: CircleAvatar(
                  radius: 13.r,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 11.r,
                    backgroundColor: Colors.primaries[index * 3],
                    child: Icon(Icons.person, size: 14.sp, color: Colors.white),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          viewModel.formatAttendeesCount(event.attendeesCount),
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationRow(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, color: Colors.grey.shade400, size: 16.sp),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            event.address,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey.shade500, fontSize: 12.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
