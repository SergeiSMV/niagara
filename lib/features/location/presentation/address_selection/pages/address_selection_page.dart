import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/address_selection_map.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/address_selection_modal.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/request_location_button.dart';

@RoutePage()
class AddressSelectionPage extends StatelessWidget {
  const AddressSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: t.locations.deliveryAddress,
        automaticallyImplyLeading: false,
        actions: const [RequestLocationButton()],
      ),
      body: const Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AddressSelectionMap(),
          AddressSelectionModal(),
        ],
      ),
    );
  }
}
