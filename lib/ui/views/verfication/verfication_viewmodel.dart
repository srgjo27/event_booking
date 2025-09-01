import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class VerficationViewModel extends BaseViewModel {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  Timer? _timer;
  int _start = 30;
  int get timerDisplay => _start;

  bool get canResend => _start == 0;

  void initialise() {
    startTimer();
    focusNode.requestFocus();
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
    debugPrint('Verifying code: ${pinController.text}');
  }

  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
