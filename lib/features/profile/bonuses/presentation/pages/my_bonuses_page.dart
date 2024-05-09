import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_content_widget.dart';

@RoutePage()
class MyBonusesPage extends StatelessWidget {
  const MyBonusesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: BlocBuilder<BonusesBloc, BonusesState>(
        builder: (_, state) => state.maybeWhen(
          loading: AppCenterLoader.new,
          loaded: BonusContentWidget.new,
          orElse: () => ErrorRefreshWidget(error: 'error', onRefresh: () {}),
        ),
      ),
    );
  }
}
