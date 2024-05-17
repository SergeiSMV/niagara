import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/close_modal_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/draggable_pin_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/modal_background_widget.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/history/bonus_history_tile.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/history/burn_bonuses_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/history/no_bonuses_widget.dart';

class BonusesHistoryWidget extends StatelessWidget {
  const BonusesHistoryWidget({
    required this.bonusesHistory,
    super.key,
  });

  final List<dynamic> bonusesHistory;

  bool get isNotEmpty => bonusesHistory.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return ModalBackgroundWidget(
      child: Column(
        children: [
          const PinWidget(),
          const _ModalStaticHeader(),
          if (isNotEmpty)
            Flexible(
              child: Stack(
                children: [
                  // ListView.separated(
                  //   itemCount: bonusesHistory.length,
                  //   itemBuilder: (_, index) => BonusHistoryTile(
                  //     title: bonusesHistory[index].programId,
                  //     date: bonusesHistory[index].endDate,
                  //     count: bonusesHistory[index].count,
                  //     isTemp: bonusesHistory[index].isTemp,
                  //   ),
                  //   separatorBuilder: (_, __) => Divider(
                  //     height: 0,
                  //     color: context.colors.otherColors.separator30,
                  //     thickness: AppConst.kCommon1,
                  //   ),
                  // ),
                  const BurnBonusesWidget(),
                ],
              ),
            )
          else
            const NoBonusesWidget(),
        ],
      ),
    );
  }
}

class _ModalStaticHeader extends StatelessWidget {
  const _ModalStaticHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t.bonuses.bonusStory,
          style: context.textStyle.headingTypo.h3
              .withColor(context.colors.textColors.main),
        ),
        CloseModalButton(onTap: () => context.maybePop()),
      ],
    ).paddingSymmetric(
      horizontal: AppConst.kCommon16,
      vertical: AppConst.kCommon8,
    );
  }
}
