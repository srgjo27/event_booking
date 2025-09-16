import 'package:event_booking/ui/common/app_images.dart';
import 'package:event_booking/ui/views/events/events_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class EventsContent extends StackedView<EventsViewModel> {
  const EventsContent({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, EventsViewModel viewModel, Widget? child) {
    return Column(
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
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      onPressed: viewModel.onSearchPressed,
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.black),
                      onPressed: viewModel.onMorePressed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
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
                                width: 140.w,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'No Upcoming Events',
                                style:
                                    TextTheme.of(context).titleLarge?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Stay tuned for upcoming events!',
                                style:
                                    TextTheme.of(context).bodyLarge?.copyWith(
                                          color: Colors.grey.shade500,
                                        ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  EventsViewModel viewModelBuilder(BuildContext context) {
    return EventsViewModel()..initialise();
  }
}
