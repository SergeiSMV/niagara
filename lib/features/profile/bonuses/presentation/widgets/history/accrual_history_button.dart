import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/history/bonuses_history_widget.dart';

class AccrualHistoryButton extends StatelessWidget {
  const AccrualHistoryButton({super.key});

  Future<void> _showBonusHistoryModal(BuildContext context) async =>
      showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: context.colors.mainColors.white,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) => const BonusesHistoryWidget(),
      );

  @override
  Widget build(BuildContext context) {
    final color = context.colors.mainColors.white;
    final style = context.textStyle.buttonTypo.btn2semiBold.withColor(color);

    return InkWell(
      onTap: () => _showBonusHistoryModal(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            t.bonuses.accrualHistory,
            style: style,
          ),
          Assets.icons.arrowRight.svg(
            width: AppConst.kIconSmall,
            height: AppConst.kIconSmall,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
