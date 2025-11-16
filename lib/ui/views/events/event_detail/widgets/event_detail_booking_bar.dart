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
        minimum: EdgeInsets.only(bottom: 8.h),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
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
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
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
                    constraints: BoxConstraints(
                      minWidth: 110.w,
                      maxWidth: 132.w,
                    ),
                    height: 36.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.r),
                        onTap: viewModel.isBusy
                            ? null
                            : () => viewModel.bookEvent(),
                        child: Center(
                          child: viewModel.isBusy
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    strokeWidth: 2,
                                  ),
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Book Now',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(width: 6.w),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.security_rounded,
                            size: 14.sp,
                            color: AppColors.mintGreen,
                          ),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: Text(
                              'Secure payment',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.text.withAlpha(153),
                                    fontSize: 11.sp,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.local_offer_rounded,
                            size: 14.sp,
                            color: AppColors.vibrantRed,
                          ),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: Text(
                              'Limited spots',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.vibrantRed,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
