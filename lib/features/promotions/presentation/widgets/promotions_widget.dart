import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/promotions/domain/models/promotion.dart';
import 'package:niagara_app/features/promotions/presentation/cubit/promotions_cubit.dart';
import 'package:niagara_app/features/promotions/presentation/widgets/promotion_widget.dart';

class PromotionsWidget extends StatelessWidget {
  const PromotionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<PromotionsCubit>(param1: false),
      child: BlocBuilder<PromotionsCubit, PromotionsState>(
        builder: (_, state) => state.maybeWhen(
          orElse: SizedBox.shrink,
          loading: () => Center(
            child: Padding(
              padding: AppInsets.kVertical64 + AppInsets.kVertical2,
              child: Assets.lottie.loadCircle.lottie(
                width: AppSizes.kGeneral64,
                height: AppSizes.kGeneral64,
                repeat: true,
              ),
            ),
          ),
          loaded: _PromotionsContent.new,
        ),
      ),
    );
  }
}

class _PromotionsContent extends HookWidget {
  const _PromotionsContent(
    this.promotions,
  );

  final List<Promotion> promotions;

  @override
  Widget build(BuildContext context) {
    final active = useState(0);

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: promotions.length,
          itemBuilder: (_, index, __) => PromotionWidget(
            promotion: promotions[index],
          ),
          options: CarouselOptions(
            viewportFraction: AppSizes.kGeneral1,
            autoPlay: true,
            autoPlayInterval: Duration(
              seconds: AppSizes.kGeneral8.toInt(),
            ),
            onPageChanged: (index, _) => active.value = index,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: promotions.map((url) {
            final index = promotions.indexOf(url);
            return AnimatedContainer(
              duration: Durations.medium1,
              width: active.value == index
                  ? AppSizes.kGeneral32
                  : AppSizes.kGeneral6,
              height: AppSizes.kGeneral6,
              margin: AppInsets.kHorizontal4,
              decoration: BoxDecoration(
                borderRadius: AppBorders.kCircular4,
                color: active.value == index
                    ? context.colors.mainColors.primary
                    : context.colors.mainColors.light,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
