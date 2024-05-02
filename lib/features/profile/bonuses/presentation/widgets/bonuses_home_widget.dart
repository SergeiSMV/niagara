import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc.dart';

class HomeBonusesWidget extends StatelessWidget {
  const HomeBonusesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (context, state) => state
          .maybeWhen(
            orElse: SizedBox.shrink,
            loaded: (bonuses) => Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBonusDataWidget(
                        context,
                        title: 'Бонусы',
                        value: bonuses.count.toString(),
                        icon: Assets.icons.coinNiagara,
                      ),
                      AppConst.kCommon8.verticalBox,
                      _buildBonusDataWidget(
                        context,
                        title: 'Временные',
                        value: bonuses.tempCount.toString(),
                        icon: Assets.icons.fire,
                      ),
                    ],
                  ),
                ),
                AppConst.kCommon8.horizontalBox,
                Flexible(
                  child: Stack(
                    children: [
                      Assets.images.bonusStatus.silver.image(),
                    ],
                  ),
                ),
              ],
            ),
          )
          .paddingSymmetric(
            vertical: AppConst.kCommon24,
            horizontal: AppConst.kCommon16,
          ),
    );
  }

  DecoratedBox _buildBonusDataWidget(
    BuildContext context, {
    required String title,
    required String value,
    required SvgGenImage icon,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        borderRadius: BorderRadius.circular(AppConst.kCommon12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textStyle.textTypo.tx4Medium,
          ),
          AppConst.kCommon8.verticalBox,
          Row(
            children: [
              icon.svg(
                width: AppConst.kIconMedium,
                height: AppConst.kIconMedium,
              ),
              AppConst.kCommon6.horizontalBox,
              Text(
                value,
                style: context.textStyle.textTypo.tx2SemiBold,
              ),
            ],
          ),
        ],
      ).paddingAll(AppConst.kCommon8),
    );
  }
}
