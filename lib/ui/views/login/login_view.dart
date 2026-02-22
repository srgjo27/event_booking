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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
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
                      ?.copyWith(fontWeight: FontWeight.w600),
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
                            color: Colors.grey.shade300,
                          )
                        : SvgPicture.asset(
                            AppIcons.icHidden,
                            color: Colors.grey.shade300,
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
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                PrimaryButton(
                  text: 'SIGN IN',
                  onPressed: viewModel.signIn,
                  color: AppColors.primary,
                  icon: Icons.arrow_forward,
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Text('OR',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: 20.h),
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
          foregroundColor: AppColors.text,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        icon: Image.asset(iconPath),
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
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
          onPressed: viewModel.navigateToSignUp,
          child: Text(
            'Sign up',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.primary),
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
