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
import 'package:event_booking/services/stripe_service.dart';
import 'package:event_booking/ui/bottom_sheets/event_detail/event_detail_sheet.dart';
import 'package:event_booking/ui/views/events/event_detail/event_detail_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: MainView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: VerficationView),
    MaterialRoute(page: EventDetailView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: StripeService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: BaseSheet),
    StackedBottomsheet(classType: EventDetailSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
