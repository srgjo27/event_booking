// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/bottom_sheets/base/base_sheet.dart';
import '../ui/bottom_sheets/event_detail/event_detail_sheet.dart';

enum BottomSheetType {
  base,
  eventDetail,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.base: (context, request, completer) =>
        BaseSheet(request: request, completer: completer),
    BottomSheetType.eventDetail: (context, request, completer) =>
        EventDetailSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
