import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/personalized_prices_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/special_status_q_r_widget.dart';

class SpecialStatusWidget extends StatelessWidget {
  const SpecialStatusWidget({
    super.key,
    required this.bonuses,
  });

  final Bonuses bonuses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SpecialStatusQRWidget(bonuses: bonuses),
          AppBoxes.kHeight8,
          const PersonalizedPricesWidget(),
        ],
      ),
    );
  }
}
