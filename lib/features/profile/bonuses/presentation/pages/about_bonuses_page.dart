import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/modal_background_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/about_bonus_program/bonuses_program_header_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/about_bonus_program/f_a_q_bonuses_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/about_bonus_program/joining_is_quick_and_easy_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/about_bonus_program/two_types_bonuses_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/about_bonus_program/what_bonus_program_gives_widget.dart';

@RoutePage()
class AboutBonusesPage extends StatelessWidget {
  const AboutBonusesPage({super.key});

  static final _sheetKey = GlobalKey();
  static final _controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    final modalSize = context.select(
      (BonusesBloc bloc) => bloc.state.maybeWhen(
        unauthorized: () => 0.45,
        orElse: () => .7,
      ),
    );
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Stack(
        children: [
          const BonusesProgramHeaderWidget(),
          DraggableScrollableSheet(
            key: _sheetKey,
            controller: _controller,
            initialChildSize: modalSize,
            minChildSize: modalSize,
            builder: (_, scrollCtrl) => SingleChildScrollView(
              controller: scrollCtrl,
              physics: const ClampingScrollPhysics(),
              child: const ModalBackgroundWidget(
                child: Column(
                  children: [
                    WhatBonusProgramGivesWidget(),
                    JoiningIsQuickAndEasyWidget(),
                    TwoTypesBonusesWidget(),
                    FAQBonusesWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
