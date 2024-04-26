import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/features/location/presentation/adding_address/choice_on_map/widgets/choice_on_map_map_widget.dart';
import 'package:niagara_app/features/location/presentation/adding_address/choice_on_map/widgets/choice_on_map_modal.dart';
import 'package:niagara_app/features/location/presentation/adding_address/choice_on_map/widgets/request_location_button.dart';

@RoutePage()
class ChoiceOnMapPage extends StatelessWidget {
  const ChoiceOnMapPage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        appBar: AppBarWidget(
          actions: [RequestLocationButton()],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ChoiceOnMapMapWidget(),
            ChoiceOnMapModal(),
          ],
        ),
      );
}
