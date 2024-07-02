import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_program_cubit/bonuses_program_cubit.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonuses_program/f_a_q_bonuses_widget.dart';

@RoutePage()
class BonusesFaqPage extends StatelessWidget {
  const BonusesFaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BonusesProgramCubit>(),
      child: const Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBarWidget(),
            SliverToBoxAdapter(child: FAQBonusesWidget(withHeader: false)),
          ],
        ),
      ),
    );
  }
}
