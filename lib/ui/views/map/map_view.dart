import 'package:event_booking/ui/views/map/map_viewmodel.dart';
import 'package:event_booking/ui/views/map/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MapView extends StackedView<MapViewmodel> {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, MapViewmodel viewModel, Widget? child) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          MapContainer(viewModel: viewModel),
          MapSearchBar(viewModel: viewModel),
          MapControls(viewModel: viewModel),
          if (viewModel.selectedEvent != null) ...[
            BackgroundOverlay(
              onTap: viewModel.closeEventDetails,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: EventDetailsSheet(
                selectedEvent: viewModel.selectedEvent!,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  MapViewmodel viewModelBuilder(BuildContext context) {
    return MapViewmodel()..initialise();
  }
}
