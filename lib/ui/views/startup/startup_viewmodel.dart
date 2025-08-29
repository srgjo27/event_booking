import 'package:stacked/stacked.dart';
import 'package:event_booking/app/app.locator.dart';
import 'package:event_booking/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    // Navigasi ke halaman onboarding setelah startup selesai
    _navigationService.replaceWithOnboardingView();
  }
}
