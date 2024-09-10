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
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';

/// Виджет выбора опции активации ВИП-подписки.
class ActivationOptionsWidget extends StatefulWidget {
  const ActivationOptionsWidget(this.options);

  /// Список опций.
  final List<ActivationOption>? options;

  @override
  State<ActivationOptionsWidget> createState() =>
      _ActivationOptionsWidgetState();
}

class _ActivationOptionsWidgetState extends State<ActivationOptionsWidget> {
  int? selectedOption;

  void _onOptionSelected(int index) {
    setState(() {
      if (selectedOption == index) {
        selectedOption = null;
        return;
      }

      selectedOption = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.options == null) {
      return const SizedBox.shrink();
    }

    final ActivationOption first = widget.options![1];
    final ActivationOption second = widget.options![0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.vip.chooseOption,
          style: context.textStyle.headingTypo.h3,
        ),
        AppBoxes.kHeight16,
        const _CurrentSubscriptionWidget(),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _onOptionSelected(0),
                child: _ActivationOptionPanel(
                  bgColor: context.colors.infoColors.bgBlue,
                  title: first.title,
                  monthlyPrice: first.sumForMounth,
                  selected: selectedOption == 0,
                  totalPrice: first.sum,
                  label: first.label,
                ),
              ),
            ),
            AppBoxes.kWidth12,
            Expanded(
              child: InkWell(
                onTap: () => _onOptionSelected(1),
                child: _ActivationOptionPanel(
                  bgColor: context.colors.buttonColors.secondary,
                  title: second.title,
                  monthlyPrice: second.sumForMounth,
                  selected: selectedOption == 1,
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

class _CurrentSubscriptionWidget extends StatelessWidget {
  const _CurrentSubscriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (context, state) => state.maybeWhen(
        loaded: (bonuses, statusDescription) => Padding(
          padding: AppInsets.kBottom8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: AppBorders.kCircular12,
              color: context.colors.mainColors.bgCard,
            ),
            child: Padding(
              padding: AppInsets.kAll12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.infoColors.green,
                      borderRadius: AppBorders.kCircular4,
                    ),
                    child: Padding(
                      padding: AppInsets.kHorizontal10 + AppInsets.kVertical6,
                      child: Text(
                        'Текущаяя подписка',
                        style: context.textStyle.captionTypo.c1.withColor(
                          context.colors.textColors.white,
                        ),
                      ),
                    ),
                  ),
                  AppBoxes.kHeight8,
                  Text(
                    'VIP-подписка активна до ${bonuses.endDateFormated}',
                    style: context.textStyle.textTypo.tx1SemiBold,
                  ),
                ],
              ),
            ),
          ),
        ),
        orElse: SizedBox.shrink,
      ),
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
