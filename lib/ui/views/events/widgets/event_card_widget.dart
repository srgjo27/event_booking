import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_booking/models/event_models.dart';
import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/utils/event_utils.dart';
import 'package:flutter_svg/svg.dart';

/// Event card widget for displaying events in list format
class EventCardWidget extends StatelessWidget {
  final Event event;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;

  const EventCardWidget({
    Key? key,
    required this.event,
    this.onTap,
    this.onBookmarkTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEventImage(),
              SizedBox(width: 10.w),
              Expanded(
                child: _buildEventInfo(context),
              ),
              SizedBox(width: 6.w),
              _buildBookmarkButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventImage() {
    return Container(
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        color: EventUtils.getCategoryColor(event.category),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.asset(
          event.imageUrl ?? '',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: EventUtils.getCategoryColor(event.category),
              child: SvgPicture.asset(
                EventUtils.getCategoryIcon(event.category),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEventInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: EventUtils.getCategoryColor(event.category),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                event.category.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const Spacer(),
            Text(
              _formatPrice(event.price),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          event.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 14.sp,
              color: AppColors.text.withAlpha(153),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                event.address,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.text.withAlpha(153),
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
              Icons.access_time_outlined,
              size: 14.sp,
              color: AppColors.text.withAlpha(153),
            ),
            SizedBox(width: 4.w),
            Text(
              '${event.day} ${event.month}, ${event.time}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.text.withAlpha(153),
                  ),
            ),
            SizedBox(width: 12.w),
            Icon(
              Icons.people_outline,
              size: 14.sp,
              color: AppColors.text.withAlpha(153),
            ),
            SizedBox(width: 4.w),
            Text(
              _formatAttendeesCount(event.attendeesCount),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.text.withAlpha(153),
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBookmarkButton() {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        color: event.isBookmarked
            ? AppColors.vibrantRed.withAlpha(25)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onBookmarkTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Icon(
            event.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            size: 16.sp,
            color: event.isBookmarked
                ? AppColors.vibrantRed
                : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    if (price == 0) {
      return 'Free';
    }
    return '\$${price.toStringAsFixed(0)}';
  }

  String _formatAttendeesCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(0)}K+ Going';
    }
    return '$count Going';
  }
}
