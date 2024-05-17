import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/modal_background_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/accrued_bonuses_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/benefits/list_benefits_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/about_bonus_program_button.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonus_level_status_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonuses_footer_button.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/next_level_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/yearly_bonuses_widget.dart';

class BonusContentWidget extends StatelessWidget {
  const BonusContentWidget({super.key});

  static final _sheetKey = GlobalKey();
  static final _controller = DraggableScrollableController();

  static double get _sheetSize => .8;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BonusLevelStatusDataWidget(),
        DraggableScrollableSheet(
          key: _sheetKey,
          controller: _controller,
          initialChildSize: _sheetSize,
          minChildSize: _sheetSize,
          builder: (_, scrollCtrl) => SingleChildScrollView(
            controller: scrollCtrl,
            physics: const ClampingScrollPhysics(),
            child: ModalBackgroundWidget(
              child: Padding(
                padding: AppInsets.kSymmetricH16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBoxes.kBoxV24,
                    Text(
                      t.bonuses.yourBenefits,
                      style: context.textStyle.headingTypo.h3.withColor(
                        context.colors.textColors.main,
                      ),
                    ),
                    AppBoxes.kBoxV16,
                    const ListBenefitsWidget(),
                    const Padding(
                      padding: AppInsets.kSymmetricV16,
                      child: Column(
                        children: [
                          YearlyBonusesWidget(),
                          AppBoxes.kBoxV12,
                          AccruedBonusesWidget(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: AppInsets.kSymmetricV16,
                      child: Column(
                        children: [
                          Text(
                            t.bonuses.morePurchases,
                            style: context.textStyle.headingTypo.h3
                                .withColor(context.colors.textColors.main),
                          ),
                          AppBoxes.kBoxV16,
                          const NextLevelWidget(),
                          AppBoxes.kBoxV24,
                          const AboutBonusProgramButton(),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        BonusesFooterButton(
                          icon: Assets.icons.info,
                          title: t.bonuses.bonusesFaqs,
                          onTap: () {},
                        ),
                        Divider(
                          height: 0,
                          color: context.colors.otherColors.separator30,
                          thickness: AppSizes.kGeneral1,
                        ),
                        BonusesFooterButton(
                          icon: Assets.icons.support,
                          title: t.bonuses.contactUs,
                          onTap: () {},
                        ),
                        Divider(
                          height: 0,
                          color: context.colors.otherColors.separator30,
                          thickness: AppSizes.kGeneral1,
                        ),
                        AppBoxes.kBoxV48,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
