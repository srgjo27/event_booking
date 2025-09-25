import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:event_booking/models/event_models.dart';

import 'event_detail_viewmodel.dart';

class EventDetailView extends StackedView<EventDetailViewModel> {
  final Event event;

  const EventDetailView({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  EventDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EventDetailViewModel(initialEvent: event);

  @override
  Widget builder(
    BuildContext context,
    EventDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Text(viewModel.event?.title ?? 'No Event'),
      ),
    );
  }
}
