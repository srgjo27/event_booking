import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/views/profile/profile_viewmodel.dart';

class ProfileStatsCard extends StatelessWidget {
  final ProfileViewmodel viewModel;

  const ProfileStatsCard({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -30.h),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildStatItem(
              'Events\nJoined',
              viewModel.eventsJoined.toString(),
            ),
            _buildDivider(),
            _buildStatItem(
              'Events\nHosted',
              viewModel.eventsHosted.toString(),
            ),
            _buildDivider(),
            _buildStatItem(
              'Followers',
              viewModel.followers.toString(),
            ),
            _buildDivider(),
            _buildStatItem(
              'Following',
              viewModel.following.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.text.withAlpha(153),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30.h,
      width: 1.w,
      color: AppColors.text.withAlpha(25),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
    );
  }
}
