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
      width: 60.w,
      height: 60.h,
      textStyle: TextTheme.of(context)
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Verification',
                style: TextTheme.of(context)
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text(
                'We\'ve send you the verification\ncode on +1 2620 0323 7631',
                style: TextTheme.of(context).bodyLarge?.copyWith(height: 1.2.h),
              ),
              SizedBox(height: 32.h),
              Center(
                child: Pinput(
                  length: 4,
                  controller: viewModel.pinController,
                  focusNode: viewModel.focusNode,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => SizedBox(width: 16.w),
                  showCursor: true,
                  keyboardType: TextInputType.number,
                  onCompleted: (pin) => viewModel.verifyCode(),
                ),
              ),
              SizedBox(height: 30.h),
              PrimaryButton(
                text: 'CONTINUE',
                onPressed: viewModel.verifyCode,
                icon: Icons.arrow_forward,
                color: AppColors.kcPrimaryColor,
              ),
              SizedBox(height: 30.h),
              Center(
                child: viewModel.canResend
                    ? TextButton(
                        onPressed: viewModel.resendCode,
                        child: Text(
                          'Re-send code',
                          style: TextTheme.of(context).bodyLarge,
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          style: TextTheme.of(context).bodyLarge,
                          children: [
                            const TextSpan(text: 'Re-send code in '),
                            TextSpan(
                              text:
                                  '0:${viewModel.timerDisplay.toString().padLeft(2, '0')}',
                              style: TextTheme.of(context).bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kcPrimaryColor),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
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
