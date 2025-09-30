import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, viewModel),
          SliverToBoxAdapter(
            child: _buildEventDetails(context, viewModel),
          ),
        ],
      ),
      bottomNavigationBar: _buildEnhancedBookingBar(context, viewModel),
    );
  }

  Widget _buildAppBar(BuildContext context, EventDetailViewModel viewModel) {
    final hasValidImage = event.imageUrl != null && event.imageUrl!.isNotEmpty;

    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      leading: Container(
        margin: EdgeInsets.only(left: 16.w, top: 8.h),
        child: _buildGlassmorphismButton(
          child:
              Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
          onTap: () => viewModel.goBack(),
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16.w, top: 8.h),
          child: _buildGlassmorphismButton(
            child: Icon(
              viewModel.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
              color: Colors.white,
              size: 20.sp,
            ),
            onTap: () => viewModel.toggleBookmark(),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'event_image_${event.id}',
              child: hasValidImage
                  ? Image.asset(
                      event.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildEventPlaceholder();
                      },
                    )
                  : _buildEventPlaceholder(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassmorphismButton({
    required Widget child,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(51),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withAlpha(76),
              width: 1.w,
            ),
          ),
          child: InkWell(
            onTap: onTap,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }

  Widget _buildEventPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            EventUtils.getCategoryColor(event.category),
            EventUtils.getCategoryColor(event.category).withAlpha(150),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getCategoryIcon(event.category),
              size: 64.sp,
              color: Colors.white.withAlpha(128),
            ),
            SizedBox(height: 12.h),
            Text(
              event.category.toUpperCase(),
              style: TextStyle(
                color: Colors.white.withAlpha(179),
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'music':
        return Icons.music_note_rounded;
      case 'sports':
        return Icons.sports_soccer_rounded;
      case 'food':
        return Icons.restaurant_rounded;
      case 'art':
        return Icons.palette_rounded;
      case 'technology':
        return Icons.computer_rounded;
      default:
        return Icons.event_rounded;
    }
  }

  Widget _buildEnhancedBookingBar(
    BuildContext context,
    EventDetailViewModel viewModel,
  ) {
    final event = viewModel.event!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 50,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.text.withAlpha(153),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            _formatPrice(event.price),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                          ),
                          if (event.price > 0) ...[
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppColors.mintGreen.withAlpha(25),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'Per person',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppColors.mintGreen,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 120.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.primaryDark],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: InkWell(
                    onTap:
                        viewModel.isBusy ? null : () => viewModel.bookEvent(),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Book Now',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(
                  Icons.security_rounded,
                  size: 16.sp,
                  color: AppColors.mintGreen,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Secure payment • Instant confirmation',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.text.withAlpha(153),
                      ),
                ),
                const Spacer(),
                Icon(
                  Icons.local_offer_rounded,
                  size: 16.sp,
                  color: AppColors.vibrantRed,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Limited spots',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.vibrantRed,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _formatPrice(double price) {
  if (price == 0) {
    return 'FREE';
  }
  return '\$${price.toStringAsFixed(0)}';
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
        SizedBox(height: 24.h),
        _buildEventInfo(context, event),
        SizedBox(height: 28.h),
        _buildEventDescription(context),
        SizedBox(height: 28.h),
        _buildAttendeesSection(context, viewModel, event),
        SizedBox(height: 50.h),
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
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: EventUtils.getCategoryColor(event.category),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              event.category.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
      SizedBox(height: 12.h),
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
      boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 50)],
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
                    child: Icon(
                      icon,
                      color: color,
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(width: 8.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.text.withAlpha(153),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(height: 4.h),
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
                    child: Icon(icon, color: color, size: 16.sp),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.text.withAlpha(153),
                          fontWeight: FontWeight.w500,
                        ),
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
            .titleLarge
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
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 15),
          ],
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
                SizedBox(width: 12.w),
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
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
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
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.primary.withAlpha(51),
                  width: 1.w,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.primary,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Please arrive 15 minutes early for check-in',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
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
        padding: EdgeInsets.only(bottom: 12.h),
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
              child: Icon(
                feature['icon'] as IconData,
                color: AppColors.primary,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                feature['text'] as String,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.text,
                      height: 1.4,
                    ),
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
                .titleLarge
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
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              '${event.attendeesCount} Going',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildEnhancedAvatarStack(),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.text,
                                  ),
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
                      SizedBox(height: 2.h),
                      Text(
                        'Be part of an amazing community',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.text.withAlpha(153),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
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
        Icon(
          icon,
          color: color,
          size: 20.sp,
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
            child: Center(
              child: Text(
                '+',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
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
