import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
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
        ColoredBox(
          color: context.colors.mainColors.bgCard,
          child: CarouselSlider(
            items: _items
                .map(
                  (item) => ClipRRect(
                    borderRadius: BorderRadius.circular(AppConst.kCommon16),
                    child: item,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              viewportFraction: AppConst.kCommon1,
              autoPlay: _items.isNotEmpty,
              autoPlayInterval: Duration(seconds: AppConst.kCommon12.toInt()),
              onPageChanged: (current, _) => active.value = current,
            ),
          ),
        ),
        Positioned(
          bottom: AppConst.kCommon0,
          left: AppConst.kCommon0,
          right: AppConst.kCommon0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _items.map((url) {
              final index = _items.indexOf(url);
              return AnimatedContainer(
                duration: Durations.medium1,
                width: active.value == index
                    ? AppConst.kCommon32
                    : AppConst.kCommon6,
                height: AppConst.kCommon6,
                margin:
                    AppConst.kCommon12.vertical + AppConst.kCommon4.horizontal,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConst.kCommon4),
                  color: context.colors.mainColors.white.withOpacity(
                    active.value == index
                        ? AppConst.kCommon1
                        : AppConst.kCommon8 / AppConst.kCommon12,
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
          left: AppConst.kCommon16,
          bottom: AppConst.kCommon0,
          right: AppConst.kCommon16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: AppConst.kCommon4.toInt(),
                child: Assets.images.banners.first.text
                    .image()
                    .padding(bottom: AppConst.kCommon32),
              ),
              AppConst.kCommon32.horizontalBox,
              Flexible(
                flex: AppConst.kCommon2.toInt(),
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
          top: AppConst.kCommon0,
          bottom: AppConst.kCommon0,
          right: AppConst.kCommon0,
          child: Assets.images.banners.second.image.image(),
        ),
        Positioned(
          top: AppConst.kCommon16,
          left: AppConst.kCommon16,
          bottom: AppConst.kCommon32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: Assets.images.banners.second.text.image()),
              AppConst.kCommon48.verticalBox,
              DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colors.mainColors.white
                      .withOpacity(AppConst.kCommon04),
                  borderRadius: BorderRadius.circular(AppConst.kCommon4),
                ),
                child: Text(
                  // TODO(Oleg): Уточнить по дате начисления годовых бонусов
                  'Начислим 20.06',
                  style: context.textStyle.captionTypo.c1
                      .withColor(context.colors.textColors.white),
                ).paddingSymmetric(
                  vertical: AppConst.kCommon4,
                  horizontal: AppConst.kCommon6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
