import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonus_data_widget.dart';

class BonusesDataWidget extends StatelessWidget {
  const BonusesDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (_, state) => state.maybeWhen(
        orElse: () => const SizedBox.shrink(),
        loaded: (bonuses, _) => BonusDataWidget(
          title: t.bonuses.bonuses,
          value: bonuses.count.toString(),
          icon: Assets.icons.coinNiagara,
        ),
      ),
    );
  }
}
