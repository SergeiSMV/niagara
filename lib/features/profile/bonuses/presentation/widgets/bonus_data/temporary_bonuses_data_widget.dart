import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonus_data/bonus_data_widget.dart';

// Виджет для отображения временных бонусов на главной странице
class TemporaryBonusesDataWidget extends StatelessWidget {
  const TemporaryBonusesDataWidget({super.key});

  /// Переходит на страницу бонусов.
  void _goToBonuses(BuildContext context) => context.navigateTo(
        const LoyaltyProgramWrapper(
          children: [
            MyBonusesRoute(),
          ],
        ),
      );

  /// Возвращает дату окончания в формате "day.month.".
  String _getEndDate(String endDate) {
    final DateTime dateTime = DateTime.parse(endDate);
    final String formattedDate = DateFormat('dd.MM.').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (_, state) => state.maybeWhen(
        orElse: () => const SizedBox.shrink(),
        loaded: (bonuses, _) => GestureDetector(
          onTap: () => _goToBonuses(context),
          child: BonusDataWidget(
            title:
                '${t.bonuses.temporaryBonuses} ${_getEndDate(bonuses.tempLastDate)}',
            value: bonuses.tempCount.toString(),
            icon: Assets.icons.fire,
          ),
        ),
      ),
    );
  }
}
