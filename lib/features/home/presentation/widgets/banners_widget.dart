import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/features/home/domain/models/banner.dart';
import 'package:niagara_app/features/home/presentation/cubit/banners_cubit.dart';

class BannersSliderWidget extends HookWidget {
  const BannersSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersCubit, BannersState>(
      builder: (context, state) => state.maybeWhen(
        loaded: _Loaded.new,
        loading: AppCenterLoader.new,
        orElse: SizedBox.shrink,
      ),
    );
  }
}

class _Loaded extends HookWidget {
  const _Loaded(this.banners);

  final List<Banner> banners;

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
  const BannerWidget(this.banner);

  final Banner banner;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      banner.imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
