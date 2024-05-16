import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonus_data_widget.dart';

class PrepaidWaterDataWidget extends StatelessWidget {
  const PrepaidWaterDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (context, state) => state.maybeWhen(
        orElse: SizedBox.shrink,
        loaded: (bonuses) => BonusDataWidget(
          title: t.bonuses.temporary,
          value: '${bonuses.tempCount} ${t.bonuses.pieces}',
          icon: Assets.icons.waterFill,
        ),
      ),
    );
  }
}
