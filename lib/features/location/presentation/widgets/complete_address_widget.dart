import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/cubit/map_cubit.dart';

class CompleteAddressWidget extends StatelessWidget {
  const CompleteAddressWidget(this.address, {super.key});

  final String address;

  @override
  Widget build(BuildContext context) {
    final mapCubit = context.read<MapCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address,
          style: context.textStyle.textTypo.tx1SemiBold,
        ).paddingSymmetric(vertical: AppConst.kCommon24),
        AppTextButton.primary(
          text: t.locations.yeahThatsRight,
          onTap: () => mapCubit.approveAddress(address: address),
        ),
        AppTextButton.secondary(
          text: t.locations.enterManually,
          onTap: () {},
        ).paddingSymmetric(vertical: AppConst.kCommon12),
        AppConst.kCommon12.height,
      ],
    );
  }
}
