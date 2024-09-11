import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/prepaid_water/presentation/widgets/empty_water_balance_widget.dart';

/// Виджет, отображающий баланс предоплатной воды с карточками товаров.
class PrepaidWaterBalanceWidget extends StatelessWidget {
  const PrepaidWaterBalanceWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kTop24,
      child: const EmptyWaterBalanceWidget(),
    );
  }
}

/// Вода загружена и баланс не пуст.
class _Loaded extends StatelessWidget {
  const _Loaded();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.prepaidWater.myBalance,
          style: context.textStyle.headingTypo.h3,
        ),
        AppBoxes.kHeight16,

        // TODO(kvbykov): Добавить отображение баланса:
        // https://digitalburo.youtrack.cloud/issue/NIAGARA-337/Logika.-Predoplatnaya-voda
        const Placeholder(),

        AppBoxes.kHeight24,
      ],
    );
  }
}
