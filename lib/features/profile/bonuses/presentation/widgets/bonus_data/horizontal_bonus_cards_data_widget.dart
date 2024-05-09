import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonus_data_widget.dart';

class HorizontalBonusCardsDataWidget extends StatelessWidget {
  const HorizontalBonusCardsDataWidget({
    required this.bonuses,
    super.key,
  });

  final Bonuses bonuses;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BonusDataWidget(
            title: t.bonuses.bonuses,
            value: bonuses.count.toString(),
            icon: Assets.icons.coinNiagara,
          ),
        ),
        AppConst.kCommon8.horizontalBox,
        Expanded(
          child: BonusDataWidget(
            title: t.bonuses.temporary,
            value: bonuses.tempCount.toString(),
            icon: Assets.icons.fire,
          ),
        ),
      ],
    );
  }
}
