import 'package:event_booking/ui/common/app_colors.dart';
import 'package:event_booking/ui/common/app_icons.dart';
import 'package:event_booking/ui/common/custom_switch.dart';
import 'package:event_booking/ui/common/custom_text_field.dart';
import 'package:event_booking/ui/common/primary_button.dart';
import 'package:event_booking/ui/views/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'package:event_booking/ui/common/app_images.dart';
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
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    controller: viewModel.emailController,
                    hintText: 'yourmail@example.com',
                    keyboardType: TextInputType.emailAddress,
                    prefixIconName: AppIcons.icMessage,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: viewModel.passwordController,
                    obscureText: !viewModel.isPasswordVisible,
                    hintText: 'Your password',
                    prefixIconName: AppIcons.icLock,
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
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.6.w,
                            child: CustomSwitch(
                              value: viewModel.rememberMe,
                              onChanged: viewModel.setRememberMe,
                            ),
                          ),
                          Text('Remember Me',
                              style:
                                  TextTheme.of(context).bodyMedium?.copyWith()),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextTheme.of(context).bodyMedium?.copyWith(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  PrimaryButton(
                    text: 'SIGN IN',
                    onPressed: viewModel.signIn,
                    color: AppColors.kcPrimaryColor,
                    icon: Icons.arrow_forward,
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: Text('OR',
                        style: TextTheme.of(context)
                            .bodyMedium
                            ?.copyWith(color: AppColors.kcLightGrey)),
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
                  _buildSignUpText(context, viewModel),
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
        label: Text(label, style: TextStyle(fontSize: 14.sp)),
      ),
    );
  }

  Widget _buildSignUpText(BuildContext context, LoginViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
        ),
        TextButton(
          onPressed: viewModel.navigateToSignUp,
          child: Text(
            'Sign up',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.kcPrimaryColor),
          ),
        ),
      ],
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
