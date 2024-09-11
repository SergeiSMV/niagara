import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';
import 'package:niagara_app/features/vip/presentation/bloc/vip_activation_selection_cubit/vip_activation_selection_cubit.dart';
import 'package:niagara_app/features/vip/presentation/widget/current_subscription_widget.dart';

/// Виджет выбора опции активации ВИП-подписки.
class ActivationOptionsWidget extends StatelessWidget {
  const ActivationOptionsWidget(this.options, this.vipEndDate);

  /// Список опций.
  final List<ActivationOption> options;

  /// Дата окончания ВИП-подписки, если она есть.
  final String? vipEndDate;

  @override
  Widget build(BuildContext context) {
    // Сортируем опции по возрастанию стоимости за месяц.
    options.sort((a, b) => a.sumForMounth.compareTo(b.sumForMounth));

    final ActivationOption first = options[0];
    final ActivationOption second = options[1];

    final activationSelectionCubit =
        context.watch<VipActivationSelectionCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.vip.chooseOption,
          style: context.textStyle.headingTypo.h3,
        ),
        AppBoxes.kHeight16,
        if (vipEndDate != null) ...[
          CurrentSubscriptionWidget(endDate: vipEndDate!),
          AppBoxes.kHeight8,
        ],
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => activationSelectionCubit.select(first),
                child: _ActivationOptionPanel(
                  bgColor: context.colors.infoColors.bgBlue,
                  title: first.title,
                  monthlyPrice: first.sumForMounth,
                  selected: activationSelectionCubit.state == first,
                  totalPrice: first.sum,
                  label: first.label,
                ),
              ),
            ),
            AppBoxes.kWidth12,
            Expanded(
              child: InkWell(
                onTap: () => activationSelectionCubit.select(second),
                child: _ActivationOptionPanel(
                  bgColor: context.colors.buttonColors.secondary,
                  title: second.title,
                  monthlyPrice: second.sumForMounth,
                  selected: activationSelectionCubit.state == second,
                  totalPrice: second.sum,
                ),
              ),
            ),
          ],
        ),
        AppBoxes.kHeight12,
      ],
    );
  }
}

/// Панель с опцией активации.
class _ActivationOptionPanel extends StatelessWidget {
  const _ActivationOptionPanel({
    required this.bgColor,
    required this.totalPrice,
    required this.monthlyPrice,
    required this.title,
    this.selected = false,
    this.label,
  });

  /// Цвет фона.
  final Color bgColor;

  /// Общая стоимость.
  final String totalPrice;

  /// Стоимость в месяц.
  final String monthlyPrice;

  /// Заголовок.
  final String title;

  /// Лейбл. Отображается в верхнем левом углу.
  final String? label;

  /// Выбрана ли опция.
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular12,
        color: bgColor,
      ),
      child: Padding(
        padding: AppInsets.kRight12 + AppInsets.kLeft8 + AppInsets.kVertical12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null) ...[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: context.colors.gradientColors.promotionsBanner,
                        stops: AppConstants.profileBannersStops,
                      ),
                      borderRadius: AppBorders.kCircular4,
                    ),
                    child: Padding(
                      padding: AppInsets.kHorizontal10 + AppInsets.kVertical6,
                      child: Text(
                        label!,
                        style: context.textStyle.captionTypo.c1.withColor(
                          context.colors.textColors.white,
                        ),
                      ),
                    ),
                  ),
                ] else
                  const SizedBox.shrink(),
                if (selected)
                  Assets.icons.check.svg()
                else
                  Assets.icons.unchecked.svg(),
              ],
            ),
            AppBoxes.kHeight24,
            Text(
              '$totalPrice ${t.common.rub}',
              style: context.textStyle.headingTypo.h2,
            ),
            AppBoxes.kHeight2,
            Text(
              title,
              style: context.textStyle.textTypo.tx2Medium.withColor(
                context.colors.textColors.secondary,
              ),
            ),
            AppBoxes.kHeight24,
            Text(
              '$monthlyPrice ${t.common.rub} ${t.vip.forMonth}',
              style: context.textStyle.textTypo.tx1SemiBold,
            ),
          ],
        ),
      ),
    );
  }
}
