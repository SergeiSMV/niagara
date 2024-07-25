import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';
import 'package:niagara_app/features/vip/presentation/bloc/vip_bloc.dart';

@RoutePage()
class VipPage extends StatelessWidget {
  const VipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(),
          SliverToBoxAdapter(
            child: Assets.images.vipUpperBanner.image(),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<VipBloc, VipState>(
              builder: (_, state) => state.maybeWhen(
                loaded: _Content.new,
                loading: AppCenterLoader.new,
                orElse: SizedBox.shrink,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const _SubscribeButton(),
    );
  }
}

/// Кнопка "оформить подписку".
class _SubscribeButton extends StatelessWidget {
  const _SubscribeButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          AppInsets.kHorizontal16 + AppInsets.kVertical12 + AppInsets.kBottom12,
      child: AppTextButton.primary(
        text: t.vip.subscribe,
        // TODO: Навигация на страницу оформения покупки (сначала нужна Юкасса)
        onTap: () {},
      ),
    );
  }
}

/// Содержание страницы.
class _Content extends StatelessWidget {
  const _Content(this.description);

  final StatusDescription description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical32,
      child: Column(
        children: [
          _Benefits(description.benefits),
          AppBoxes.kHeight32,
          _ActivationOptionsWidget(description.activationOptions),
        ],
      ),
    );
  }
}

/// Блок с преимуществами подписки.
class _Benefits extends StatelessWidget {
  const _Benefits(this.benefits);

  final List<BenefitDescription> benefits;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          t.vip.benefitsTitle,
          style: context.textStyle.headingTypo.h2,
        ),
        AppBoxes.kHeight24,
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppBorders.kCircular12,
            color: context.colors.mainColors.bgCard,
          ),
          child: ListView.separated(
            padding: AppInsets.kHorizontal12 + AppInsets.kVertical4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final BenefitDescription benefit = benefits[index];
              return _BenefitTileWidget(
                title: benefit.title,
                description: benefit.description,
              );
            },
            separatorBuilder: (_, __) =>
                Divider(color: context.colors.otherColors.separator30),
            itemCount: benefits.length,
          ),
        ),
      ],
    );
  }
}

/// Плитка с пунктом преимущества.
class _BenefitTileWidget extends StatelessWidget {
  const _BenefitTileWidget({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kVertical12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppInsets.kTop6,
            child: Assets.images.star.image(
              width: AppSizes.kGeneral32,
              height: AppSizes.kGeneral32,
            ),
          ),
          AppBoxes.kWidth12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context.textStyle.textTypo.tx1SemiBold,
                  overflow: TextOverflow.clip,
                ),
                AppBoxes.kHeight8,
                Text(
                  description,
                  style: context.textStyle.textTypo.tx2Medium.withColor(
                    context.colors.textColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Виджет выбора опции активации.
class _ActivationOptionsWidget extends StatefulWidget {
  const _ActivationOptionsWidget(this.options);

  final List<ActivationOption>? options;

  @override
  State<_ActivationOptionsWidget> createState() =>
      _ActivationOptionsWidgetState();
}

class _ActivationOptionsWidgetState extends State<_ActivationOptionsWidget> {
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

    final ActivationOption first = widget.options![0];
    final ActivationOption second = widget.options![1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.vip.chooseOption,
          style: context.textStyle.headingTypo.h3,
        ),
        AppBoxes.kHeight16,
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

  final Color bgColor;
  final String totalPrice;
  final String monthlyPrice;
  final String title;
  final String? label;
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
              totalPrice + t.common.rub,
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
              monthlyPrice + t.vip.forMonth,
              style: context.textStyle.textTypo.tx1SemiBold,
            ),
          ],
        ),
      ),
    );
  }
}
