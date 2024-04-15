import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/location/presentation/cubit/map_cubit.dart';

class RequestLocationButton extends StatelessWidget {
  const RequestLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mapCubit = context.read<MapCubit>();
    return InkWell(
      onTap: mapCubit.determinePosition,
      child: Assets.icons.location
          .svg(width: AppConst.kIconLarge, height: AppConst.kIconLarge)
          .paddingSymmetric(horizontal: AppConst.kCommon16),
    );
  }
}
