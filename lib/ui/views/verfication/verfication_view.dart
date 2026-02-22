import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';

import 'verfication_viewmodel.dart';

class VerficationView extends StackedView<VerficationViewModel> {
  const VerficationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    VerficationViewModel viewModel,
    Widget? child,
  ) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 50.h,
      textStyle: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verification',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            Text('We\'ve send you the verification\ncode on +1 2620 0323 7631',
                style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 32.h),
            Center(
              child: Pinput(
                length: 4,
                controller: viewModel.pinController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => SizedBox(width: 16.w),
                showCursor: true,
                keyboardType: TextInputType.number,
                onCompleted: (pin) => viewModel.verifyCode(),
              ),
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              text: 'CONTINUE',
              onPressed: viewModel.verifyCode,
              icon: Icons.arrow_forward,
              color: AppColors.primary,
            ),
            SizedBox(height: 20.h),
            Center(
              child: viewModel.canResend
                  ? TextButton(
                      onPressed: viewModel.resendCode,
                      child: Text(
                        'Re-send code',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          const TextSpan(text: 'Re-send code in '),
                          TextSpan(
                            text:
                                '0:${viewModel.timerDisplay.toString().padLeft(2, '0')}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  VerficationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      VerficationViewModel();

  @override
  void onViewModelReady(VerficationViewModel viewModel) {
    viewModel.initialise();
    super.onViewModelReady(viewModel);
  }
}
