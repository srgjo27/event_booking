import 'package:event_booking/ui/common/app_images.dart';
import 'package:event_booking/ui/views/events/events_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class EventsView extends StackedView<EventsViewModel> {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, EventsViewModel viewModel, Widget? child) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Events',
                    style: TextTheme.of(context)
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.black),
                    onPressed: viewModel.onMorePressed,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Theme.of(context).primaryColor,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: Theme.of(context).textTheme.titleSmall,
              unselectedLabelStyle: Theme.of(context).textTheme.titleSmall,
              splashFactory: NoSplash.splashFactory,
              tabs: const [
                Tab(
                  child: Text('NOW'),
                ),
                Tab(
                  child: Text('UPCOMING'),
                ),
                Tab(
                  child: Text('PAST'),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.1, 0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    )),
                    child: child,
                  ),
                );
              },
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildEventsList(context, viewModel, status: 'now'),
                  _buildEventsList(context, viewModel, status: 'upcoming'),
                  _buildEventsList(context, viewModel, status: 'past'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList(BuildContext context, EventsViewModel viewModel,
      {required String status}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: viewModel.isBusy
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.imgIllustrationEmptyEvent,
                          width: 120.w,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          status == 'now'
                              ? 'No Now Events'
                              : status == 'upcoming'
                                  ? 'No Upcoming Events'
                                  : 'No Past Events',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          status == 'now'
                              ? 'Stay tuned for upcoming events!'
                              : status == 'upcoming'
                                  ? 'You have no upcoming events.'
                                  : 'You haven\'t attended any events yet.',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade500,
                                  ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  EventsViewModel viewModelBuilder(BuildContext context) {
    return EventsViewModel()..initialise();
  }
}
