import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:event_booking/ui/common/app_icons.dart';
import 'home_event_card_widget.dart';
import '../home_viewmodel.dart';

class HomeBodyWidget extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeBodyWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32.h),
          _buildSectionHeader(context),
          SizedBox(height: 16.h),
          _buildEventsHorizontalList(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Padding(
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
          _buildSeeAllButton(context),
        ],
      ),
    );
  }

  Widget _buildSeeAllButton(BuildContext context) {
    return TextButton.icon(
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
    );
  }

  Widget _buildEventsHorizontalList() {
    return SizedBox(
      height: 232.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: viewModel.upcomingEvents.length,
        itemBuilder: (context, index) {
          final event = viewModel.upcomingEvents[index];

          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: HomeEventCardWidget(
              event: event,
              viewModel: viewModel,
              onTap: () => viewModel.navigateToEventDetail(event),
            ),
          );
        },
      ),
    );
  }
}
