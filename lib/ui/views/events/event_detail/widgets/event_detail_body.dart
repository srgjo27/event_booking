import 'package:event_booking/models/event_models.dart';
import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/views/events/event_detail/event_detail_viewmodel.dart';
import 'package:event_booking/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailBody extends StatelessWidget {
  final EventDetailViewModel viewModel;

  const EventDetailBody({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _buildEventDetails(context, viewModel),
    );
  }
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
        SizedBox(height: 20.h),
        _buildEventInfo(context, event),
        SizedBox(height: 20.h),
        _buildEventDescription(context),
        SizedBox(height: 20.h),
        _buildAttendeesSection(context, viewModel, event),
      ],
    ),
  );
}

Widget _buildEventHeader(
  BuildContext context,
  EventDetailViewModel viewModel,
  Event event,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: EventUtils.getCategoryColor(event.category),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              event.category.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            viewModel.formatPrice(event.price),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(height: 16.h),
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

Widget _buildEventInfo(
  BuildContext context,
  Event event,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: _buildInfoCard(
              context,
              Icons.calendar_today_rounded,
              'Date',
              '${event.day} ${event.month}',
              AppColors.primary,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildInfoCard(
              context,
              Icons.access_time_rounded,
              'Time',
              event.time,
              AppColors.vibrantRed,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildInfoCard(
              context,
              Icons.people_rounded,
              'Attendees',
              '${event.attendeesCount} Going',
              AppColors.skyBlue,
            ),
          ),
        ],
      ),
      SizedBox(height: 16.h),
      Row(
        children: [
          _buildInfoCard(
            context,
            Icons.location_on_rounded,
            'Location',
            event.address,
            AppColors.mintGreen,
            isWide: true,
          ),
        ],
      ),
    ],
  );
}

Widget _buildInfoCard(
  BuildContext context,
  IconData icon,
  String title,
  String value,
  Color color, {
  bool isWide = false,
}) {
  return Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.grey.shade200, width: 1.w),
    ),
    child: Column(
      crossAxisAlignment:
          isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        isWide
            ? Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: color.withAlpha(25),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(icon, color: color),
                  ),
                  SizedBox(width: 6.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.text.withAlpha(153)),
                      ),
                      Text(
                        value,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: color.withAlpha(25),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(icon, color: color),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.text.withAlpha(153)),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: isWide ? TextAlign.start : TextAlign.center,
                    maxLines: isWide ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
      ],
    ),
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
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 16.h),
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              AppColors.background.withAlpha(128),
            ],
          ),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200, width: 1.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  'Event Highlights',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: const [
                  TextSpan(
                    text: 'Join us for an ',
                  ),
                  TextSpan(
                    text: 'unforgettable experience',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text:
                        '! This event promises to deliver amazing entertainment, networking opportunities, and memorable moments.\n',
                  ),
                ],
              ),
            ),
            _buildFeatureList(context),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                    color: AppColors.primary.withAlpha(51), width: 1.w),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded,
                      color: AppColors.primary),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Please arrive 15 minutes early for check-in',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildFeatureList(BuildContext context) {
  final features = [
    {'icon': Icons.star_rounded, 'text': 'Premium entertainment & activities'},
    {
      'icon': Icons.people_rounded,
      'text': 'Networking with like-minded people'
    },
    {'icon': Icons.restaurant_rounded, 'text': 'Complimentary refreshments'},
    {'icon': Icons.camera_alt_rounded, 'text': 'Professional photography'},
  ];

  return Column(
    children: features.map((feature) {
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child:
                  Icon(feature['icon'] as IconData, color: AppColors.primary),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                feature['text'] as String,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildAttendeesSection(
  BuildContext context,
  EventDetailViewModel viewModel,
  Event event,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Who\'s Going',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primaryDark,
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '${event.attendeesCount} Going',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      SizedBox(height: 16.h),
      Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              AppColors.background.withAlpha(128),
            ],
          ),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200, width: 1.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildEnhancedAvatarStack(),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: '${event.attendeesCount - 3}+ others',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const TextSpan(
                                text: ' are excited to join this event!'),
                          ],
                        ),
                      ),
                      Text(
                        'Be part of an amazing community',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.text.withAlpha(153)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildSocialProofStats(context, event),
          ],
        ),
      ),
    ],
  );
}

Widget _buildSocialProofStats(
  BuildContext context,
  Event event,
) {
  return Row(
    children: [
      Expanded(
        child: _buildStatCard(
          context,
          Icons.trending_up_rounded,
          'Popularity',
          '${((event.attendeesCount / 500) * 100).toInt()}%',
          AppColors.mintGreen,
        ),
      ),
      SizedBox(width: 12.w),
      Expanded(
        child: _buildStatCard(
          context,
          Icons.star_rounded,
          'Rating',
          '4.8',
          AppColors.skyBlue,
        ),
      ),
      SizedBox(width: 12.w),
      Expanded(
        child: _buildStatCard(
          context,
          Icons.people_rounded,
          'Community',
          '${event.attendeesCount}',
          AppColors.vibrantRed,
        ),
      ),
    ],
  );
}

Widget _buildStatCard(
  BuildContext context,
  IconData icon,
  String label,
  String value,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: color.withAlpha(51),
        width: 1.w,
      ),
    ),
    child: Column(
      children: [
        Icon(icon, color: color),
        SizedBox(height: 4.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.text.withAlpha(153),
              ),
        ),
      ],
    ),
  );
}

Widget _buildEnhancedAvatarStack() {
  return SizedBox(
    width: 100.w,
    height: 40.w,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          child: _buildEnhancedAvatar(AppColors.vibrantRed, 'A'),
        ),
        Positioned(
          left: 20.w,
          child: _buildEnhancedAvatar(AppColors.mintGreen, 'M'),
        ),
        Positioned(
          left: 40.w,
          child: _buildEnhancedAvatar(AppColors.skyBlue, 'S'),
        ),
        Positioned(
          left: 60.w,
          child: Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primaryDark,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '+',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildEnhancedAvatar(Color color, String initial) {
  return Container(
    width: 36.w,
    height: 36.w,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 1.w),
    ),
    child: Center(
      child: Text(
        initial,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
