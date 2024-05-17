import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/modal_background_widget.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
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
  static double get _sheetSize => AppConst.kCommon08;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppConst.kCommon24.verticalBox,
                  Text(
                    t.bonuses.yourBenefits,
                    style: context.textStyle.headingTypo.h3.withColor(
                      context.colors.textColors.main,
                    ),
                  ),
                  AppConst.kCommon16.verticalBox,
                  const ListBenefitsWidget(),
                  Column(
                    children: [
                      const YearlyBonusesWidget(),
                      AppConst.kCommon12.verticalBox,
                      const AccruedBonusesWidget(),
                    ],
                  ).paddingSymmetric(vertical: AppConst.kCommon16),
                  Column(
                    children: [
                      Text(
                        t.bonuses.morePurchases,
                        style: context.textStyle.headingTypo.h3
                            .withColor(context.colors.textColors.main),
                      ),
                      AppConst.kCommon16.verticalBox,
                      const NextLevelWidget(),
                      AppConst.kCommon24.verticalBox,
                      const AboutBonusProgramButton(),
                    ],
                  ).paddingSymmetric(vertical: AppConst.kCommon16),
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
                        thickness: AppConst.kCommon1,
                      ),
                      BonusesFooterButton(
                        icon: Assets.icons.support,
                        title: t.bonuses.contactUs,
                        onTap: () {},
                      ),
                      Divider(
                        height: 0,
                        color: context.colors.otherColors.separator30,
                        thickness: AppConst.kCommon1,
                      ),
                      AppConst.kCommon48.verticalBox,
                    ],
                  ),
                ],
              ).paddingSymmetric(horizontal: AppConst.kCommon16),
            ),
          ),
        ),
      ],
    );
  }
}
