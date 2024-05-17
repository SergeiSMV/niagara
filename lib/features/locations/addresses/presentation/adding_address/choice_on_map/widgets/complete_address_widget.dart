import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/cubit/choice_on_map_cubit.dart';

class CompleteAddressWidget extends StatelessWidget {
  const CompleteAddressWidget(
    this.location, {
    super.key,
  });

  final Address location;

  void _onManualInput(BuildContext context) =>
      context.pushRoute(const SearchAddressRoute());

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChoiceOnMapCubit>();
    final availableToAddendum = cubit.state.availableToAddendum;

    return Padding(
      padding: AppInsets.kSymmetricH16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppInsets.kSymmetricV24,
            child: Text(
              location.name,
              style: context.textStyle.textTypo.tx1SemiBold,
            ),
          ),
          AppTextButton.primary(
            text: t.locations.yeahThatsRight,
            onTap: availableToAddendum ? cubit.onAddendumAddress : null,
          ),
          Padding(
            padding: AppInsets.kSymmetricV12,
            child: AppTextButton.secondary(
              text: t.locations.enterManually,
              onTap: () => _onManualInput(context),
            ),
          ),
          AppBoxes.kBoxV12,
        ],
      ),
    );
  }
}
