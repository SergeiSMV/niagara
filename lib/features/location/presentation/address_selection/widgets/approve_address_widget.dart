import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';
import 'package:niagara_app/features/location/presentation/address_selection/cubit/address_selection_cubit.dart';

class ApproveAddressWidget extends StatelessWidget {
  const ApproveAddressWidget(
    this.location, {
    super.key,
  });

  final Location location;

  void goToMain(BuildContext context) =>
      context.replaceRoute(const NavigationRoute());

  void editAddress(BuildContext context) =>
      context.read<AddressSelectionCubit>().onEditAddress();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
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
            const _AdditionalAddressFields(),
            AppTextButton.primary(
              text: t.locations.continueButton,
              onTap: () => goToMain(context),
            ).paddingSymmetric(vertical: AppConst.kCommon24),
          ],
        ),
      ],
    );
  }
}

class _AdditionalAddressFields extends StatelessWidget {
  const _AdditionalAddressFields();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddressSelectionCubit>();
    return Column(
      children: [
        AppTextField.number(
          label: t.locations.flatOffice,
          onChanged: (flat) => cubit.updateAdditionalAddressData(flat: flat),
        ),
        AppConst.kCommon12.height,
        Row(
          children: [
            Expanded(
              child: AppTextField.number(
                label: t.locations.entrance,
                onChanged: (entrance) =>
                    cubit.updateAdditionalAddressData(entrance: entrance),
              ),
            ),
            AppConst.kCommon12.width,
            Expanded(
              child: AppTextField.number(
                label: t.locations.floor,
                onChanged: (floor) =>
                    cubit.updateAdditionalAddressData(floor: floor),
              ),
            ),
          ],
        ),
        AppConst.kCommon12.height,
        AppTextField.text(
          label: t.locations.addressComment,
          onChanged: (comment) =>
              cubit.updateAdditionalAddressData(comment: comment),
        ),
        AppConst.kCommon12.height,
      ],
    );
  }
}
