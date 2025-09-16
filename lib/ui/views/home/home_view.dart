import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/common/app_icons.dart';
import 'package:event_booking/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
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
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.notifications,
                          color: Colors.white, size: 24.w),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.w),
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
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(36.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.filter_list,
                              color: Colors.white, size: 18.w),
                          SizedBox(width: 4.w),
                          Text('Filters',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.white)),
                        ],
                      ),
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
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.grey.shade300,
                  border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 1.w),
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: Center(
                  child: Text(
                    'All',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : category.color,
                border: Border.all(
                    color: isSelected ? Colors.white : Colors.transparent,
                    width: 1.w),
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
          SizedBox(height: 32.h),
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
                        ?.copyWith(color: Colors.grey.shade500),
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
          SizedBox(height: 16.h),
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
                                    color: AppColors.vibrantRed,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          event.month,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.vibrantRed,
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
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.grey.shade400, size: 16.sp),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          event.address,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
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
        return AppColors.vibrantRed.withAlpha(51);
      case 'music':
        return AppColors.softOrange.withAlpha(51);
      case 'food':
        return AppColors.mintGreen.withAlpha(51);
      case 'art':
        return AppColors.skyBlue.withAlpha(51);
      default:
        return AppColors.primary.withAlpha(51);
    }
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
