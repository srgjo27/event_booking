import 'package:event_booking/app/app_colors.dart';
import 'package:event_booking/app/app_icons.dart';
import 'package:event_booking/ui/views/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'package:event_booking/app/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      AppImages.imgEventHubVertical,
                      width: 132.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    'Sign in',
                    style: TextTheme.of(context)
                        .titleMedium
                        ?.copyWith(fontSize: 24.sp),
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: viewModel.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'abc@email.com',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: SvgPicture.asset(
                          AppIcons.icMessage,
                          colorFilter: ColorFilter.mode(
                              Colors.grey.shade400, BlendMode.srcIn),
                          width: 24.w,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: viewModel.passwordController,
                    obscureText: !viewModel.isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Your password',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: SvgPicture.asset(
                          AppIcons.icLock,
                          colorFilter: ColorFilter.mode(
                              Colors.grey.shade400, BlendMode.srcIn),
                          width: 24.w,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: viewModel.isPasswordVisible
                            ? Icon(
                                Icons.visibility_outlined,
                                color: Colors.grey.shade400,
                              )
                            : SvgPicture.asset(
                                AppIcons.icHidden,
                                colorFilter: ColorFilter.mode(
                                    Colors.grey.shade400, BlendMode.srcIn),
                                width: 24.w,
                              ),
                        onPressed: viewModel.togglePasswordVisibility,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.7.w,
                            child: Switch(
                              value: viewModel.rememberMe,
                              onChanged: viewModel.setRememberMe,
                              activeColor: Colors.white,
                              activeTrackColor: AppColors.primary,
                              inactiveThumbColor: Colors.grey.shade400,
                              inactiveTrackColor: Colors.white,
                              trackOutlineColor:
                                  WidgetStateProperty.all(Colors.grey.shade300),
                              trackOutlineWidth:
                                  WidgetStateProperty.resolveWith<double>(
                                (states) => 1.w,
                              ),
                            ),
                          ),
                          Text('Remember Me',
                              style: TextTheme.of(context)
                                  .bodyMedium
                                  ?.copyWith(fontSize: 14.sp)),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextTheme.of(context)
                              .bodyMedium
                              ?.copyWith(fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: AppColors.primary,
                      ),
                      child: ElevatedButton(
                        onPressed: viewModel.signIn,
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
                                'SIGN IN',
                                style: TextTheme.of(context)
                                    .bodyMedium
                                    ?.copyWith(
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
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: Text('OR',
                        style: TextTheme.of(context).bodyMedium?.copyWith(
                            color: AppColors.textSecondary, fontSize: 14.sp)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: TextTheme.of(context)
                              .bodyMedium
                              ?.copyWith(fontSize: 14.sp)),
                      TextButton(
                        onPressed: viewModel.navigateToSignUp,
                        child: Text(
                          'Sign up',
                          style: TextTheme.of(context).bodyMedium?.copyWith(
                              fontSize: 14.sp, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
