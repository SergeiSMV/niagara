import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/address_selection_map.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/address_selection_modal.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/request_location_button.dart';

@RoutePage()
class AddressSelectionPage extends StatelessWidget {
  const AddressSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(
        automaticallyImplyLeading: false,
        actions: [RequestLocationButton()],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AddressSelectionMap(),
          AddressSelectionModal(),
        ],
      ),
    );
  }
}
