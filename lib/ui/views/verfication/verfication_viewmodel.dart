import 'dart:async';
import 'package:event_booking/app/app.locator.dart';
import 'package:event_booking/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VerficationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final pinController = TextEditingController();

  Timer? _timer;
  int _start = 30;
  int get timerDisplay => _start;

  bool get canResend => _start == 0;

  void initialise() {
    startTimer();
  }

  void startTimer() {
    _start = 30;
    _timer?.cancel();
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          notifyListeners();
        } else {
          _start--;
          notifyListeners();
        }
      },
    );
  }

  void resendCode() {
    if (canResend) {
      debugPrint('Mengirim ulang kode...');
      startTimer();
    }
  }

  void verifyCode() {
    _navigationService.navigateToMainView();
  }

  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    super.dispose();
  }
}
