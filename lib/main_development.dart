import 'package:event_booking/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:event_booking/app/app.router.dart';
import 'package:event_booking/config/app_config.dart';
import 'package:event_booking/services/app_initializer.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.initialize(
    environment: AppEnvironment.development,
  );
  await AppInitializer.handleInitialMessage();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: AppConfig.instance.appName,
          debugShowCheckedModeBanner: AppConfig.instance.isDebugMode,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: AppColors.background,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
              secondary: AppColors.accent,
              surface: AppColors.background,
              brightness: Brightness.light,
            ),
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: AppColors.text,
                  displayColor: AppColors.text,
                ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.text,
              elevation: 0,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          initialRoute: Routes.startupView,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [StackedService.routeObserver],
          builder: (context, widget) {
            ScreenUtil.init(context);
            return widget!;
          },
        );
      },
    );
  }
}
