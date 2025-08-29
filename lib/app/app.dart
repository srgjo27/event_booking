import 'package:event_booking/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:event_booking/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:event_booking/ui/views/home/home_view.dart';
import 'package:event_booking/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:event_booking/ui/views/onboarding/onboarding_view.dart';
import 'package:event_booking/ui/views/login/login_view.dart';
import 'package:event_booking/ui/views/register/register_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
