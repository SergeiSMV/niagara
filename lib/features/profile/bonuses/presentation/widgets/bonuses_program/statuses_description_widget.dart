import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
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
            AppBoxes.kHeight32,
            Padding(
              padding: AppInsets.kHorizontal16,
              child: Text(
                t.bonuses.aboutBonusesProgram.morePurchases,
                style: context.textStyle.headingTypo.h3.withColor(
                  context.colors.textColors.main,
                ),
              ),
            ),
            AppBoxes.kHeight24,
            SingleChildScrollView(
              padding: AppInsets.kHorizontal16,
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
                    child: Padding(
                      padding: !isLast ? AppInsets.kRight24 : EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: AppInsets.kAll12,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: status.level.cardImage.provider(),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: AppBorders.kCircular12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Assets.images.logo
                                    .svg(height: AppSizes.kGeneral16),
                                AppBoxes.kHeight72,
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
                          AppBoxes.kHeight16,
                          Text(
                            '${status.level.toLocale} ${t.bonuses.status.toLowerCase()}',
                            style: context.textStyle.textTypo.tx1SemiBold
                                .withColor(
                              context.colors.textColors.main,
                            ),
                          ),
                          AppBoxes.kHeight8,
                          Text(
                            status.description,
                            style:
                                context.textStyle.textTypo.tx3Medium.withColor(
                              context.colors.textColors.secondary,
                            ),
                          ),
                          AppBoxes.kHeight16,
                          ...List.generate(
                            status.benefits.length,
                            (index) => Padding(
                              padding: AppInsets.kVertical8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    status.benefits[index].title,
                                    style: context
                                        .textStyle.textTypo.tx2SemiBold
                                        .withColor(
                                      context.colors.textColors.main,
                                    ),
                                  ),
                                  AppBoxes.kHeight4,
                                  Text(
                                    status.benefits[index].description,
                                    style: context.textStyle.textTypo.tx3Medium
                                        .withColor(
                                      context.colors.textColors.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            AppBoxes.kHeight8,
          ],
        ),
      ),
    );
  }
}
