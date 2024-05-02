import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/locations/_common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/features/locations/shops/presentation/bloc/shops_bloc.dart';

class CloseModalButton extends StatelessWidget {
  const CloseModalButton({super.key});

  void _onUnselectShop(BuildContext context) => context
    ..read<ShopsBloc>().add(const ShopsEvent.unselectShop())
    ..read<MapCubit>().setDefaultLocation();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onUnselectShop(context),
      child: Container(
        width: AppConst.kIconLarge,
        height: AppConst.kIconLarge,
        padding: AppConst.kCommon2.horizontal,
        decoration: BoxDecoration(
          color: context.colors.buttonColors.secondary,
          borderRadius: BorderRadius.circular(AppConst.kCommon6),
        ),
        child: Assets.icons.close.svg(
          colorFilter: ColorFilter.mode(
            context.colors.textColors.main,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
