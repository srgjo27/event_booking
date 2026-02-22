import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:event_booking/models/event_models.dart';

import 'event_detail_viewmodel.dart';
import 'widgets/widgets.dart';

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
      body: CustomScrollView(
        slivers: [
          EventDetailAppBar(
            viewModel: viewModel,
            event: event,
          ),
          EventDetailBody(viewModel: viewModel),
        ],
      ),
      bottomNavigationBar: EventDetailBookingBar(viewModel: viewModel),
    );
  }
}
