import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/address_selection/cubit/address_selection_cubit.dart';

class CompleteAddressWidget extends StatelessWidget {
  const CompleteAddressWidget(this.address, {super.key});

  final String address;

  void _onManualInput(BuildContext context) =>
      context.pushRoute(const SearchAddressRoute());

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddressSelectionCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address,
          style: context.textStyle.textTypo.tx1SemiBold,
        ).paddingSymmetric(vertical: AppConst.kCommon24),
        AppTextButton.primary(
          text: t.locations.yeahThatsRight,
          onTap: cubit.onApproveAddress,
        ),
        AppTextButton.secondary(
          text: t.locations.enterManually,
          onTap: () => _onManualInput(context),
        ).paddingSymmetric(vertical: AppConst.kCommon12),
        AppConst.kCommon12.height,
      ],
    );
  }
}
