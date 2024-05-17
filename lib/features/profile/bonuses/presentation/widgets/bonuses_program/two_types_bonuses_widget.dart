import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_program_cubit/bonuses_program_cubit.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonuses_program/bonuses_types_build_widget.dart';

class TwoTypesBonusesWidget extends StatelessWidget {
  const TwoTypesBonusesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesProgramCubit, BonusesProgramState>(
      builder: (_, state) => state.maybeWhen(
        orElse: SizedBox.shrink,
        loaded: (bonusesProgram) => Column(
          children: [
            AppConst.kCommon32.verticalBox,
            Text(
              t.bonuses.aboutBonusesProgram.twoTypesBonuses,
              style: context.textStyle.headingTypo.h3.withColor(
                context.colors.textColors.main,
              ),
            ),
            AppConst.kCommon8.verticalBox,
            BonusesTypesBuildWidget(
              image: Assets.images.aboutBonuses.aboutFour,
              title: t.bonuses.aboutBonusesProgram.primaryBonusesTitle,
              descriptions: List.generate(
                bonusesProgram.aboutBonusProgram.mainBonuses.length,
                (index) => bonusesProgram.aboutBonusProgram.mainBonuses[index],
              ),
            ),
            BonusesTypesBuildWidget(
              image: Assets.images.aboutBonuses.aboutFive,
              title: t.bonuses.aboutBonusesProgram.temporaryBonusesTitle,
              descriptions: List.generate(
                bonusesProgram.aboutBonusProgram.temporaryBonuses.length,
                (index) =>
                    bonusesProgram.aboutBonusProgram.temporaryBonuses[index],
              ),
            ),
            AppConst.kCommon8.verticalBox,
          ],
        ),
      ),
    ).paddingSymmetric(horizontal: AppConst.kCommon16);
  }
}
