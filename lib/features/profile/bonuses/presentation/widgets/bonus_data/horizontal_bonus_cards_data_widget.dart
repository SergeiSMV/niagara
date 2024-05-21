import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonuses_data_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/prepaid_water_data_widget.dart';

class HorizontalBonusCardsDataWidget extends StatelessWidget {
  const HorizontalBonusCardsDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: BonusesDataWidget()),
        AppBoxes.kWidth8,
        Expanded(child: PrepaidWaterDataWidget()),
      ],
    );
  }
}
