import 'package:event_booking/ui/views/profile/profile_viewmodel.dart';
import 'package:event_booking/ui/views/profile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StackedView<ProfileViewmodel> {
  const ProfileView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ProfileViewmodel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(viewModel: viewModel),
            ProfileInfoCard(viewModel: viewModel),
            ProfileStatsCard(viewModel: viewModel),
            ProfileMenuCard(viewModel: viewModel),
          ],
        ),
      ),
    );
  }

  @override
  ProfileViewmodel viewModelBuilder(BuildContext context) => ProfileViewmodel();
}
