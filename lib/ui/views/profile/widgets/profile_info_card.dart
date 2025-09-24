import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/views/profile/profile_viewmodel.dart';

class ProfileInfoCard extends StatelessWidget {
  final ProfileViewmodel viewModel;

  const ProfileInfoCard({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -50.h),
      child: Column(
        children: [
          _buildProfilePicture(),
          SizedBox(height: 12.h),
          _buildUserInfo(),
          SizedBox(height: 12.h),
          _buildEditButton(),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 50.r,
        backgroundColor: AppColors.primary.withAlpha(25),
        child: Icon(
          Icons.person,
          size: 50.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        Text(
          viewModel.userName,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          viewModel.userEmail,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.text.withAlpha(153),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          viewModel.userPhone,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.text.withAlpha(153),
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton() {
    return ElevatedButton(
      onPressed: viewModel.onEditProfilePressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 10.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
        elevation: 1,
      ),
      child: Text(
        'Edit Profile',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
