import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:event_booking/ui/common/app_colors.dart';
import '../home_viewmodel.dart';

/// Category list widget for filtering events by category
class HomeCategoryListWidget extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeCategoryListWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: viewModel.categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAllCategoryChip(context);
          }

          final category = viewModel.categories[index - 1];
          return _buildCategoryChip(context, category);
        },
      ),
    );
  }

  Widget _buildAllCategoryChip(BuildContext context) {
    final isSelected = viewModel.selectedCategory == null;

    return GestureDetector(
      onTap: () => viewModel.selectCategory(null),
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                color: isSelected ? Colors.white : Colors.grey.shade500),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, category) {
    final isSelected = viewModel.selectedCategory == category.name;

    return GestureDetector(
      onTap: () => viewModel.selectCategory(category.name),
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
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
  }
}
