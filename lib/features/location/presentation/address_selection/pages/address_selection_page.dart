import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/map_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/static_bottom_modal.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/address_selection/cubit/address_selection_cubit.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/approve_address_widget.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/complete_address_widget.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/location_unavailable_widget.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/no_address_found_widget.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/request_location_button.dart';

@RoutePage()
class AddressSelectionPage extends StatelessWidget {
  const AddressSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddressSelectionCubit>();
    return Scaffold(
      appBar: AppBarWidget(
        title: t.locations.deliveryAddress,
        automaticallyImplyLeading: false,
        actions: const [RequestLocationButton()],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MapWidget(
            key: cubit.mapKey,
            mapObjects: const [],
            onControllerCreated: cubit.onControllerCreated,
            onUserLocationUpdated: cubit.onUserLocationUpdated,
            allowUserInteractions: false,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LocationUnavailableWidget(),
              StaticBottomModalWidget(
                key: cubit.modalKey,
                child: SafeArea(
                  child:
                      BlocBuilder<AddressSelectionCubit, AddressSelectionState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (_, state) => state.maybeWhen(
                      complete: CompleteAddressWidget.new,
                      approve: ApproveAddressWidget.new,
                      denied: NoAddressFoundWidget.new,
                      orElse: SizedBox.new,
                    ),
                  ).paddingSymmetric(horizontal: AppConst.kCommon16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
