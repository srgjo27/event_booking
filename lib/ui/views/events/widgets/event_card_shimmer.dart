import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shimmer loading widget for event cards
class EventCardShimmer extends StatefulWidget {
  const EventCardShimmer({Key? key}) : super(key: key);

  @override
  State<EventCardShimmer> createState() => _EventCardShimmerState();
}

class _EventCardShimmerState extends State<EventCardShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerBox(80.w, 80.w),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildShimmerBox(60.w, 20.h),
                      const Spacer(),
                      _buildShimmerBox(40.w, 20.h),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  _buildShimmerBox(double.infinity, 20.h),
                  SizedBox(height: 4.h),
                  _buildShimmerBox(double.infinity, 16.h),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      _buildShimmerBox(16.w, 16.h),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: _buildShimmerBox(80.w, 16.h),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      _buildShimmerBox(16.w, 16.h),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: _buildShimmerBox(60.w, 16.h),
                      ),
                      SizedBox(width: 8.w),
                      _buildShimmerBox(16.w, 16.h),
                      SizedBox(width: 4.w),
                      _buildShimmerBox(40.w, 16.h),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            _buildShimmerBox(36.w, 36.w),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerBox(double width, double height) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey.shade200,
                Colors.grey.shade100,
                Colors.grey.shade200,
              ],
              stops: const [
                0.0,
                0.5,
                1.0,
              ],
              transform: GradientRotation(_animation.value),
            ),
          ),
        );
      },
    );
  }
}
