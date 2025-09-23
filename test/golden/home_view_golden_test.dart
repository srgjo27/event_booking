import 'package:flutter_test/flutter_test.dart';
import 'package:event_booking/app/app.locator.dart';

void main() {
  setUpAll(() => setupLocator());
  tearDownAll(() => locator.reset());
}
