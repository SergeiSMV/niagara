import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonus_data_widget.dart';

class PrepaidWaterDataWidget extends StatelessWidget {
  const PrepaidWaterDataWidget({super.key});

  /// Перенаправляет на страницу баланса предоплатной воды.
  void _navigateToPrepaidWater(BuildContext context) {
    context.navigateTo(
      const ProfileWrapper(
        children: [
          ProfileRoute(),
          PrepaidWaterRoute(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (context, state) => state.maybeWhen(
        orElse: SizedBox.shrink,
        loaded: (bonuses, _) => GestureDetector(
          onTap: () => _navigateToPrepaidWater(context),
          child: BonusDataWidget(
            title: t.bonuses.waterBalance,
            value: '${bonuses.bottles.count} ${t.pieces}',
            icon: Assets.icons.waterFill,
          ),
        ),
      ),
    );
  }
}
