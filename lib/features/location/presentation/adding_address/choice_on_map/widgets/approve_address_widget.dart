import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:niagara_app/features/location/presentation/adding_address/address_details/cubit/address_details_cubit.dart';
import 'package:niagara_app/features/location/presentation/adding_address/address_details/widget/address_details_fields_widget.dart';
import 'package:niagara_app/features/location/presentation/adding_address/choice_on_map/cubit/choice_on_map_cubit.dart';
import 'package:niagara_app/features/location/presentation/locations/bloc/locations_bloc.dart';

class ApproveAddressWidget extends StatelessWidget {
  const ApproveAddressWidget(
    this.location, {
    super.key,
  });

  final Location location;

  void onApproveAndGoBack(BuildContext context, Location location) {
    context
      ..read<LocationsBloc>().add(LocationsEvent.addLocation(location))
      ..maybePop();
  }

  void editAddress(BuildContext context) =>
      context.read<ChoiceOnMapCubit>().onEditAddress();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddressDetailsCubit>(param1: location),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                location.name,
                style: context.textStyle.textTypo.tx1SemiBold,
              ),
              InkWell(
                onTap: () => editAddress(context),
                child: Assets.icons.pen.svg(
                  width: AppConst.kIconMedium,
                  height: AppConst.kIconMedium,
                ),
              ),
            ],
          ).paddingSymmetric(vertical: AppConst.kCommon24),
          const AddressDetailsFieldsWidget(),
          BlocBuilder<AddressDetailsCubit, Location>(
            builder: (_, location) => AppTextButton.primary(
              text: t.locations.continueButton,
              onTap: () => onApproveAndGoBack(context, location),
            ),
          ).paddingSymmetric(vertical: AppConst.kCommon24),
        ],
      ).paddingSymmetric(horizontal: AppConst.kCommon16),
    );
  }
}
