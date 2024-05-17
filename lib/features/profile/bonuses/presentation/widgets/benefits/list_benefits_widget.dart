import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/benefits/benefit_builder_widget.dart';

class ListBenefitsWidget extends StatelessWidget {
  const ListBenefitsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (_, state) => state.maybeWhen(
        orElse: SizedBox.shrink,
        loaded: (_, statusDescription) => Column(
          children: statusDescription.benefits
              .map(
                (e) => BenefitBuilderWidget(
                  icon: e.picture.picture,
                  title: e.title,
                  description: e.description,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
