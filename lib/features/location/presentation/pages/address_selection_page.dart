import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/map_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/static_bottom_modal.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/cubit/map_cubit.dart';
import 'package:niagara_app/features/location/presentation/widgets/approve_address_widget.dart';
import 'package:niagara_app/features/location/presentation/widgets/complete_address_widget.dart';
import 'package:niagara_app/features/location/presentation/widgets/request_location_button.dart';

@RoutePage()
class AddressSelectionPage extends StatelessWidget {
  const AddressSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mapCubit = context.read<MapCubit>();
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
            key: mapCubit.mapKey,
            mapObjects: const [],
            onControllerCreated: mapCubit.onControllerCreated,
            onUserLocationUpdated: mapCubit.onUserLocationUpdated,
            allowUserInteractions: false,
          ),
          StaticBottomModalWidget(
            key: mapCubit.modalKey,
            child: SafeArea(
              child: BlocBuilder<MapCubit, MapState>(
                builder: (_, state) => state.when(
                  initial: SizedBox.new,
                  searching: SizedBox.new,
                  complete: CompleteAddressWidget.new,
                  approve: ApproveAddressWidget.new,
                ),
              ).paddingSymmetric(horizontal: AppConst.kCommon16),
            ),
          ),
        ],
      ),
    );
  }
}
