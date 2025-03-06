import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonuses_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/prepaid_water_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/temporary_bonuses_data_widget.dart';

class HorizontalBonusCardsDataWidget extends StatelessWidget {
  const HorizontalBonusCardsDataWidget({
    super.key,
    required this.bonuses,
  });
  final Bonuses bonuses;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.kGeneral72,
      child: Row(
        children: [
          const Flexible(child: BonusesDataWidget()),
          AppBoxes.kWidth8,
          if (bonuses.tempCount > 0) ...[
            const Flexible(child: TemporaryBonusesDataWidget()),
            AppBoxes.kWidth6,
          ],
          const Flexible(child: PrepaidWaterDataWidget()),
        ],
      ),
    );
  }
}
