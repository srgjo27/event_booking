import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_booking/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'base_sheet_model.dart';

class BaseSheet extends StackedView<BaseSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const BaseSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BaseSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      width: double.infinity,
      decoration: _buildContainerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandleBar(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: 16.h),
                _buildDescription(context),
                SizedBox(height: 20.h),
                _buildActionButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    );
  }

  Widget _buildHandleBar() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 12.h),
        width: 40.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            request.title ?? '',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        _buildCloseButton(),
      ],
    );
  }

  Widget _buildCloseButton() {
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => completer?.call(SheetResponse(confirmed: false)),
          child: Icon(Icons.close, size: 24.w),
        );
      },
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      request.description ?? '',
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        if (request.secondaryButtonTitle != null) ...[
          Expanded(
            child: _buildSecondaryButton(context),
          ),
          SizedBox(width: 12.w),
        ],
        Expanded(
          child: _buildPrimaryButton(context),
        ),
      ],
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return _buildButton(
      context: context,
      text: request.secondaryButtonTitle!,
      onPressed: () => completer?.call(SheetResponse(confirmed: false)),
      isSecondary: true,
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return _buildButton(
      context: context,
      text: request.mainButtonTitle ?? 'Apply',
      onPressed: () => completer?.call(SheetResponse(confirmed: true)),
      isSecondary: false,
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
    required bool isSecondary,
  }) {
    return SizedBox(
      height: 36.h,
      child: isSecondary
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
    );
  }

  @override
  BaseSheetModel viewModelBuilder(BuildContext context) => BaseSheetModel();
}
