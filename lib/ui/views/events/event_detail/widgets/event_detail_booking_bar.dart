import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/views/events/event_detail/event_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailBookingBar extends StatelessWidget {
  final EventDetailViewModel viewModel;

  const EventDetailBookingBar({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  String _formatPrice(double price) {
    if (price == 0) {
      return 'FREE';
    }
    return '\$${price.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    final event = viewModel.event!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 50,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.text.withAlpha(153),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            _formatPrice(event.price),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                          ),
                          if (event.price > 0) ...[
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppColors.mintGreen.withAlpha(25),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'Per person',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppColors.mintGreen,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 120.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.primaryDark],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: InkWell(
                    onTap:
                        viewModel.isBusy ? null : () => viewModel.bookEvent(),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Book Now',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(
                  Icons.security_rounded,
                  size: 16.sp,
                  color: AppColors.mintGreen,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Secure payment • Instant confirmation',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.text.withAlpha(153),
                      ),
                ),
                const Spacer(),
                Icon(
                  Icons.local_offer_rounded,
                  size: 16.sp,
                  color: AppColors.vibrantRed,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Limited spots',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.vibrantRed,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
