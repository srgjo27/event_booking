import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/common/app_icons.dart';
import '../home_viewmodel.dart';

class HomeHeaderWidget extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeHeaderWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              _buildTopSection(context),
              SizedBox(height: 12.h),
              _buildSearchSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(),
        ),
        Expanded(
          flex: 5,
          child: _buildLocationSection(context),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(Icons.notifications, color: Colors.white, size: 24.w),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Location',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white70),
            ),
            SizedBox(width: 4.w),
            SvgPicture.asset(AppIcons.icArrowDown)
          ],
        ),
        Text(
          'Jakarta, Indonesia',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildSearchSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(color: Colors.white),
              prefixIcon: Padding(
                padding: EdgeInsets.all(8.w),
                child: SvgPicture.asset(AppIcons.icSearch),
              ),
              filled: true,
              fillColor: Colors.white.withAlpha(100),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:
                    BorderSide(color: Colors.white.withAlpha(150), width: 1.w),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.filter_list, size: 20.w),
          label: Text(
            'Filters',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 8.w),
            elevation: 0,
          ),
        )
      ],
    );
  }
}
