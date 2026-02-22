import 'dart:ui';

import 'package:event_booking/models/event_models.dart';
import 'package:event_booking/ui/views/events/event_detail/event_detail_viewmodel.dart';
import 'package:event_booking/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailAppBar extends StatelessWidget {
  final EventDetailViewModel viewModel;
  final Event event;

  const EventDetailAppBar({
    Key? key,
    required this.viewModel,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16.sp),
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
              size: 16.sp,
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
                  ? Image.asset(event.imageUrl!, fit: BoxFit.fill)
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
      borderRadius: BorderRadius.circular(8.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(51),
            borderRadius: BorderRadius.circular(8.r),
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
}
