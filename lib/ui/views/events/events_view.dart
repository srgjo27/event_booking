import 'package:event_booking/ui/common/app_images.dart';
import 'package:event_booking/ui/views/events/events_viewmodel.dart';
import 'package:event_booking/ui/views/events/widgets/event_card_widget.dart';
import 'package:event_booking/models/event_models.dart';
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
    List<Event> events = [];
    String emptyTitle = '';
    String emptySubtitle = '';

    switch (status) {
      case 'now':
        events = viewModel.nowEvents;
        emptyTitle = 'No Events Today';
        emptySubtitle = 'Check back later for today\'s events!';
        break;
      case 'upcoming':
        events = viewModel.upcomingEvents;
        emptyTitle = 'No Upcoming Events';
        emptySubtitle = 'Stay tuned for exciting upcoming events!';
        break;
      case 'past':
        events = viewModel.pastEvents;
        emptyTitle = 'No Past Events';
        emptySubtitle = 'You haven\'t attended any events yet.';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!viewModel.isBusy && events.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 10.h, top: 8.h),
              child: Text(
                '${events.length} ${events.length == 1 ? 'Event' : 'Events'} Found',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
              ),
            ),
          Expanded(
            child: viewModel.isBusy
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : events.isEmpty
                    ? _buildEmptyState(
                        context,
                        emptyTitle,
                        emptySubtitle,
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return EventCardWidget(
                            event: event,
                            onTap: () => viewModel.navigateToEventDetail(event),
                            onBookmarkTap: () =>
                                viewModel.toggleEventBookmark(event),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.imgIllustrationEmptyEvent,
            width: 120.w,
            height: 120.w,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(60.r),
                ),
                child: Icon(
                  Icons.event_note_outlined,
                  size: 48.sp,
                  color: Colors.grey.shade400,
                ),
              );
            },
          ),
          SizedBox(height: 24.h),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade500,
                    height: 1.4,
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
