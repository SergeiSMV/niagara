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

class StatusesDescriptionWidget extends StatelessWidget {
  const StatusesDescriptionWidget({super.key});

  double get _cardWidth => 232;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesProgramCubit, BonusesProgramState>(
      builder: (_, state) => state.maybeWhen(
        orElse: SizedBox.shrink,
        loaded: (bonusesProgram) => Column(
          children: [
            AppConst.kCommon32.verticalBox,
            Text(
              t.bonuses.aboutBonusesProgram.morePurchases,
              style: context.textStyle.headingTypo.h3.withColor(
                context.colors.textColors.main,
              ),
            ).paddingSymmetric(horizontal: AppConst.kCommon16),
            AppConst.kCommon24.verticalBox,
            SingleChildScrollView(
              padding: AppConst.kCommon16.horizontal,
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    bonusesProgram.statusesDescriptions.length, (index) {
                  final status = bonusesProgram.statusesDescriptions[index];
                  final isLast =
                      index == bonusesProgram.statusesDescriptions.length - 1;
                  return SizedBox(
                    width: _cardWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: AppConst.kCommon12.all,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: status.level.cardImage.provider(),
                              fit: BoxFit.fill,
                            ),
                            borderRadius:
                                BorderRadius.circular(AppConst.kCommon12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Assets.images.logo
                                  .svg(height: AppConst.kCommon16),
                              AppConst.kCommon72.verticalBox,
                              Text(
                                t.bonuses.bonusCard,
                                style: context.textStyle.textTypo.tx3SemiBold
                                    .withColor(
                                  context.colors.textColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppConst.kCommon16.verticalBox,
                        Text(
                          status.level.toLocale(),
                          style:
                              context.textStyle.textTypo.tx1SemiBold.withColor(
                            context.colors.textColors.main,
                          ),
                        ),
                        AppConst.kCommon8.verticalBox,
                        Text(
                          status.description,
                          style: context.textStyle.textTypo.tx3Medium.withColor(
                            context.colors.textColors.secondary,
                          ),
                        ),
                        AppConst.kCommon16.verticalBox,
                        ...List.generate(
                          status.benefits.length,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                status.benefits[index].title,
                                style: context.textStyle.textTypo.tx2SemiBold
                                    .withColor(
                                  context.colors.textColors.main,
                                ),
                              ),
                              AppConst.kCommon4.verticalBox,
                              Text(
                                status.benefits[index].description,
                                style: context.textStyle.textTypo.tx3Medium
                                    .withColor(
                                  context.colors.textColors.secondary,
                                ),
                              ),
                            ],
                          ).paddingSymmetric(vertical: AppConst.kCommon8),
                        ),
                      ],
                    ).padding(
                      right: !isLast ? AppConst.kCommon24 : AppConst.kCommon0,
                    ),
                  );
                }),
              ),
            ),
            AppConst.kCommon8.verticalBox,
          ],
        ),
      ),
    );
  }
}
