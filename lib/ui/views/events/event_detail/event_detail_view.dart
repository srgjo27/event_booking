import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:event_booking/models/event_models.dart';
import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/utils/utils.dart';

import 'event_detail_viewmodel.dart';

class EventDetailView extends StackedView<EventDetailViewModel> {
  final Event event;

  const EventDetailView({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  EventDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EventDetailViewModel(initialEvent: event);

  @override
  Widget builder(
    BuildContext context,
    EventDetailViewModel viewModel,
    Widget? child,
  ) {
    if (viewModel.event == null) {
      return const Scaffold(
        body: Center(
          child: Text('Event not found'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, viewModel),
          SliverToBoxAdapter(
            child: _buildEventDetails(context, viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, EventDetailViewModel viewModel) {
    final hasValidImage = event.imageUrl != null && event.imageUrl!.isNotEmpty;

    return SliverAppBar(
      expandedHeight: 220.h,
      pinned: true,
      leading: Container(
        margin: EdgeInsets.only(left: 16.w),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 24.sp,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16.w),
          child: IconButton(
            icon: Icon(
              viewModel.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: AppColors.primaryDark,
              size: 24.sp,
            ),
            onPressed: viewModel.toggleBookmark,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            hasValidImage
                ? Image.asset(
                    event.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(
                          'Image not available',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    },
                  )
                : Container(
                    color: CategoryUtils.getCategoryColor(event.category),
                    child: Icon(
                      Icons.image_not_supported,
                      size: 42.sp,
                      color: AppColors.dustyBlue,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventDetails(
      BuildContext context, EventDetailViewModel viewModel) {
    final event = viewModel.event!;

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventHeader(context, viewModel, event),
          SizedBox(height: 16.h),
          _buildEventInfo(context, event),
          SizedBox(height: 16.h),
          _buildEventDescription(context),
          SizedBox(height: 16.h),
          _buildAttendeesSection(context, viewModel, event),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildEventHeader(
      BuildContext context, EventDetailViewModel viewModel, Event event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: CategoryUtils.getCategoryColor(event.category),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                event.category.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.text,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
              ),
            ),
            const Spacer(),
            Text(
              viewModel.formatPrice(event.price),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          event.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildEventInfo(BuildContext context, Event event) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            context,
            Icons.calendar_today_outlined,
            'Date',
            '${event.day} ${event.month}',
          ),
          SizedBox(height: 16.h),
          _buildInfoRow(
            context,
            Icons.access_time_outlined,
            'Time',
            event.time,
          ),
          SizedBox(height: 16.h),
          _buildInfoRow(
            context,
            Icons.location_on_outlined,
            'Location',
            event.address,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            size: 16.sp,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.text.withAlpha(153),
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.text,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Event',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildAttendeesSection(
      BuildContext context, EventDetailViewModel viewModel, Event event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Attendees',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              viewModel.formatAttendeesCount(event.attendeesCount),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              _buildAvatarStack(),
              Text(
                'And ${event.attendeesCount - 3}+ others are going',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarStack() {
    return SizedBox(
      width: 70.w,
      height: 32.h,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: _buildAvatar(AppColors.vibrantRed),
          ),
          Positioned(
            left: 16.w,
            child: _buildAvatar(AppColors.mintGreen),
          ),
          Positioned(
            left: 32.w,
            child: _buildAvatar(AppColors.skyBlue),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(Color color) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.w),
      ),
      child: Icon(
        Icons.person,
        size: 16.sp,
        color: Colors.white,
      ),
    );
  }
}
