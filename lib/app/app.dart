import 'package:event_booking/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:event_booking/ui/views/main/main_view.dart';
import 'package:event_booking/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:event_booking/ui/views/onboarding/onboarding_view.dart';
import 'package:event_booking/ui/views/login/login_view.dart';
import 'package:event_booking/ui/views/register/register_view.dart';
import 'package:event_booking/ui/views/verfication/verfication_view.dart';
import 'package:event_booking/ui/bottom_sheets/base/base_sheet.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: MainView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: VerficationView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: BaseSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
