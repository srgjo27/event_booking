import 'package:event_booking/app/app_colors.dart';
import 'package:event_booking/app/app_icons.dart';
import 'package:event_booking/app/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'register_viewmodel.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign up',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 24.sp),
                ),
                SizedBox(height: 20.h),
                _buildFullNameField(viewModel),
                SizedBox(height: 16.h),
                _buildEmailField(viewModel),
                SizedBox(height: 16.h),
                _buildPasswordField(
                  context: context,
                  controller: viewModel.passwordController,
                  hintText: 'Your password',
                  isPasswordVisible: viewModel.isPasswordVisible,
                  toggleVisibility: viewModel.togglePasswordVisibility,
                ),
                SizedBox(height: 16.h),
                _buildPasswordField(
                  context: context,
                  controller: viewModel.confirmPasswordController,
                  hintText: 'Confirm password',
                  isPasswordVisible: viewModel.isPasswordVisible,
                  toggleVisibility: viewModel.togglePasswordVisibility,
                ),
                SizedBox(height: 20.h),
                _buildSignUpButton(context, viewModel),
                SizedBox(height: 24.h),
                Center(
                  child: Text(
                    'OR',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary, fontSize: 14.sp),
                  ),
                ),
                SizedBox(height: 16.h),
                _buildSocialLoginButton(
                  onPressed: viewModel.loginWithGoogle,
                  iconPath: AppImages.imgGoogleLogo,
                  label: 'Login with Google',
                ),
                SizedBox(height: 12.h),
                _buildSocialLoginButton(
                  onPressed: viewModel.loginWithFacebook,
                  iconPath: AppImages.imgFacebookLogo,
                  label: 'Login with Facebook',
                ),
                SizedBox(height: 16.h),
                _buildSignInText(context, viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullNameField(RegisterViewModel viewModel) {
    return TextField(
      controller: viewModel.fullNameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Full name',
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.w),
          child: SvgPicture.asset(
            AppIcons.icUser,
            colorFilter:
                ColorFilter.mode(Colors.grey.shade400, BlendMode.srcIn),
            width: 20.w,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
        ),
      ),
    );
  }

  Widget _buildEmailField(RegisterViewModel viewModel) {
    return TextField(
      controller: viewModel.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'abc@email.com',
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.w),
          child: SvgPicture.asset(
            AppIcons.icMessage,
            colorFilter:
                ColorFilter.mode(Colors.grey.shade400, BlendMode.srcIn),
            width: 24.w,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required bool isPasswordVisible,
    required VoidCallback toggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.w),
          child: SvgPicture.asset(
            AppIcons.icLock,
            colorFilter:
                ColorFilter.mode(Colors.grey.shade400, BlendMode.srcIn),
            width: 24.w,
          ),
        ),
        suffixIcon: IconButton(
          icon: isPasswordVisible
              ? Icon(Icons.visibility_outlined, color: Colors.grey.shade400)
              : SvgPicture.asset(
                  AppIcons.icHidden,
                  colorFilter:
                      ColorFilter.mode(Colors.grey.shade400, BlendMode.srcIn),
                  width: 24.w,
                ),
          onPressed: toggleVisibility,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
        ),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context, RegisterViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.primary,
        ),
        child: ElevatedButton(
          onPressed: viewModel.signUp,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36.r),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Text(
                  'SIGN UP',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                right: 20.w,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_forward,
                      color: Colors.white, size: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required VoidCallback onPressed,
    required String iconPath,
    required String label,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        icon: Image.asset(iconPath, width: 24.w),
        label: Text(label, style: TextStyle(fontSize: 15.sp)),
      ),
    );
  }

  Widget _buildSignInText(BuildContext context, RegisterViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style:
              Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
        ),
        TextButton(
          onPressed: viewModel.navigateToSignIn,
          child: Text(
            'Sign in',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14.sp, color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  @override
  RegisterViewModel viewModelBuilder(BuildContext context) =>
      RegisterViewModel();
}
