import 'package:event_booking/ui/common/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsContent extends StatelessWidget {
  const EventsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.h,
          color: Colors.white,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Events',
                    style: TextTheme.of(context).titleLarge?.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 18.sp),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.black),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.black),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Content
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.imgIllustrationEmptyEvent,
                          width: 200.w,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No Upcoming Events',
                          style: TextTheme.of(context).titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Stay tuned for upcoming events!',
                          style: TextTheme.of(context).bodyLarge?.copyWith(
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
}
