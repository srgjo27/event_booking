import 'package:stacked/stacked.dart';

class ProfileViewmodel extends BaseViewModel {
  // Profile data
  String get userName => "John Doe";
  String get userEmail => "john.doe@email.com";
  String get userPhone => "+62 812 3456 7890";
  String get profileImageUrl => "https://via.placeholder.com/150";

  // Statistics
  int get eventsJoined => 24;
  int get eventsHosted => 8;
  int get followers => 156;
  int get following => 89;

  // Profile actions
  void onEditProfilePressed() {
    // Navigate to edit profile
    print("Edit profile pressed");
  }

  void onSettingsPressed() {
    // Navigate to settings
    print("Settings pressed");
  }

  void onNotificationsPressed() {
    // Navigate to notifications
    print("Notifications pressed");
  }

  void onHelpPressed() {
    // Navigate to help
    print("Help pressed");
  }

  void onAboutPressed() {
    // Navigate to about
    print("About pressed");
  }

  void onLogoutPressed() {
    // Handle logout
    print("Logout pressed");
  }
}
