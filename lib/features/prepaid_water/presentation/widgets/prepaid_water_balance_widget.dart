import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/prepaid_water/presentation/bloc/balance_cubit/water_balance_cubit.dart';
import 'package:niagara_app/features/prepaid_water/presentation/widgets/empty_water_balance_widget.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';

/// Виджет, отображающий баланс предоплатной воды с карточками товаров.
class PrepaidWaterBalanceWidget extends StatelessWidget {
  const PrepaidWaterBalanceWidget();

  /// Обновляет баланс воды.
  void _onRefresh(BuildContext context) =>
      context.read<WaterBalanceCubit>().getBottles();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kTop24,
      child: BlocBuilder<WaterBalanceCubit, WaterBalanceState>(
        builder: (context, state) => state.maybeWhen(
          loading: AppCenterLoader.new,
          loaded: _Loaded.new,
          error: () => ErrorRefreshWidget(onRefresh: () => _onRefresh(context)),
          orElse: EmptyWaterBalanceWidget.new,
        ),
      ),
    );
  }
}

/// Вода загружена и баланс не пуст.
class _Loaded extends StatelessWidget {
  const _Loaded(this.balance);

  /// Баланс предоплатной воды.
  final Bottles balance;

  @override
  Widget build(BuildContext context) {
    final int length = balance.bottles.length;
    final List<Widget> children = balance.bottles
        .map((bottle) => ProductWidget(product: bottle))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.prepaidWater.myBalance,
          style: context.textStyle.headingTypo.h3,
        ),
        AppBoxes.kHeight16,

        // Карточки товаров.
        AspectRatio(
          aspectRatio: 1.2,
          child: ListView.separated(
            itemCount: length,
            padding: AppInsets.kHorizontal16,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => AspectRatio(
              aspectRatio: 0.55,
              child: children[index],
            ),
            separatorBuilder: (_, __) => AppBoxes.kWidth8,
          ),
        ),
        AppBoxes.kHeight24,
      ],
    );
  }
}
