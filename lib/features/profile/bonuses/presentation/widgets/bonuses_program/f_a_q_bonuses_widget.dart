import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_program_cubit/bonuses_program_cubit.dart';

class FAQBonusesWidget extends StatelessWidget {
  const FAQBonusesWidget({super.key, this.withHeader = true});

  final bool withHeader;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesProgramCubit, BonusesProgramState>(
      builder: (_, state) => state.maybeWhen(
        orElse: SizedBox.shrink,
        loading: AppCenterLoader.new,
        loaded: (bonusesProgram) => Column(
          children: [
            if (withHeader) ...[
              AppBoxes.kHeight24,
              Text(
                t.bonuses.bonusesFaqs,
                style: context.textStyle.headingTypo.h3.withColor(
                  context.colors.textColors.main,
                ),
              ),
            ],
            AppBoxes.kHeight8,
            ...bonusesProgram.faqBonuses.map(
              (e) => Padding(
                padding: AppInsets.kHorizontal16,
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(
                    e.question,
                    style: context.textStyle.textTypo.tx1Medium
                        .withColor(context.colors.textColors.main),
                  ),
                  shape: const Border(),
                  collapsedShape: Border(
                    bottom: BorderSide(
                      color: context.colors.otherColors.separator30,
                    ),
                  ),
                  iconColor: context.colors.textColors.main,
                  collapsedIconColor: context.colors.textColors.main,
                  children: [
                    Text(
                      e.answer,
                      style: context.textStyle.descriptionTypo.des2
                          .withColor(context.colors.textColors.main),
                    ),
                    AppBoxes.kHeight8,
                  ],
                ),
              ),
            ),
            AppBoxes.kHeight48,
          ],
        ),
      ),
    );
  }
}
