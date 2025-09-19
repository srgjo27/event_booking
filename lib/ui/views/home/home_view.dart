import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';
import 'widgets/widgets.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Column(
            children: [
              HomeHeaderWidget(viewModel: viewModel),
              Expanded(
                child: HomeBodyWidget(viewModel: viewModel),
              ),
            ],
          ),
          Positioned(
            top: 140.h,
            left: 0,
            right: 0,
            child: HomeCategoryListWidget(viewModel: viewModel),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
