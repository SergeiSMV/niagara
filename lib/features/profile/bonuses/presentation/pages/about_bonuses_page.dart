import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/modal_background_widget.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_program_cubit/bonuses_program_cubit.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonuses_program/bonuses_program_header_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonuses_program/f_a_q_bonuses_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonuses_program/joining_is_quick_and_easy_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonuses_program/statuses_description_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonuses_program/two_types_bonuses_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonuses_program/what_bonus_program_gives_widget.dart';

@RoutePage()
class AboutBonusesPage extends StatelessWidget {
  const AboutBonusesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BonusesProgramCubit>(),
      child: const Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBarWidget(),
            SliverToBoxAdapter(child: _Content()),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  void _onRefresh(BuildContext context) =>
      context.read<BonusesProgramCubit>().getAboutBonusProgram();

  @override
  Widget build(BuildContext context) {
    final modalSize = context.select<BonusesBloc, double>(
      (bloc) => bloc.state.maybeWhen(
        unauthorized: () => 320,
        orElse: () => 180,
      ),
    );
    return BlocBuilder<BonusesProgramCubit, BonusesProgramState>(
      builder: (_, state) => state.when(
        initial: SizedBox.shrink,
        loading: AppCenterLoader.new,
        loaded: (_) => Stack(
          children: [
            const BonusesProgramHeaderWidget(),
            Column(
              children: [
                SizedBox(height: modalSize),
                const ModalBackgroundWidget(
                  child: Column(
                    children: [
                      WhatBonusProgramGivesWidget(),
                      JoiningIsQuickAndEasyWidget(),
                      TwoTypesBonusesWidget(),
                      StatusesDescriptionWidget(),
                      FAQBonusesWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        error: () => ErrorRefreshWidget(
          onRefresh: () => _onRefresh(context),
        ),
      ),
    );
  }
}
