import 'package:event_booking/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:event_booking/app/app.bottomsheets.dart';
import 'package:event_booking/app/app.dialogs.dart';
import 'package:event_booking/app/app.locator.dart';
import 'package:event_booking/app/app.router.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
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
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              brightness: Brightness.light,
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.grey.shade400,
              selectionColor: Colors.grey.shade400,
              selectionHandleColor: Colors.grey.shade400,
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
