import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/common/presentation/widgets/app_network_image_widget.dart';
import '../../../../core/common/presentation/widgets/loaders/app_center_loader.dart';
import '../../../../core/utils/constants/app_borders.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../domain/models/banner.dart';
import '../cubit/banners_cubit.dart';

/// Слайдер с баннерами для главной страницы
class BannersSliderWidget extends HookWidget {
  const BannersSliderWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<BannersCubit, BannersState>(
        builder: (context, state) => state.maybeWhen(
          loaded: _Loaded.new,
          loading: () => const AspectRatio(
            aspectRatio: 16 / 9,
            child: AppCenterLoader(),
          ),
          orElse: SizedBox.shrink,
        ),
      );
}

/// Виджет для отображения баннеров
class _Loaded extends HookWidget {
  const _Loaded(this.banners);

  /// Баннеры
  final List<Banner> banners;

  /// Обрезка изображения
  Widget _clipper(Widget widget) => ClipRRect(
        borderRadius: AppBorders.kCircular16,
        child: widget,
      );

  @override
  Widget build(BuildContext context) {
    final active = useState(0);

    final List<Widget> items = banners.map(BannerWidget.new).toList();
    return Stack(
      children: [
        CarouselSlider(
          items: items.map(_clipper).toList(),
          options: CarouselOptions(
            viewportFraction: AppSizes.kGeneral1,
            autoPlay: items.isNotEmpty,
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
            children: items.map((url) {
              final index = items.indexOf(url);

              return AnimatedContainer(
                duration: Durations.medium1,
                width: active.value == index
                    ? AppSizes.kGeneral32
                    : AppSizes.kGeneral6,
                height: AppSizes.kGeneral6,
                margin: AppInsets.kVertical12 + AppInsets.kHorizontal4,
                decoration: BoxDecoration(
                  borderRadius: AppBorders.kCircular4,
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

class BannerWidget extends StatelessWidget {
  const BannerWidget(this.banner, {super.key});

  final Banner banner;

  VoidCallback _getOnTapCallback(BuildContext context) {
    switch (banner.type) {
      case BannerType.product:
        return () async => context.navigateTo(
              banner.product != null
                  ? ProductRoute(product: banner.product!)
                  : const CatalogWrapper(),
            );
      case BannerType.offers:
        return () async => context.navigateTo(const CatalogWrapper());
      case BannerType.web:
        if (banner.link == null) return () {};

        final uri = Uri.tryParse(banner.link!);
        return () async {
          if (uri != null && await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        };
      default:
        return () {};
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _getOnTapCallback(context),
        child: AppNetworkImageWidget(
          url: banner.imageUrl,
          width: double.infinity,
          height: double.infinity,
        ),
      );
}
