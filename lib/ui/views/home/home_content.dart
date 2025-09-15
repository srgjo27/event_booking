import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/common/app_icons.dart';
import 'package:event_booking/ui/common/app_images.dart';
import 'package:event_booking/ui/common/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeContent extends StackedView<HomeViewModel> {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Column(
            children: [
              _buildHeader(context, viewModel),
              Expanded(
                child: _buildBody(context, viewModel),
              ),
            ],
          ),
          Positioned(
            top: 140.h,
            left: 0,
            right: 0,
            child: _buildCategoryList(context, viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, HomeViewModel viewModel) {
    return Container(
      height: 160.h,
      decoration: BoxDecoration(
        color: AppColors.kcPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36.r),
          bottomRight: Radius.circular(36.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Current Location',
                            style: TextTheme.of(context)
                                .bodySmall
                                ?.copyWith(color: Colors.white70),
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(AppIcons.icArrowDown)
                        ],
                      ),
                      Text(
                        'Jakarta, Indonesia',
                        style: TextTheme.of(context).titleMedium?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.asset(AppImages.imgNotification),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle:
                            const TextStyle(color: AppColors.kcVeryLightGrey),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: SvgPicture.asset(AppIcons.icSearch),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(36.r),
                    ),
                    child: Row(
                      children: [
                        Image.asset(AppImages.imgFilter),
                        SizedBox(width: 4.w),
                        Text('Filters',
                            style: TextTheme.of(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context, HomeViewModel viewModel) {
    return SizedBox(
      height: 36.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: viewModel.categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            final isSelected = viewModel.selectedCategory == null;

            return GestureDetector(
              onTap: () => viewModel.selectCategory(null),
              child: Container(
                margin: EdgeInsets.only(right: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.kcPrimaryColor
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: Center(
                  child: Text(
                    'All',
                    style: TextTheme.of(context).bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            isSelected ? Colors.white : Colors.grey.shade500),
                  ),
                ),
              ),
            );
          }

          final category = viewModel.categories[index - 1];
          final isSelected = viewModel.selectedCategory == category.name;

          return GestureDetector(
            onTap: () => viewModel.selectCategory(category.name),
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: isSelected ? category.color : category.color,
                borderRadius: BorderRadius.circular(36.r),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    category.icon,
                    colorFilter: ColorFilter.mode(
                      isSelected ? Colors.white : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    category.name,
                    style: TextTheme.of(context).bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 36.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Events',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp),
                ),
                TextButton.icon(
                  onPressed: () {},
                  label: Text(
                    'See All',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey.shade600),
                  ),
                  icon: SvgPicture.asset(AppIcons.icArrowRight),
                  iconAlignment: IconAlignment.end,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 232.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: viewModel.upcomingEvents.length,
              itemBuilder: (context, index) {
                final event = viewModel.upcomingEvents[index];

                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: _buildEventCard(context, event, viewModel),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(
      BuildContext context, Event event, HomeViewModel viewModel) {
    return Container(
      width: 232.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.grey.shade200, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120.h,
            margin: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0),
            decoration: BoxDecoration(
              color: _getCategoryColor(event.category),
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
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          event.day,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.kcSportsColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          event.month,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.kcSportsColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                        event.isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: const Color(0xFFF0635A),
                        size: 20.sp),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
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
                  Row(
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
                                  child: Icon(Icons.person,
                                      size: 14.sp, color: Colors.white),
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
                          color: AppColors.kcPrimaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.grey.shade500, size: 16.sp),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          event.address,
                          style: TextTheme.of(context).bodyMedium?.copyWith(
                              color: Colors.grey.shade500, fontSize: 12.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'sports':
        return AppColors.kcSportsColor.withAlpha(51);
      case 'music':
        return AppColors.kcMusicColor.withAlpha(51);
      case 'food':
        return AppColors.kcFoodColor.withAlpha(51);
      case 'art':
        return AppColors.kcArtColor.withAlpha(51);
      default:
        return AppColors.kcPrimaryColor.withAlpha(51);
    }
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
