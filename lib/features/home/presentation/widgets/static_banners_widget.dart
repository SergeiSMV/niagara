import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class StaticBannersWidget extends HookWidget {
  const StaticBannersWidget({super.key});

  static const _items = [
    _FirstBanner(),
    _SecondBanner(),
  ];

  @override
  Widget build(BuildContext context) {
    final active = useState(0);

    return Stack(
      children: [
        CarouselSlider(
          items: _items
              .map(
                (item) => ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.kGeneral16),
                  child: item,
                ),
              )
              .toList(),
          options: CarouselOptions(
            viewportFraction: AppSizes.kGeneral1,
            autoPlay: _items.isNotEmpty,
            autoPlayInterval: Duration(seconds: AppSizes.kGeneral12.toInt()),
            onPageChanged: (current, _) => active.value = current,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _items.map((url) {
              final index = _items.indexOf(url);
              return AnimatedContainer(
                duration: Durations.medium1,
                width: active.value == index
                    ? AppSizes.kGeneral32
                    : AppSizes.kGeneral6,
                height: AppSizes.kGeneral6,
                margin: AppInsets.kVertical12 + AppInsets.kHorizontal4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.kGeneral4),
                  color: context.colors.mainColors.white.withOpacity(
                    active.value == index
                        ? AppSizes.kGeneral1
                        : AppSizes.kGeneral8 / AppSizes.kGeneral12,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _FirstBanner extends StatelessWidget {
  const _FirstBanner();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.images.banners.first.waterfallBanner.image(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          left: AppSizes.kGeneral16,
          bottom: 0,
          right: AppSizes.kGeneral16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: AppSizes.kGeneral4.toInt(),
                child: Padding(
                  padding: AppInsets.kBottom32,
                  child: Assets.images.banners.first.text.image(),
                ),
              ),
              AppBoxes.kWidth32,
              Flexible(
                flex: AppSizes.kGeneral2.toInt(),
                child: Assets.images.banners.first.imageBottles.image(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SecondBanner extends StatelessWidget {
  const _SecondBanner();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF52B0CE),
                  Color(0xFF00348F),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        Assets.images.banners.second.bg.image(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: Assets.images.banners.second.image.image(),
        ),
        Positioned(
          top: AppSizes.kGeneral16,
          left: AppSizes.kGeneral16,
          bottom: AppSizes.kGeneral32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: Assets.images.banners.second.text.image()),
              AppBoxes.kHeight48,
              DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colors.mainColors.white.withOpacity(.4),
                  borderRadius: BorderRadius.circular(AppSizes.kGeneral4),
                ),
                child: Padding(
                  padding: AppInsets.kVertical4 + AppInsets.kHorizontal6,
                  child: Text(
                    // TODO(Oleg): Уточнить по дате начисления годовых бонусов
                    'Начислим 20.06',
                    style: context.textStyle.captionTypo.c1
                        .withColor(context.colors.textColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
