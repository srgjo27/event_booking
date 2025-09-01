import 'package:flutter_test/flutter_test.dart';
import 'package:event_booking/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('VerficationViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
